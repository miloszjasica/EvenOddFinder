class InputParser {
  List<int> parse(String input) {
    return input
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();
  }
}
