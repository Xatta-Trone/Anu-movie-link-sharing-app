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
            CircleAvatar(
              radius: 50.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(user?.userMetadata?['avatar_url'] ?? "https://placehold.jp/150x150.png"),
              ),
            ),
            Text(user?.userMetadata?['name'] ?? ''),
            Text(user?.email ?? ''),
            // Text(user?.id ?? ''),
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
