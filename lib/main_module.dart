
import 'package:riverpod_sample/widgets/admin_adaptive/index.dart';

import 'main_routes.dart';
import '../../utils/modules/module.dart';


class MainModule implements Module {

  @override
  String? name = 'Apps';

  @override
  String? baseRoute = '';

  @override
  pages() => [
        Menu(title: '', path: MainRoutes.home),
        Menu(title: '', path: MainRoutes.about),
      ];

  @override
  services() {}

  @override
  goroutes() => MainRoutes.goroutes;
}
