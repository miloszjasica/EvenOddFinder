import 'package:flutter/material.dart';
import '../services/outlier_finder.dart';
import '../widgets/result_widget.dart';
import '../services/input_parser.dart';
import '../services/history_service.dart';
import '../models/history_item.dart';
import '../widgets/history_widget.dart';
import '../services/find_outlier_service.dart';

class HomeScreen extends StatefulWidget {
  final FindOutlierService findOutlierService;
  final HistoryService historyService;

  const HomeScreen({
    super.key,
    required this.findOutlierService,
    required this.historyService,
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
      final outlier = widget.findOutlierService.execute(
        _controller.text,
      );

      setState(() {
        _result = outlier;
      });

      _historyKey.currentState?.scrollToTop();

    } on ArgumentError catch (e) {
      _showError(e.message);
    } on StateError catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Błędne dane wejściowe!');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        duration: const Duration(seconds: 3),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final historyItems = widget.historyService.items;

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
                  child: const Text('Wyszukaj', style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const Center(
                child: Text(
                  'Historia',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
