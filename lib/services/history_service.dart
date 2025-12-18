import '../models/history_item.dart';

class HistoryService {
  final List<HistoryItem> _items = [];

  List<HistoryItem> get items => List.unmodifiable(_items);

  void add(HistoryItem item) {
    _items.insert(0, item);
  }
}
