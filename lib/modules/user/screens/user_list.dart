import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:riverpod_sample/modules/user/bloc/user_bloc.dart';
import 'package:riverpod_sample/modules/user/model/user.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({Key? key}) : super(key: key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  final _listKey = GlobalKey<ScaffoldState>();

  UserBloc _userBloc = UserBloc();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userBloc = ref.watch(userBloc);
    AsyncValue<List<User>> _userList = ref.watch(_userBloc.users());

    int _totalUser = _userBloc.totalItem;

    return Scaffold(
        key: _listKey,
        appBar: AppBar(title: Text('User List ( $_totalUser )')),
        body: _userList.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (users) {
            return Material(child: _buildSlidelist(context, users));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _userBloc.add,
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ));
  }

  _buildSlidelist(BuildContext context, List<User> users) {
    return !_userBloc.isListEmpty
        ? ListView.separated(
            itemCount: _userBloc.totalItem,
            separatorBuilder: (context, index) {
              return const Divider();
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
                        _userBloc.delete(_userBloc.userList![index].id!),
                  ),
                ],
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                ), */
                child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      '${users[index].id}',
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
                    onTap: () => _userBloc.itemTap(index)),
              );
            })
        : const Center(child: Text('Data empty'));
  }
}
