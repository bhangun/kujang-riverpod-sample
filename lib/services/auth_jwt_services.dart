import 'dart:async';
import 'dart:convert';

import 'package:f_logs/f_logs.dart' as log;
import 'package:flutter/services.dart';
import 'package:riverpod_sample/modules/user/model/user.dart';

import 'local_database/db_services.dart';
import 'network/rest_services.dart';

class AuthServices {

  late DatabaseServices db;
  /// Path authenticate,
  /// Post authorize & Get isAuthorize
  static Future<int> login(String _username, String _password,
      [bool _rememberMe = false]) async {
 
        try{

        }catch(e){
          log.FLog.info(text: e.toString());
        }
    /* var body = jsonEncode({
      "username": _username,
      "password": _password,
      "rememberMe": _rememberMe
    });
    var data = await RestServices.post('authenticate', body);
    if (data.runtimeType.toString() ==
        '_InternalLinkedHashMap<String, dynamic>') {
      String _token = data['id_token'];
      db.saveToken(_token);
      return "SUCCESS";
    } else {
      return data;
    } 
    */

    
    for (var user in await userStatic()) {
      if (user.username == _username && user.password == _password) {
        //return await db.insertObject({"user":user.id});
       // return 'SUCCESS';
      }
    }
    return 0;
    //return 'unauthorized';
  }

  

  static Future<List<User>> userStatic() async{
    return  User.listFromJson(
        json.decode(await rootBundle.loadString('assets/data/users.json')));
  }

  static Future<String> fetchToken() async {
    String token = ''; //await dbs.fetchToken();
    return token;
  }

  static void logout() {
    log.FLog.debug(text: 'logout');
  //  db.deleteToken();
  }

  /// changePassword
  static changePassword(String currentPassword, String newPassword) async {
    var body =
        '{"currentPassword": "$currentPassword","newPassword": "$newPassword"}';
    await RestServices.post('account/change-password', body);
  }

  /// Get getAuthorities
  static authorities() async {
    return await RestServices.fetch('users/authorities');
  }

  /// Path activate
  /// GET activateAccount
  static activate(String key) async {
    var body = " ?key=";
    await RestServices.post('activate?key=' + key, body);
  }

  /// Path account/reset-password/finish
  /// POST finishPasswordReset
  static resetPasswordFinish(String key, String newPassword) async {
    var body = '{"key": "$key","newPassword": "$newPassword"}';
    await RestServices.post('account/reset-password/finish', body);
  }

  /// Path account/reset-password/init
  /// POST requestPasswordReset
  static resetPasswordInit(String email) async {
    await RestServices.post('account/reset-password/init', email);
  }
}
