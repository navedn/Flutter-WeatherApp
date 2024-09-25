import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In-Class #5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 249, 196),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather Info App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';
  final List<String> _weatherConditions = ['Sunny', 'Cloudy', 'Rainy'];

  void _fetchWeather() {
    final random = Random();
    int temp = 15 + random.nextInt(16);
    String condition =
        _weatherConditions[random.nextInt(_weatherConditions.length)];

    // Simulate fetching weather info
    setState(() {
      _cityName = _cityController.text;
      _temperature = '$temp°C'; // Example temperature
      _weatherCondition = condition; // Example condition
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 167, 240, 21),
        title: const Text('Weather Info App'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          SizedBox(
            width: 500, // Set the width you want
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter City Name',
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _fetchWeather,
                child: const Text('Fetch Weather'),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
            'City: $_cityName',
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Temperature: $_temperature',
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Condition: $_weatherCondition',
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
