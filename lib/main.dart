import 'package:asignaturas/providers/form_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/screens/screens.dart';



void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CoursesProvider>(create: (context) => CoursesProvider(),),
      ChangeNotifierProvider<ModalProvider>(create: (context) => ModalProvider()),
      ChangeNotifierProvider<FormProvider>(create: (context) => FormProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'courses_screen',
      routes: {
        'courses_screen': (_) => const CoursesScreen(),
      },
    );
  }
}