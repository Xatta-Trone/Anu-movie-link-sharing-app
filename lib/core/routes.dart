import 'package:anu3/auth/auth.dart';
import 'package:anu3/core/core.dart';
import 'package:anu3/dashboard/dashboard.dart';
import 'package:anu3/group/view/create_group_page.dart';
import 'package:anu3/profile/view/profile_page.dart';
import 'package:go_router/go_router.dart';

// final user = ref.watch(authUserProvider).asData?.value;

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardHomePage(),
    ),
    GoRoute(
      name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const MyProfile(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: createGroupRoute,
      path: '/create-group',
      builder: (context, state) => const CreateGroupPage(),
    )
  ],
);
