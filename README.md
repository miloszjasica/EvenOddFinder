# EvenOddFinder

EvenOddFinder is a Flutter application that identifies the outlier number in a given list of integers.
The app also keeps a history of previous searches for easy reference.


### 1. Work Flow

- Enter a list comma-separated integers (e.g., 1, 2, 4, 6, 8)
- Tap the search button
- On your screen will be show outifier number
- Check your history of previous searches below

### 2. Demo

[EvenOddFinder DEMO](https://www.loom.com/share/053bd5af84484830b2c5e52c9cd58ddb)


### 3.  Tests

- OutlierFinder – checks correct outlier detection and exceptions
- InputParser – validates correct parsing and error handling
- HistoryService – ensures proper addition and ordering of history items

### 4. How to run

Clone the repository:
```bash
git clone  https://github.com/miloszjasica/EvenOddFinder.git
```

Navigate to the project directory:
```bash
cd evenoddfinder
```

Install dependencies:
```bash
flutter pub get
```

Run the app:
```bash
flutter run
```
