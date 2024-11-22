import 'package:flutter/material.dart';

import '../streams/stream_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StreamSource _streamSource = StreamSource();
  int number = 0;
  Color background = Colors.white;
  late Stream<int> _intStream;
  late Stream<Color> _colorStream;

  @override
  void initState() {
    _intStream = _streamSource.createIntStream();
    _colorStream = _streamSource.createColorStream();
    listenToStream();
    listenToColorStream();
    super.initState();
  }

  void listenToStream() {
    _intStream.listen((value) {
      number = value;
      setState(() {});
    });
  }

  void listenToColorStream() async {
    await for (Color color in _colorStream) {
      background = color;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Text(
          "$number",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        listenToStream();
      }),
    );
  }
}
