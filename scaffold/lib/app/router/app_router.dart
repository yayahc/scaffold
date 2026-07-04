import 'package:go_router/go_router.dart';

import '../../features/content/presentation/pages/content_detail_page.dart';
import '../../features/content/presentation/pages/content_list_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/library',
        name: 'library',
        builder: (context, state) => const ContentListPage(),
      ),
      GoRoute(
        path: '/content/:id',
        name: 'content',
        builder: (context, state) =>
            ContentDetailPage(id: state.pathParameters['id']!),
      ),
    ],
  );
}
