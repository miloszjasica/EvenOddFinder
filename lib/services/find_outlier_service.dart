import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../services/outlier_finder.dart';
import '../services/input_parser.dart';
import '../services/history_service.dart';
import '../models/history_item.dart';

class FindOutlierService {
  final InputParser parser;
  final OutlierFinder finder;
  final HistoryService history;

  FindOutlierService({
    required this.parser,
    required this.finder,
    required this.history,
  });

  int execute(String input) {
    final numbers = parser.parse(input);
    final outlier = finder.findN(numbers);

    history.add(
      HistoryItem(numbers: numbers, outlier: outlier),
    );

    return outlier;
  }
}
