import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:riverpod_sample/bloc/db_bloc.dart';
import 'package:sembast/sembast.dart';

import 'fake_directory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('db_group', () {
    setUp(() async {
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });
    test('db', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      AsyncValue<DBBloc> dbf = container.read(dbBloc);

      var db = await dbf.asData?.value.setDBKey('mkmk');

      // Define the store
      var store = StoreRef<String, String>.main();
      // Define the record
      var record = store.record('my_key');
      var dbc = (db) as DatabaseClient;
      // Write a record
      await record.put(dbc, 'my_value');

      // Verify record content.
      expect(await record.get(dbc), 'my_value');
      // Define the record
      db?.close();
    });
  });
}
