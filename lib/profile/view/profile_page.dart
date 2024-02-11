import 'package:anu3/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

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
            const SizedBox(
              height: 5.0,
            ),
            Text(user?.userMetadata?['name'] ?? ''),
            const SizedBox(
              height: 5.0,
            ),
            Text(user?.email ?? ''),
            // Text(user?.id ?? ''),
            const SizedBox(
              height: 5.0,
            ),
            FilledButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),

            const SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () => _launchUrl('https://www.freeprivacypolicy.com/live/091f38cc-4405-4e9c-bc8f-f3b145bde22f'),
                child: const Text('Privacy Policy')),
          ],
        ),
      ),
    );
  }
}
