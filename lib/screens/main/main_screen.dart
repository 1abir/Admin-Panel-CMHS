import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/dashboard/dashboard_screen.dart';
import 'package:admin_panel/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FetchFireBaseData>(
      builder:
          (BuildContext context, FetchFireBaseData appState, Widget? child) {
        switch (appState.loginState) {
          case LoginStates.loggedOut:
            return LoginScreen();
          case LoginStates.loggedIn:
            return child ?? Container();
          case LoginStates.loggingIn:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 320,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
        }
      },
      child: Scaffold(
        // key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: DashboardScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
