class OutlierFinder {
  int findN(List<int> numbers) {
    if (numbers.length < 3){
      throw ArgumentError("Lista musi miec przynajmniej 3 elementy!");
    }

    int evenCount = 0;
    int oddCount = 0;

    for (final n in numbers.take(3)) {
      if (n.isEven) evenCount++;
      else oddCount++;
    }
    bool lookingForEven = oddCount > evenCount;

    final outliers = numbers.where((n) => lookingForEven ? n.isEven : n.isOdd).toList();
    if (outliers.length != 1){
      throw StateError("Wartości odstające: ${outliers.length}!");
    }

    return outliers.first;
  }
}