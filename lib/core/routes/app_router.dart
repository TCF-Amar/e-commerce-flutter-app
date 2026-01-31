import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_state.dart';
import 'package:flutter_e_commerce/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter_e_commerce/features/products/presentation/pages/product_category_page.dart';
import 'package:flutter_e_commerce/features/products/presentation/pages/product_details_page.dart';
import 'package:flutter_e_commerce/features/products/presentation/pages/product_search_page.dart';
import 'package:flutter_e_commerce/features/zShared/pages/error_page.dart';
import 'package:flutter_e_commerce/features/zShared/pages/splash_page.dart';
// import 'package:flutter_e_commerce/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_e_commerce/features/auth/presentation/pages/login_page.dart';

class AppRouter {
  static final AuthSessionManager authSessionManager = Get.find();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash.path,

    refreshListenable: authSessionManager,
    redirect: (context, state) {
      final status = authSessionManager.status;
      final location = state.matchedLocation;

      if (status == AuthStatus.unknown) {
        return location == AppRoutes.splash.path ? null : AppRoutes.splash.path;
      }

      if (status == AuthStatus.unauthenticated) {
        if (location == AppRoutes.login.path ||
            location == AppRoutes.register.path) {
          return null;
        }
        return AppRoutes.login.path;
      }

      if (status == AuthStatus.authenticated) {
        if (location == AppRoutes.login.path ||
            location == AppRoutes.splash.path ||
            location == AppRoutes.register.path) {
          return AppRoutes.dashboard.path;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        name: AppRoutes.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard.path,
        name: AppRoutes.dashboard.name,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.category.path,
        name: AppRoutes.category.name,
        builder: (context, state) => ProductCategoryPage(
          category: int.parse(state.uri.queryParameters['category']!),
        ),
      ),
      GoRoute(
        path: AppRoutes.search.path,
        name: AppRoutes.search.name,
        builder: (context, state) => ProductSearchPage(),
      ),
      // GoRoute(
      //   path: AppRoutes.wishlist.path,
      //   name: AppRoutes.wishlist.name,
      //   builder: (context, state) => const WishlistPage(),
      // ),
      GoRoute(
        path: AppRoutes.cart.path,
        name: AppRoutes.cart.name,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: AppRoutes.productDetails.path,
        name: AppRoutes.productDetails.name,
        builder: (context, state) =>
            ProductDetailsPage(slug: state.uri.queryParameters['slug']!),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),

    debugLogDiagnostics: true,
  );
}

//go router 

