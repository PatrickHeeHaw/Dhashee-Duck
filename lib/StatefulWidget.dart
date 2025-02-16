
import 'package:flutter/material.dart';

class DunkWidget extends StatelessWidget {
  const DunkWidget({Key? key}) : super(key: key);

  _onPressed() {
    print('Dunk Contest');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                    ),
                    Image(image: AssetImage("assets/Duck.png"), width: 100, height: 100),
                  ],
                ),
              ),
              Text('Contest'),
              ElevatedButton(
                onPressed: _onPressed,
                child: Text('Enter'),
              ),
            ],
      
      ),
    );
  }
}