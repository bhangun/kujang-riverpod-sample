import 'package:go_router/go_router.dart';

import '../../utils/routes.dart';
import 'pages/index.dart';


class UserRoutes {
  UserRoutes._();
  static String users = '/users';
  static String detail = '$users/detail';
  static String form = '$users/form';
 

  static final List<GoRoute> goroutes = <GoRoute>[
    Routes.pageFadeTrans(detail, const UserDetail()),
    Routes.pageFadeTrans(form, const UserForm()),
    Routes.pageFadeTrans(users, const UserList())
  ];
}
