
import 'dart:ui';

import 'package:asignaturas/widgets/course_form.dart';
import 'package:flutter/material.dart';

class ModalForm extends StatelessWidget {
  const ModalForm({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return _ModalBackGround(
      size: size,
      child: _Modal(
        title: "Agregar Asignatura",
        size: size,
        child: CourseForm(),
      ),
    );
  }
}

class _ModalBackGround extends StatelessWidget {

  final Widget child;
  final Size size;

  const _ModalBackGround({
    Key? key,
    required this.size,
    required this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur( sigmaX: 1, sigmaY: 1 ),
        child: Container(
          color: Colors.red.withOpacity(0.4),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics() ,
            child: Column(
              children: [

                SizedBox(height: size.height*0.3,),

                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Modal extends StatelessWidget {

  final Widget child;
  final Size size;
  final String title;

  const _Modal({
    Key? key,
    required this.title,
    required this.size,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( 
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.yellow, width: 2)
      ),
      padding: const EdgeInsets.all(10),
      width: size.width * 0.85,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Text(title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10,),
      
            child,
      
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('cancelar', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    print('[MODAL FORM] cancelar');
                  },
                ),
                TextButton(
                  child: const Text('guardar', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    print('[MODAL FORM] guardar');
                  },
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}