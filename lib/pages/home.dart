import 'package:adaptive_screen/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/menu_bloc.dart';
import '../model/data.dart';
import '../modules/settings/provider/settings_provider.dart';
import '../widgets/admin_adaptive/index.dart';
import '../widgets/buttons/dropdown.dart';
import '../widgets/profile_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  int pageIndex = 0;
  String account = 'Fulan';
  String title = 'Dashboard';

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
    var settings = ref.watch(settingsProvider);
    List<Menu> menus = menu(context);

    return AdminAdaptive(
      title: const Text('Miku'),
      actions: header(context, title, settings),
      currentIndex: pageIndex,
      menuItems: menus,
      body: widget.child,
      onMenuClick: (menu) => context.go(menu.path!),
      onBottomTap: (value) => setState(() {
        pageIndex = value;
      }),
      floatingActionButton: _hasFAB ? _buildFab(context) : null,
    );
  }

  List<Widget> header(context, title, settings) => [
        // Title
        if (!DeviceScreen.isPhone(context)) Text(title),

        // Space
        if (!DeviceScreen.isPhone(context))
          Spacer(flex: DeviceScreen.isLargeScreen(context) ? 2 : 1),

        // Switch them button
        IconButton(
            splashRadius: 15,
            icon: settings.isLightTheme
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
            onPressed: () => ref.read(settingsProvider).switchTheme()),

        // Switch language menu
        Dropdown(items: [
          DropdownItem(
              title: 'Bahasa',
              onTap: () => ref.read(settingsProvider).switchLocale('ID')),
          DropdownItem(
              title: 'English',
              onTap: () => ref.read(settingsProvider).switchLocale('EN'))
        ]),

        // Profile Menu
        if (!DeviceScreen.isLargeScreen(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: ref.read(menuBloc).controlMenu,
          ),
        ProfileCard(
          accountName: account,
          onTap: () => _handleSignOut(context),
        ),
      ];

  bool get _hasFAB {
    if (pageIndex == 2) return false;
    return true;
  }

  FloatingActionButton _buildFab(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.chat_rounded),
      onPressed: () => {},
    );
  }


  Future<void> _handleSignOut(context) async {
    ref.watch(authBloc.notifier).signOut();
    //var shouldSignOut = await (
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            child: const Text('No'),
            onPressed: () {
              //  Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              // ref.watch(authProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
