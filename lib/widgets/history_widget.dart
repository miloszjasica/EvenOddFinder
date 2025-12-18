import 'package:flutter/material.dart';
import '../models/history_item.dart';

class HistoryWidget extends StatefulWidget {
  final List<HistoryItem> history;

  const HistoryWidget({super.key, required this.history});

  @override
  State<HistoryWidget> createState() => HistoryWidgetState();
}

class HistoryWidgetState extends State<HistoryWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatNumbers(List<int> numbers) {
    if (numbers.length <= 8) return numbers.join(', ');
    return '${numbers.take(7).join(', ')} ... ${numbers.last}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.history.length,
      itemBuilder: (context, index) {
        final item = widget.history[index];
        return ListTile(
          title: Text(_formatNumbers(item.numbers)),
          trailing: Text(
            'N: ${item.outlier}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
