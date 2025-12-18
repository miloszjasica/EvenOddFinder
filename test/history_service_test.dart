import 'package:flutter_test/flutter_test.dart';
import 'package:evenoddfinder/services/history_service.dart';
import 'package:evenoddfinder/models/history_item.dart';

void main() {
  group('HistoryService', () {
    late HistoryService history;

    setUp(() {
      history = HistoryService();
    });

    test('empty list', () {
      expect(history.items, isEmpty);
    });

    test('add inserts item at the beginning', () {
      final item1 = HistoryItem(numbers: [1, 2, 3], outlier: 2);
      final item2 = HistoryItem(numbers: [1,-2,3,5,7], outlier: -2);

      history.add(item1);
      history.add(item2);

      expect(history.items.length, 2);
      expect(history.items.first, item2);
      expect(history.items.last, item1);
    });

    test('items returns immutable list', () {
      final item = HistoryItem(numbers: [1, 2], outlier: 2);
      history.add(item);

      expect(() => history.items.add(item), throwsUnsupportedError);
    });
  });
}
