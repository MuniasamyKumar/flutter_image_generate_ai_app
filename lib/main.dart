import 'package:flutter/material.dart';
import 'package:image_generate_ai_app/features/prompt/ui/create_prompt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900  ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900
      ),
      home: CreatePromptScreen(),
    );
  }
}