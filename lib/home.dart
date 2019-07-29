import 'dart:math' as math;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _animateController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animateController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this
    );
    _animation = Tween<double>(begin: 1, end: 0).animate(_animateController)
      ..addListener((){
        setState(() {});
      })
      ..addStatusListener((status){
        if ( status == AnimationStatus.completed ) {
          _animateController.reverse();
          //_animateController.reset();
        }
      });
  }

  @override
  void dispose() {
    _animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Anim test'),
      // ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          children: [
            Text('Titulo', style: TextStyle(fontSize: 16)),
            Transform.rotate(
              angle: (1 - _animation.value) * math.pi * 2.0,
              child: Text('Hola', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              alignment: Alignment.center,
            ),
//            Transform.scale(
//              alignment: Alignment.center,
//              scale: _animation.value,
//              child: Text('Hola', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
            // Transform(
            //   transform: Matrix4.rotationX(_animation.value),
            //   child: Text('Hola', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
            // ),
            RaisedButton(
              child: Text('Start'),
              onPressed: () {
                _animateController.forward();
              },
            )
          ]
        ),
      ),
    );
  }
}
