import 'package:riverpod_sample/models/user.dart';
import 'package:riverpod_sample/services/navigation.dart';
import 'package:riverpod_sample/modules/user/services/user_routes.dart';
import 'package:riverpod_sample/modules/user/services/user_services.dart';

class UserStore {
  bool isListEmpty = true;
  
  bool isItemEmpty = true;
  
  bool isUpdated = false;
  
  bool isDeleted = false;

  
  String errorMessage='error';
  
  bool showError = false;
  
  String title = '';

  
  int totalItem = 0;
  
  bool success = false;
  
  bool loading = false;
  
  int position = 0;

  
  User? itemDetail;

  List<User>? userList;
  
/*   [object Object]? username;
  [object Object]? firstName;
  [object Object]? lastName;
  [object Object]? email;
  [object Object]? password;
  [object Object]? phone;
  [object Object]? userStatus;
     */

  // actions:-------------------------------------------------------------------

  String get formTitle => isUpdated? title='Update User':'Create User'; 
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

  
  itemTap(int _position) {
    try {
      position = _position;
      itemDetail = userList![position];
      isItemEmpty = false;
      NavigationServices.navigateTo(UserRoutes.userDetail);

    } catch (e) {
      isItemEmpty = true;
    }
  }

  
  add() {
    itemDetail = null;
    isUpdated = false;
    NavigationServices.navigateTo(UserRoutes.userForm);
  }

  
  save() {
    loading = true;
    success = false;
    try {
      isUpdated ? UserServices.updateUser(_toUser())
          :UserServices.createUser(_toUser());
      NavigationServices.navigateTo(UserRoutes.userList);
      loading = false;
      success = true;
      getUserList();
    }catch(e){
      print(e.toString());
    }
  }

  
  delete(int id) {
    loading = true;
    success = false;
    try {
      UserServices.deleteUser(id);
      isDeleted =true;
      loading = false;
      success = true;
      getUserList();
    }catch(e){
      print(e.toString());
    }
  }

  
  update() {
    loading = true;
    success = false;
    try {
      NavigationServices.navigateTo(UserRoutes.userForm);
      isUpdated = true;
      loading = false;
      success = true;
      getUserList();
    }catch(e){
      print(e.toString());
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
      print(e.toString());
    }

  }

  _setUserList(List<User> data){
    if (data != null) {
      userList = data;
      totalItem = data.length;
    }
  }

  User _toUser() {
    return User(
    id: isUpdated ? itemDetail!.id : null,
  /*   username: username, 
    firstName: firstName, 
    lastName: lastName, 
    email: email, 
    password: password, 
    phone: phone, 
    userStatus: userStatus, */ );
  }

  
  viewList() {
    getUserList();
    NavigationServices.navigateTo(UserRoutes.userList);
  }
}
