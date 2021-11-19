import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:riverpod_sample/modules/user/store/user_store.dart';
import 'package:riverpod_sample/widgets/progress_indicator_widget.dart';


class UserList extends StatefulWidget {

  @override
  _UserListState createState() => _UserListState();
}

final String title = "User List";

class _UserListState extends State<UserList> {
  final _listKey = GlobalKey<ScaffoldState>();
  var _userList;
  late UserStore _userStore = UserStore();

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    _userStore.getUserList();

    int _totalUser = _userStore.totalItem;
    _userList = _userStore.userList;

    return Scaffold(
        key: _listKey,
        appBar: AppBar(title: Text('User List ( $_totalUser )')),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: _userStore.add,
          tooltip: 'Add',
          child: Icon(Icons.add),
        ));
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _userStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildSlidelist(context)),
      ],
    );
  }

  _buildSlidelist(BuildContext context) {
    return !_userStore.isListEmpty
        ? ListView.separated(
            itemCount: _userStore.totalItem,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(index),
                /* actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Share',
                    color: Colors.indigo,
                    icon: Icons.share,
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () =>
                        _userStore.delete(_userStore.userList![index].id!),
                  ),
                ],
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                ), */
                child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      '${_userList[index].id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    /*subtitle: Text(
                      '${_userList[index]} ', 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),*/
                    onTap: () => _userStore.itemTap(index)),
              );
            })
        : Center(child: Text('Data empty'));
  }
}