import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import './blocs/image_events.dart';
import './blocs/image_repository.dart';
import './blocs/image_states.dart';

import './pages/home_page.dart';
import './blocs/image_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bloc api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
