import 'package:flutter/material.dart';

import '../store/user_store.dart';
import 'package:riverpod_sample/widgets/global_methods.dart';
import 'package:riverpod_sample/widgets/progress_indicator_widget.dart';
import '../../../models/user.dart';

class UserForm extends StatefulWidget {
  final User? data;
  UserForm({this.data});
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  
  
  final _username = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _userStatus = TextEditingController();

  late UserStore _userStore = UserStore();

  @override
  void dispose() {
    _username.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    _userStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   
    /* 
    _username.addListener(() {
      _userStore.setUsername(_username.text);
    }); 
    _firstName.addListener(() {
      _userStore.setFirstName(_firstName.text);
    }); 
    _lastName.addListener(() {
      _userStore.setLastName(_lastName.text);
    }); 
    _email.addListener(() {
      _userStore.setEmail(_email.text);
    }); 
    _password.addListener(() {
      _userStore.setPassword(_password.text);
    }); 
    _phone.addListener(() {
      _userStore.setPhone(_phone.text);
    }); 
    _userStatus.addListener(() {
      _userStore.setUserStatus(_userStatus.text);
    });  */

    return  Scaffold(
            appBar: AppBar(
              title: Text(_userStore.formTitle),
            ),
            body: _buildBody(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _userStore.save(),
              tooltip: 'Add',
              child: Icon(Icons.save),
            ));
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        _userStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildForm()),
        _userStore.success
            ? Container()
            : showErrorMessage(context, '') 
        //_userStore.isModified ? KutAlert() : Container(),
      ],
    );
  }

  _buildForm() {
    return SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: _buildListChild()));
  }

  _buildListChild() {
    return <Widget>[
      SizedBox(height: 120.0),
      TextField(
        controller: _username,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Username',
        ),
      ),
      
      TextField(
        controller: _firstName,
        decoration: InputDecoration(
          filled: true,
          labelText: 'FirstName',
        ),
      ),
      
      TextField(
        controller: _lastName,
        decoration: InputDecoration(
          filled: true,
          labelText: 'LastName',
        ),
      ),
      
      TextField(
        controller: _email,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Email',
        ),
      ),
      
      TextField(
        controller: _password,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Password',
        ),
      ),
      
      TextField(
        controller: _phone,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Phone',
        ),
      ),
      
      TextField(
        controller: _userStatus,
        decoration: InputDecoration(
          filled: true,
          labelText: 'UserStatus',
        ),
      ),
      
    ];
  }
}
