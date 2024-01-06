import 'package:anu3/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupHomePage extends ConsumerStatefulWidget {
  const GroupHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends ConsumerState<GroupHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ANU'),
          elevation: 8.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You have no groups',
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextButton(
                style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                onPressed: () {
                  context.pushNamed(createGroupRoute);
                  if (kDebugMode) {
                    print('create group page');
                  }
                },
                child: const Text("Create a group"),
              ),
              TextButton(
                style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                onPressed: () {
                  if (kDebugMode) {
                    print('Join group page');
                  }
                },
                child: const Text("Join a group"),
              ),
            ],
          ),
        ));
  }
}
