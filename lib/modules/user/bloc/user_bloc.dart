import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../model/index.dart';
import '../services/user_services.dart';
import '../user_routes.dart';

final userBloc = ChangeNotifierProvider<UserBloc>((ref) => UserBloc());

final userProv = FutureProvider<List<User>>((ref) async {
  final content = json.decode(
    await rootBundle.loadString('assets/data/users.json'),
  );
  return User.listFromJson(content);

});

class UserBloc extends ChangeNotifier {
  bool isListEmpty = true;

  bool isItemEmpty = true;

  bool isUpdated = false;

  bool isDeleted = false;

  String errorMessage = 'error';

  bool showError = false;

  String title = '';

  int totalItem = 0;

  bool success = false;

  bool loading = false;

  int position = 0;

  User? user;

  List<User>? userList;

  String get formTitle => isUpdated ? title = 'Update User' : 'Create User';

  /* 
  void setUsername([object Object] value) {
    username = value;
  }
  
  void setFirstName([object Object] value) {
    firstName = value;
  }
  
  void setLastName([object Object] value) {
    lastName = value;
  }
  
  void setEmail([object Object] value) {
    email = value;
  }
  
  void setPassword([object Object] value) {
    password = value;
  }
  
  void setPhone([object Object] value) {
    phone = value;
  }
  
  void setUserStatus([object Object] value) {
    userStatus = value;
  } */

  itemTap(int position) {
    try {
      position = position;
      user = userList![position];
      isItemEmpty = false;
      //NavigationServices.navigateTo(UserRoutes.detail);
    } catch (e) {
      isItemEmpty = true;
    }
  }

  add() {
    user = null;
    isUpdated = false;
    //NavigationServices.navigateTo(UserRoutes.form);
  }

  save() {
    loading = true;
    success = false;
    try {
      isUpdated
          ? UserServices.updateUser(_toUser())
          : UserServices.createUser(_toUser());
      //NavigationServices.navigateTo(UserRoutes.users);
      loading = false;
      success = true;
      getUserList();
    } catch (e) {
      // print(e.toString());
    }
  }

  delete(int id) {
    loading = true;
    success = false;
    try {
      UserServices.deleteUser(id);
      isDeleted = true;
      loading = false;
      success = true;
      getUserList();
    } catch (e) {
     // print(e.toString());
    }
  }

  setUser(User user) {
    this.user = user;
  }

  update() {
    loading = true;
    success = false;
    try {
     // NavigationServices.navigateTo(UserRoutes.form);
      isUpdated = true;
      loading = false;
      success = true;
      getUserList();
    } catch (e) {
     // print(e.toString());
    }
  }

  Future getUserList() async {
    loading = true;
    success = false;
    isListEmpty = true;
    try {
      UserServices.users().then((data) => _setUserList(data));
      isListEmpty = false;
      loading = false;
      success = true;
    } catch (e) {
      showError = true;
      errorMessage = 'Data Empty';
    }
  }

  FutureProvider<List<User>> users(){
    return FutureProvider<List<User>>((ref) async {
      return await UserServices.users();
    });
  }

  Future<List<User>> usersList() async{
      return await UserServices.users();
  }

  
  /* users() {
    return FutureProvider<List<User>>((ref) async {
      final content = json.decode(
        await rootBundle.loadString('assets/data/users.json'),
      ) as List<User>;
      return User.listFromJson(content);
    }) as AsyncValue<List<User>>;
  } */

  _setUserList(List<User> data) {
    if (data.isNotEmpty) {
      userList = data;
      totalItem = data.length;
    }
  }

  User _toUser() {
    return User(
      id: isUpdated ? user!.id : 0,
      /*   username: username, 
    firstName: firstName, 
    lastName: lastName, 
    email: email, 
    password: password, 
    phone: phone, 
    userStatus: userStatus, */
    );
  }

  viewList() {
    getUserList();
   // NavigationServices.navigateTo(UserRoutes.users);
  }
}
