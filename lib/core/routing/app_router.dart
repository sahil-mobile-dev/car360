import 'package:car_360/features/home/presentation/home_screen.dart';
import 'package:car_360/features/settings/presentation/settings_screen.dart';
import 'package:car_360/features/splash/presentation/splash_screen.dart';
import 'package:car_360/features/viewer/presentation/viewer_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/viewer', builder: (context, state) => const ViewerScreen()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
