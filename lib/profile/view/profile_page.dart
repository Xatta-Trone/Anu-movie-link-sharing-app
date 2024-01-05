import 'package:anu3/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider).asData?.value;

    logout() {
      ref.read(authRepositoryProvider).logout();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 8.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(user?.userMetadata?['name'] ?? ''),
            Text(user?.email ?? ''),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
