import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class DuckWidget extends StatefulWidget {
  const DuckWidget({super.key});

  @override
  _DuckWidgetState createState() => _DuckWidgetState();
}

class _DuckWidgetState extends State<DuckWidget> {
  double _health = 1.0; // Health value between 0.0 and 1.0
  late Timer _timer;
  int _animationFrame = 0; // Index to track the current animation frame
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  final List<String> _duckWalkingImages = [
    "assets/DuckWalk1.png",
    "assets/DuckWalk2.png",
    "assets/DuckWalk3.png",
  ]; // List of walking animation images

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
    _startGyroscopeListener(); // Start listening to gyroscope events
  }

  // Listen to gyroscope events for rotation
  void _startGyroscopeListener() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // If the rotation (change in angle) is significant (threshold can be adjusted)
      if (event.x.abs() > 0.5 || event.y.abs() > 0.5 || event.z.abs() > 0.5) {
        _addHealth(); // Add health when rotation is detected
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _health -= 0.01; // Reduce health by 0.01 every 500ms
        _animationFrame = _health > 0.40 ? (_animationFrame + 1) % 2 : (_animationFrame + 1) % 3;
        if (_health <= 0) {
          _health = 0; // Ensure health doesn't go below 0
          _timer.cancel(); // Stop the timer when health reaches 0
        }
      });
    });
  }

  // Function to reset health and restart the timer
  void _resetHealth() {
    setState(() {
      _health = 1.0; // Reset health to full
      _timer.cancel(); // Cancel existing timer
      _startTimer(); // Restart the timer
    });
  }

  // Function to add health
  void _addHealth() {
    setState(() {
      _health += 0.1; // Add 0.1 to the health
      if (_health > 1.0) {
        _health = 1.0; // Ensure health doesn't exceed 1.0
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 232, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Conditional rendering of the text
            Text(
              _health > 0 ? 'GO RUN TO SAVE HIM' : 'GG', // Display "GG" when health reaches 0
              style: const TextStyle(
                fontSize: 24, // Font size
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.black, // Text color
              ),
            ),
            const SizedBox(height: 20),
            // Conditional rendering of the duck image based on health
            _health > 0
                ? Image(
                    image: AssetImage(_duckWalkingImages[_animationFrame]), // Walking animation frames
                    width: 500,
                    height: 500,
                  )
                : const Image(
                    image: AssetImage("assets/Dead.png"), // Hurt duck image
                    width: 500,
                    height: 500,
                  ),
            const SizedBox(height: 20),
            // Health bar container
            Container(
              width: 200,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _health, // Width based on health value
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Reset Button
            ElevatedButton(
              onPressed: _resetHealth, // Calls the reset function
              child: const Text('Reset Health'),
            ),
            const SizedBox(height: 10),
            // Add Health Button
            ElevatedButton(
              onPressed: _addHealth, // Calls the add health function
              child: const Text('Add Health'),
            ),
          ],
        ),
      ),
    );
  }
}
