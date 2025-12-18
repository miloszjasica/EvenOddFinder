import 'package:flutter/material.dart';
import '../services/outlier_finder.dart';
import '../widgets/result_widget.dart';
import '../services/input_parser.dart';
import '../services/history_service.dart';
import '../models/history_item.dart';
import '../widgets/history_widget.dart';

class HomeScreen extends StatefulWidget {
  final OutlierFinder finder;
  final InputParser parser;
  final HistoryService history;

  const HomeScreen({
    super.key,
    required this.finder,
    required this.parser,
    required this.history,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  int? _result;
  final GlobalKey<HistoryWidgetState> _historyKey = GlobalKey<HistoryWidgetState>();

  void _findOutlier() {
    try {
      final numbers = widget.parser.parse(_controller.text);
      final outlier = widget.finder.findN(numbers);

      setState(() {
        _result = outlier;
        widget.history.add(HistoryItem(numbers: numbers, outlier: outlier));
      });

      _historyKey.currentState?.scrollToTop();

    } on ArgumentError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          duration: const Duration(seconds: 3),
        ),
      );
    } on StateError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Błędne dane wejściowe!',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final historyItems = widget.history.items;

    return Scaffold(
      appBar: AppBar(title: const Text('EvenOddFinder')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_result != null) ResultWidget(result: _result!),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Wpisz liczby oddzielone przecinkami:',
                  labelStyle: TextStyle(fontSize: 16),
                  hintText: 'np. 2, 4, 6, 8, 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _findOutlier,
                  child: const Text('Wyszukaj', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const Text(
                'Historia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 400,
                child: HistoryWidget(
                  key: _historyKey,
                  history: historyItems,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
