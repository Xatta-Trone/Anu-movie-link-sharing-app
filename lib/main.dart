import 'package:anu3/core/core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANNON_KEY'] ?? '',
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black87,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black87,
            error: Colors.red,
            onError: Colors.black87,
            background: Colors.white,
            onBackground: Colors.black87,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            // contentPadding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.black87,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            
          ),
          toggleButtonsTheme: ToggleButtonsThemeData(
            borderColor: Colors.grey.shade200,
            selectedBorderColor: Colors.black87,
            selectedColor: Colors.white,
            fillColor: Colors.black87,
            color: Colors.black87,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            foregroundColor: Colors.white,
            elevation: 10.0,
          )
      ),
      routerConfig: router,
    );
  }
}
