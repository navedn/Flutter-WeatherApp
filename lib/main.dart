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
  final List<String> _weatherConditions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Snowy',
    'Windy'
  ];
  List<Map<String, String>> _sevenDayForecast = [];

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

  void _fetchSevenDayForecast() {
    final random = Random();
    List<Map<String, String>> forecast = [];

    for (int i = 0; i < 7; i++) {
      int temp = 15 + random.nextInt(16); // Random temp 15°C to 30°C
      String condition =
          _weatherConditions[random.nextInt(_weatherConditions.length)];

      // Add forecast for each day (you can add day names if needed)
      forecast.add({
        'day': 'Day ${i + 1}', // Example: Day 1, Day 2, etc.
        'temp': '$temp°C',
        'condition': condition,
      });
    }

    setState(() {
      _sevenDayForecast = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 167, 240, 21),
        title: const Text('Weather Info App'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _fetchSevenDayForecast,
                  child: const Text('7-Day Forecast'),
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
            const SizedBox(height: 20.0),
            if (_sevenDayForecast.isNotEmpty) ...[
              const Text(
                '7-Day Weather Forecast',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap:
                    true, // Important to keep it inside a scrollable column
                physics:
                    const NeverScrollableScrollPhysics(), // Avoid scrolling inside ListView
                itemCount: _sevenDayForecast.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Card(
                      child: ListTile(
                        leading: Text(
                          _sevenDayForecast[index]['day']!,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        title: Text(
                          'Temp: ${_sevenDayForecast[index]['temp']}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          'Condition: ${_sevenDayForecast[index]['condition']}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
