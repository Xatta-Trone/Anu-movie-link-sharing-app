import 'package:anu3/auth/auth.dart';
import 'package:anu3/core/core.dart';
import 'package:anu3/dashboard/dashboard.dart';
import 'package:anu3/group/group.dart';
import 'package:anu3/group/view/create_group_page.dart';
import 'package:anu3/group/view/group_detail_page.dart';
import 'package:anu3/movie/view/movie_form.dart';
import 'package:anu3/movie/view/test_form.dart';
import 'package:anu3/profile/view/profile_page.dart';
import 'package:flutter/foundation.dart';
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
      builder: (context, state) {
        final groupId = state.uri.queryParameters['group_id'];
        if (kDebugMode) {
          print('Group ID: $groupId');
        }
        return CreateGroupPage(
          groupId: groupId,
        );
      },
    ),
    GoRoute(
      name: joinGroupRoute,
      path: '/join-group',
      builder: (context, state) {
        return const JoinGroupPage();
      },
    ),
    GoRoute(
      name: groupDetailsRoute,
      path: '/group-details',
      builder: (context, state) {
        final groupId = state.uri.queryParameters['group_id'];
        if (kDebugMode) {
          print('Group ID: $groupId');
        }
        return GroupDetailPage(
          groupId: groupId,
        );
      },
    ),
    GoRoute(
      name: movieFormRoute,
      path: '/movie-form',
      builder: (context, state) {
        final groupId = state.uri.queryParameters['group_id'];
        final movieId = state.uri.queryParameters['movie_id'];
        if (kDebugMode) {
          print('Group ID: $groupId');
        }
        return MovieFormPage(
          groupId: groupId,
          movieId: movieId,
        );
      },
    ),
    GoRoute(
      name: testFormRoute,
      path: '/test-form',
      builder: (context, state) {
        return const TestForm();
      },
    ),
  ],
);
