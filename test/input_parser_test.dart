import 'package:flutter_test/flutter_test.dart';
import 'package:evenoddfinder/services/input_parser.dart';

void main() {
  group('InputParser', () {
    final parser = InputParser();

    test('parses comma-separated numbers correctly', () {
      final input = '1, 2, 3, 4';
      final result = parser.parse(input);
      expect(result, [1, 2, 3, 4]);
    });

    test('trims spaces correctly', () {
      final input = ' 1 , 2 ,3 ,    7';
      final result = parser.parse(input);
      expect(result, [1, 2, 3, 7]);
    });

    test('throws FormatException for invalid input', () {
      final input = '1, a, 3';
      expect(() => parser.parse(input), throwsFormatException);
    });

    test('handles empty input', () {
      final input = '';
      expect(() => parser.parse(input), throwsFormatException);
    });
  });
}
