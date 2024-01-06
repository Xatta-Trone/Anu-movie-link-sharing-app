import 'package:anu3/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard_page.dart';

class DashboardHomePage extends ConsumerStatefulWidget {
  const DashboardHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends ConsumerState<DashboardHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider).asData?.value;
    return user == null ? const LoginPage() : const DashboardPage();
  }
}
