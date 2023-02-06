import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_sample/services/local_database/db.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'fake_directory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PathProvider full implementation', () {
    setUp(() async {
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    test('db_test', () async {
      // In memory factory for unit test
      var db = await LocalDatabase.db.database("coba");

      // Define the store
      var store = StoreRef<String, String>.main();

      // Define the record
      var record = store.record('my_key');

      // Write a record
      await record.put(db, 'my_value');

      // Verify record content.
      expect(await record.get(db), 'my_value');

      // Close the databa
      await db.close();
    });
  });
}
