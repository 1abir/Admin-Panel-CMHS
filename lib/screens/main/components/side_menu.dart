import 'package:admin_panel/screens/categories/category_screen.dart';
import 'package:admin_panel/screens/doctors/doctor_screen.dart';
import 'package:admin_panel/screens/main/main_screen.dart';
import 'package:admin_panel/screens/patients/patient_screen.dart';
import 'package:admin_panel/screens/transaction/tx_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child:
            //Image.asset("assets/images/logo.png"),
            Center(
              child: Text(
                "Complete Mental Health Solution",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white70,
                ),

              ),
            )
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => MainScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => TransactionScreen()
                  // Provider(
                  //   create: (context) => (),
                  //   builder: (context, child) => ProductDetails(),
                  // ),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PatientScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Doctor",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => DoctorScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {

            },
          ),
          DrawerListTile(
            title: "Questions",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => CategoryScreen(),
                ),
              );
            },
          ),
          // DrawerListTile(
          //   title: "Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
