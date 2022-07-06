import 'package:ecommerce_app/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

enum AppRoutes {
  home,
  product,
  review,
  cart,
  checkout,
  orders,
  account,
  signIn,
  notFound,
}

final router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const ProductsListScreen(),
      //* Nested Navigation
      routes: [
        GoRoute(
          name: AppRoutes.product.name,
          path: 'product/:id',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: ProductScreen(productId: state.params['id']!),
          ),
          routes: [
            GoRoute(
              path: 'review',
              name: AppRoutes.review.name,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: LeaveReviewScreen(productId: state.params['id']!),
              ),
            ),
          ],
        ),
        GoRoute(
            name: AppRoutes.cart.name,
            //* Dont need '/' before path name when we are using nested navigation/sub-routes
            path: 'cart',
            //* Page Builder is used to access additional configurations as Transitions, etc
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const ShoppingCartScreen(),
                ),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoutes.checkout.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const CheckoutScreen(),
                ),
              ),
            ]),
        GoRoute(
          name: AppRoutes.orders.name,
          path: 'orders',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.account.name,
          path: 'account',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.signIn.name,
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
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const NotFoundScreen(),
  ),
);
