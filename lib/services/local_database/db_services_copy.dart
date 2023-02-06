import 'package:f_logs/f_logs.dart' as log;
import 'package:sembast/sembast.dart';

import '../../modules/app/model/app_data.dart';
import '../../utils/config.dart';
import 'db.dart';
// import 'database_constants.dart';

class DatabaseServices {
  var key = '';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _appsStore = intMapStoreFactory.store(storeName);

  late Database _db;

  // Singleton accessor
  DatabaseServices(password) {
    db(password);
  }



  Future<Database> db(String password) async{
    _db = await LocalDatabase.db.database(password);
    return _db;
  }

  close() {
    _db.close();
  }

  saveToken(String token)  {
     _appsStore.record(0).add( _db, {'id_token': token});
  }

   deleteToken()  {
    final finder = Finder(filter: Filter.byKey(0));
    return ( _appsStore.delete( _db, finder: finder));
  }

  String fetchToken()  {
    final finder = Finder(filter: Filter.byKey(0));
    Map<String, Object?> value = {'id_token': ''};
    String token = '';
    /* try {
      var v = ( _appsStore.find( _db, finder: finder));
      value = v;
      token = value['id_token'].toString();
    } catch (e) {
      log.FLog.info(text: e.toString());
    } */
    return token;
  }

  Future<dynamic> fetchObject(key) async {
    final finder = Finder(filter: Filter.byKey(key));
    try {
      return (await _appsStore.find( _db, finder: finder)).first;
    } catch (e) {
      log.FLog.info(text: e.toString());
    }
  }

  // _db functions:--------------------------------------------------------------
  Future<int> insert(AppData appData) async {
    return await _appsStore.add( _db, appData.toMap());
  }

  ///
  Future<int> insertObject(Map<String, dynamic> data) async {
    return await _appsStore.add( _db, data);
  }

  Future<Map<String, Object?>> fetch(String key) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(key));
    Map<String, Object?>? value;

    try {
      value = (await _appsStore.findFirst( _db, finder: finder))!.value;
    } catch (e) {
      value = {'id_token': ''};
    }

    return value;
  }

  Future<int> update(AppData appData) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(appData.id));
    return await _appsStore.update(
       _db,
      appData.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(AppData appData) async {
    final finder = Finder(filter: Filter.byKey(appData.id));
    return await _appsStore.delete(
       _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _appsStore.drop(
       _db,
    );
  }

  Future<List<AppData>> getAllSortedByFilter(
      {required List<Filter> filters}) async {
    //creating finder
    final finder = Finder(
        filter: Filter.and(filters),
        sortOrders: [SortOrder(fieldId)]);

    final recordSnapshots = await _appsStore.find(
       _db,
      finder: finder,
    );

    // Making a List<AppData> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final appData = AppData.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      appData.id = snapshot.key;
      return appData;
    }).toList();
  }

  Future<List<AppData>> getAllAppDatas() async {
    final recordSnapshots = await _appsStore.find(
       _db,
    );

    // Making a List<AppData> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final appData = AppData.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      appData.id = snapshot.key;
      return appData;
    }).toList();
  }
}
