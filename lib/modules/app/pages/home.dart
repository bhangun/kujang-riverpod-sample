import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/modules/auth/provider/auth_provider.dart';
import 'package:riverpod_sample/widgets/button_widget.dart';
import 'package:riverpod_sample/widgets/drawer_widget.dart';

import '../../../widgets/bottom_bar_widget.dart';
import '../../../widgets/appbar_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final _homeKey = GlobalKey<ScaffoldState>();

  final _title = 'Home';
  AuthProvider _authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = ref.watch(authProvider);

    return Scaffold(
      key: _homeKey,
      appBar: KAppBar(
        title: _title,
        onLogout: () => {},
      ),
      body: _body(),
      drawer: KDrawer(firstName: _authProvider.user!.firstName,
      email: _authProvider.user!.email,),
      bottomNavigationBar: const KBottomBar(),
    );
  }

  _body() {
    return Stack(
      children: const [KButton(label: 'coba')],
    );
  }
}
