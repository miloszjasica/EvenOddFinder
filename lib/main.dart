import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/outlier_finder.dart';
import 'services/input_parser.dart';
import 'services/history_service.dart';
import 'services/find_outlier_service.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final historyService = HistoryService();
    final parser = InputParser();
    final finder = OutlierFinder();

    final findOutlierService = FindOutlierService(
      parser: parser,
      finder: finder,
      history: historyService,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),

      home: HomeScreen(
        findOutlierService: findOutlierService,
        historyService: historyService,
      ),
    );
  }
}
