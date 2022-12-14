import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/providers/theme_provider.dart';
import 'package:asignaturas/providers/show_date_picked_provider.dart';
import 'package:asignaturas/screens/screens.dart';



void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CoursesProvider>(create: (context) => CoursesProvider(),),
      ChangeNotifierProvider<ModalProvider>(create: (context) => ModalProvider()),
      ChangeNotifierProvider<FormProvider>(create: (context) => FormProvider()),
      ChangeNotifierProvider<ShowDatePickedProvider>(create: (context) => ShowDatePickedProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Gestor de Asignaturas',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
      initialRoute: 'courses_screen',
      routes: {
        'courses_screen': (_) => const CoursesScreen(),
      },
    );
  }
}