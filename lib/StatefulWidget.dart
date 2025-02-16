import 'package:flutter/material.dart';

class DunkWidget extends StatelessWidget {
  const DunkWidget({super.key});

  onPressed() {
    print('Dahsee Duck');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 161, 232, 244),
      child: Center(
        child: Image(
          image: AssetImage("assets/Duck.png"),
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}