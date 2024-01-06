import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupHomePageBackup extends ConsumerStatefulWidget {
  const GroupHomePageBackup({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupHomePageBackupState();
}

class _GroupHomePageBackupState extends ConsumerState<GroupHomePageBackup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anu'),
        elevation: 8.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160,
                    color: Colors.red,
                  ),
                  Container(
                    width: 160,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 160,
                    color: Colors.green,
                  ),
                  Container(
                    width: 160,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 160,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Latest activity'),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.teal,
                    ),
                    title: Text('Monzurul Islam add 12th fail in Your group ', softWrap: true, textScaler: TextScaler.linear(0.9)),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
