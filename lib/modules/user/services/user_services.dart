import 'dart:async';
import 'dart:convert';

import '../../../models/user.dart';
import '../../../services/network/rest_services.dart';


class UserServices {

  static Future<User> user(String id) async {
    var response = await RestServices.fetch('/api/user' + id);
    return User.fromJson(json.decode(response));
  }

  static Future<List<User>> users([var page, var size, var sort]) async {
    var data = await RestServices.fetch('/api/users');
    return User.listFromString(data);
  }

  static createUser(User user) async {
    
  }

  //
  static updateUser(User user) async {
    
  }

  //
  static deleteUser(int id) async {
    
  }

}