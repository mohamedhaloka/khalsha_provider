import 'package:get_storage/get_storage.dart';
import 'package:khalsha/core/data/source/local/core_local_data_source.dart';

class IntroHintCountLocal
    extends CoreLocalDataSource<Map<String, dynamic>, String> {
  IntroHintCountLocal._();

  static IntroHintCountLocal instance = IntroHintCountLocal._();

  var storage = GetStorage();

  @override
  Future<void> save(String data) async {
    final Map<String, dynamic> introsMap = get();
    introsMap[data] = (introsMap[data] ?? 0) + 1;
    await storage.write('into_count', introsMap);
  }

  @override
  Map<String, dynamic> get() {
    Map<String, dynamic> data =
        storage.read('into_count') ?? <String, dynamic>{};
    return data;
  }

  @override
  void remove() {
    storage.remove('into_count');
  }
}
