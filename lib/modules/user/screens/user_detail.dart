import 'package:flutter/material.dart';

import '../store/user_store.dart';


class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late UserStore _userStore = UserStore();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
            appBar: AppBar(title: Text('User Detail')),
            body: _userStore.isItemEmpty
                ? Center(child: Text('User data are empty'))
                : userDetail(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _userStore.update(),
              tooltip: 'Edit',
              child: Icon(Icons.edit),
            ));
  }

  userDetail() {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 100.0),
          Icon(Icons.person, size: 100, color: Colors.blue[500]),
          Column(children: <Widget>[
            Text(_userStore.itemDetail!.username!),
            Text(_userStore.itemDetail!.firstName!),
            Text(_userStore.itemDetail!.lastName!),
            Text(_userStore.itemDetail!.email!),
            Text(_userStore.itemDetail!.password!),
            Text(_userStore.itemDetail!.phone!),
            //Text(_userStore.itemDetail!.userStatus!),
          ])
        ]);
  }
}