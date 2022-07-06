import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'products',
      builder: (context, state) => const ProductsListScreen(),

      //* Nested Navigation
      routes: [
        GoRoute(
          name: 'cart',
          path: 'cart', //* Dont need '/' before path name when we are using nested navigation/sub-routes
          //* Page Builder is used to access additional configurations as Transitions, etc
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ShoppingCartScreen(),
          ),
        ),
        GoRoute(
          name: 'orders',
          path: 'orders',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          name: 'account',
          path: 'account',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          name: 'signIn',
          path: 'signIn',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
      ],
    ),
  ],
);
