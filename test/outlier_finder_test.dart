import 'package:flutter_test/flutter_test.dart';
import 'package:evenoddfinder/services/outlier_finder.dart';

void main(){
  group('OutlierFinder', () {
    final finder = OutlierFinder();

    test("findN returns correct outlier", () {
      final numbers = [2,4,-6,8,10,11];
      final result = finder.findN(numbers);
      expect(result, 11);
    });

    test("findN returns correct outlier", () {
      final numbers = [2,4,-6,8,10,-11];
      final result = finder.findN(numbers);
      expect(result, -11);
    });

    test('throws ArgumentError if list has less than 3 args', () {
      final numbers = [0,1];
      expect (() => finder.findN(numbers), throwsA(isA<ArgumentError>()));
    });

    test('throws StateError if more than one outlier', () {
      final numbers = [1,2,3,4,5,6,7];
      expect(() => finder.findN(numbers), throwsA(isA<StateError>()));
    });


  });
}