import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_inventory/features/dashboard/presentation/dashboard_screen.dart';
import 'package:smart_inventory/features/product/presentation/product_management_screen.dart';
import 'package:smart_inventory/features/search/presentation/search_filter_screen.dart';
import 'package:smart_inventory/features/stock/presentation/stock_history_screen.dart';
import 'package:smart_inventory/features/stock/presentation/stock_update_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/product-management',
        builder: (context, state) => ProductManagementScreen(
          productId: state.uri.queryParameters['id'],
        ),
      ),
      GoRoute(
        path: '/stock-update',
        builder: (context, state) => const StockUpdateScreen(),
      ),
      GoRoute(
        path: '/stock-history',
        builder: (context, state) => const StockHistoryScreen(),
      ),
      GoRoute(
        path: '/search-filter',
        builder: (context, state) => const SearchFilterScreen(),
      ),
    ],
  );
});
