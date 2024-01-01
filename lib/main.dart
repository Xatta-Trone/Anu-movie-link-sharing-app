import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  /// TODO: update Supabase credentials with your own
  await Supabase.initialize(
    url: 'https://lkcdpzmvzxtmeykmhset.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrY2Rwem12enh0bWV5a21oc2V0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM5NTQzNzMsImV4cCI6MjAxOTUzMDM3M30.kaUhJXU866XqgyosmAMZZCpMIr3YQ9eul0XgfS1QbrA',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  User? user = supabase.auth.currentUser;

  Future<void> googleSignIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
          scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
          serverClientId: '83291086326-7323i74kf010hi7109h3ts8oa4b4kok7.apps.googleusercontent.com');

      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuthentication = await googleAccount!.authentication;
      final accessToken = googleAuthentication.accessToken;
      final idToken = googleAuthentication.idToken;
      if (kDebugMode) {
        print(googleAccount);
        print(googleAuthentication);
        print(accessToken);
        print(idToken);
      }
      // var s = supabase.auth.signInWithOAuth(OAuthProvider.google);
      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken ?? '',
        accessToken: accessToken,
      );

      setState(() {
        user = supabase.auth.currentUser;
      });

      if (kDebugMode) {
        print(user);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
        serverClientId: '83291086326-7323i74kf010hi7109h3ts8oa4b4kok7.apps.googleusercontent.com');
    await googleSignIn.signOut();
    await supabase.auth.signOut();
    setState(() {
      user = supabase.auth.currentUser;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              user?.id ?? 'not logged in',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: user == null ? googleSignIn : signOut,
        tooltip: 'Increment',
        child: Text(user == null ? 'login': 'logout'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
