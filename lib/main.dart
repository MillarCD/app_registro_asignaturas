import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/show_date_picked_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/screens/screens.dart';



void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CoursesProvider>(create: (context) => CoursesProvider(),),
      ChangeNotifierProvider<ModalProvider>(create: (context) => ModalProvider()),
      ChangeNotifierProvider<FormProvider>(create: (context) => FormProvider()),
      ChangeNotifierProvider<ShowDatePickedProvider>(create: (context) => ShowDatePickedProvider())
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
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xff00b686),
          secondary: const Color(0xff1de9b6), 
          onSecondary: const Color(0xff373737),
        ),
      ),
      initialRoute: 'courses_screen',
      routes: {
        'courses_screen': (_) => const CoursesScreen(),
      },
    );
  }
}