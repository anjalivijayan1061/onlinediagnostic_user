import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:onlinediagnostic_user/ui/screen/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nqgmuqmfbhqqbavijyzq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xZ211cW1mYmhxcWJhdmlqeXpxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODA3OTc3MSwiZXhwIjoxOTkzNjU1NzcxfQ.NtTvGsbaD3ZonuktBauJaxkb9ci5Xu3nj44e1MtzwWE',
  );

  // dynamic data = await Supabase.instance.client.rpc(
  //   'get_table_info',
  //   params: {'schema_name': 'public'},
  // );
  // log(data.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Diagnostic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.black12),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
