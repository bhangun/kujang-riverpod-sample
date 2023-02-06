


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../../../services/local_database/db.dart';

/* final dbProvider = FutureProvider<Database>((ref) async{
  
  return await LocalDatabase.db.database(key);
} */
final dbProvider = FutureProvider<DBProvider>((ref) => DBProvider(ref:ref));

class DBProvider  {
  Ref ref;
  DBProvider({required this.ref});
  static var key = '';
  Future<Database> get session async => await LocalDatabase.db.database(key);

  void close() async{
    (await session).close();
  }

  Future<Database> setDBKey(String password){
    key = password;
    return session;
  }
}