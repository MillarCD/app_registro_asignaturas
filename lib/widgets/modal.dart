
import 'dart:ui';

import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  
  final Widget child;
  
  const Modal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return _ModalBackGround(
      size: size,
      child: _ModalForeground(
        size: size,
        child: child,
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
          color: Colors.black.withOpacity(0.4),
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

class _ModalForeground extends StatelessWidget {

  final Widget child;
  final Size size;

  const _ModalForeground({
    Key? key,
    required this.size,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
  
    return Container(
      decoration: BoxDecoration( 
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2) //color: Colors.yellow
      ),
      padding: const EdgeInsets.all(10),
      width: size.width * 0.85,
      child: child,

    );
  }
}