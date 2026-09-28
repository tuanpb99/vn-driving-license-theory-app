import 'package:isar/isar.dart';

class LocalDatabaseService {
  Isar? _isar;

  Isar? get db => _isar;

  Future<void> initialize({required List<CollectionSchema> schemas}) async {
    if (_isar != null) return;
    _isar = await Isar.open(schemas, inspector: false);
  }
}
