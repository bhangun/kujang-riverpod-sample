


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../../../services/local_database/db.dart';

final dbProvider = FutureProvider<DBProvider>((ref) => DBProvider(ref:ref));

class DBProvider extends ChangeNotifier {
  Ref ref;
  DBProvider({required this.ref});
  var key = '';
  Future<Database> get session async => await LocalDatabase.db.database(key);

  close() async{
    (await session).close();
  }

  setDBKey(String password){
    key = password;
  }

}