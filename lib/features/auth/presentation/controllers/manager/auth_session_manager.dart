import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/core/storage/token_storage.dart';
import 'package:flutter_e_commerce/core/utils/token_utils.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_e_commerce/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_state.dart';
import 'package:get/get.dart';

class AuthSessionManager extends ChangeNotifier {
  final TokenStorage _storage;
  final AuthUsecase _usecase;

  bool _isRefreshing = false;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  final Rxn<UserProfileEntity> _userProfile = Rxn<UserProfileEntity>(null);
  UserProfileEntity? get userProfile => _userProfile.value;

  AuthSessionManager(this._storage, this._usecase);

  Future<bool> restoreSession() async {
    final accessToken = await _storage.getAccessToken();
    final refreshToken = await _storage.getRefreshToken();

    if (accessToken != null && !TokenUtils.isExpired(accessToken)) {
      _status = AuthStatus.authenticated;
      notifyListeners();
      debugPrint('Access token is valid');
      fetchUserProfile();
      return true;
    }

    if (refreshToken != null && !TokenUtils.isExpired(refreshToken)) {
      _status = AuthStatus.authenticated;
      notifyListeners();
      debugPrint('Refresh token is valid');
      final result = await _refresh(refreshToken);
      if (result) {
        fetchUserProfile();
      }
      return result;
    }
    debugPrint('Session is invalid');
    await clearSession();
    notifyListeners();
    return false;
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await _usecase.getUserProfile();
      result.fold(
        (failure) {
          debugPrint('Failed to fetch user profile: ${failure.message}');
          clearSession();
          _userProfile.value = null;
        },
        (userProfile) {
          debugPrint('User profile loaded: ${userProfile.email}');
          // ProductBinding.controllerInit();
          _userProfile.value = userProfile;
        },
      );
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
    }
  }

  Future<String?> refreshAccessToken() async {
    if (_isRefreshing) return null;
    _isRefreshing = true;

    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null ||
          refreshToken.isEmpty ||
          TokenUtils.isExpired(refreshToken)) {
        await clearSession();
        _status = AuthStatus.unauthenticated;
        return null;
      }
      final result = await _usecase.refreshAccessToken(refreshToken);
      return result.fold(
        (failure) {
          clearSession();
          _status = AuthStatus.unauthenticated;
          return null;
        },
        (authResponse) {
          saveSession(
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
          );
          _status = AuthStatus.authenticated;
          return authResponse.accessToken;
        },
      );
    } catch (_) {
      _status = AuthStatus.unauthenticated;
      return null;
    } finally {
      _isRefreshing = false;
      notifyListeners();
    }
  }

  Future<bool> _refresh(String refreshToken) async {
    final token = await refreshAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> saveSession({
    required String accessToken,
    String? refreshToken,
  }) async {
    _status = AuthStatus.authenticated;
    await _storage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    notifyListeners();
  }

  Future<String?> getAccessToken() async {
    return await _storage.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _storage.getRefreshToken();
  }

  Future<void> clearSession() async {
    _status = AuthStatus.unauthenticated;
    await _storage.clearTokens();
    notifyListeners();
  }
}
