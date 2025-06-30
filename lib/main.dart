
import 'package:backbaseassignment/injection_container.dart' as di;
import 'package:backbaseassignment/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await di.init();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Finder',
      home: SearchPage(), // Your search page
    );
  }
}