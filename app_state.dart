import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _income = (await secureStorage.getStringList('ff_income'))
              ?.map(int.parse)
              .toList() ??
          _income;
    });
    await _safeInitAsync(() async {
      _spending = (await secureStorage.getStringList('ff_spending'))
              ?.map(int.parse)
              .toList() ??
          _spending;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  List<int> _income = [52, 135, 162, 592, 103, 502];
  List<int> get income => _income;
  set income(List<int> _value) {
    _income = _value;
    secureStorage.setStringList(
        'ff_income', _value.map((x) => x.toString()).toList());
  }

  void deleteIncome() {
    secureStorage.delete(key: 'ff_income');
  }

  void addToIncome(int _value) {
    _income.add(_value);
    secureStorage.setStringList(
        'ff_income', _income.map((x) => x.toString()).toList());
  }

  void removeFromIncome(int _value) {
    _income.remove(_value);
    secureStorage.setStringList(
        'ff_income', _income.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromIncome(int _index) {
    _income.removeAt(_index);
    secureStorage.setStringList(
        'ff_income', _income.map((x) => x.toString()).toList());
  }

  void updateIncomeAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _income[_index] = updateFn(_income[_index]);
    secureStorage.setStringList(
        'ff_income', _income.map((x) => x.toString()).toList());
  }

  void insertAtIndexInIncome(int _index, int _value) {
    _income.insert(_index, _value);
    secureStorage.setStringList(
        'ff_income', _income.map((x) => x.toString()).toList());
  }

  List<int> _spending = [12, -15, -502, 14, -205];
  List<int> get spending => _spending;
  set spending(List<int> _value) {
    _spending = _value;
    secureStorage.setStringList(
        'ff_spending', _value.map((x) => x.toString()).toList());
  }

  void deleteSpending() {
    secureStorage.delete(key: 'ff_spending');
  }

  void addToSpending(int _value) {
    _spending.add(_value);
    secureStorage.setStringList(
        'ff_spending', _spending.map((x) => x.toString()).toList());
  }

  void removeFromSpending(int _value) {
    _spending.remove(_value);
    secureStorage.setStringList(
        'ff_spending', _spending.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromSpending(int _index) {
    _spending.removeAt(_index);
    secureStorage.setStringList(
        'ff_spending', _spending.map((x) => x.toString()).toList());
  }

  void updateSpendingAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _spending[_index] = updateFn(_spending[_index]);
    secureStorage.setStringList(
        'ff_spending', _spending.map((x) => x.toString()).toList());
  }

  void insertAtIndexInSpending(int _index, int _value) {
    _spending.insert(_index, _value);
    secureStorage.setStringList(
        'ff_spending', _spending.map((x) => x.toString()).toList());
  }

  DateTime? _morning;
  DateTime? get morning => _morning;
  set morning(DateTime? _value) {
    _morning = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
