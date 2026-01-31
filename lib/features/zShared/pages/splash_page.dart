import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthSessionManager _session = Get.find<AuthSessionManager>();

  @override
  void initState() {
    super.initState();

    //  app start session restore
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      _session.restoreSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
