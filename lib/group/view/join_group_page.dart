import 'dart:io';

import 'package:anu3/core/core.dart';
import 'package:anu3/group/api/group_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JoinGroupPage extends ConsumerStatefulWidget {
  const JoinGroupPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinGroupPageState();
}

class _JoinGroupPageState extends ConsumerState<JoinGroupPage> {
  String groupCode = "";
  bool _isSubmitting = false;

  _submit(BuildContext context) {
    if (groupCode.length != 6) {
      return;
    }
    setState(() {
      _isSubmitting = true;
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    try {
      ref.read(groupRepositoryProvider).joinGroup(groupCode: groupCode).then((group) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Joined group.')),
          );

          context.pushNamed(
            groupDetailsRoute,
            queryParameters: {
              'group_id': "${group?.id}",
            },
          );
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        );
      });
    } catch (e) {
      String message = e.toString();
      if (kDebugMode) {
        print(e);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    if (kDebugMode) {
      print(groupCode);
    }

    setState(() {
      _isSubmitting = false;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter group code',
              textScaler: TextScaler.linear(2.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            OtpTextField(
              autoFocus: true,
              numberOfFields: 6,
              focusedBorderColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              onSubmit: (String verificationCode) {
                setState(() {
                  groupCode = verificationCode;
                });
                // _submit(context);
              }, //
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting == false ? () => _submit(context) : null,
                style: FilledButton.styleFrom(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
                child: _isSubmitting ? const Text('Trying...') : const Text('Join Group'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
