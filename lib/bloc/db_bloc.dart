import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../services/local_database/db.dart';

final dbBloc = FutureProvider<DBBloc>((ref) => DBBloc(ref: ref));

class DBBloc {
  Ref ref;
  DBBloc({required this.ref});
  static var key = '';
  Future<Database> get session async => await LocalDatabase.db.database(key);

  void close() async {
    (await session).close();
  }

  Future<Database> setDBKey(String password) {
    key = password;
    return session;
  }
}
