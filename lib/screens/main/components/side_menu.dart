import 'package:admin_panel/screens/article_sc/category/article_cat_screen.dart';
import 'package:admin_panel/screens/detection_sc/categories/category_screen.dart';
import 'package:admin_panel/screens/doctors/doctor_screen.dart';
import 'package:admin_panel/screens/main/main_screen.dart';
import 'package:admin_panel/screens/patients/patient_screen.dart';
import 'package:admin_panel/screens/transaction/tx_screen.dart';
import 'package:admin_panel/screens/video_sc/category/video_cat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                Stack(
              children: [
                Opacity(
                  opacity: .25,
                  child: Center(child: FaIcon(FontAwesomeIcons.headSideVirus,size: 120,)),
                ),
                Center(
                  child: Text(
                    "Complete Mental Health Solution",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ),
              ],
            ),
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
            title: "Article",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => ArticleCategoryScreen()
                    // Provider(
                    //   create: (context) => (),
                    //   builder: (context, child) => ProductDetails(),
                    // ),
                    ),
              );
            },
          ),
          DrawerListTileIcon(
            title: "Video",
            icon: Icons.video_collection_rounded,
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => VideoCategoryScreen()
                    // Provider(
                    //   create: (context) => (),
                    //   builder: (context, child) => ProductDetails(),
                    // ),
                    ),
              );
            },
          ),
          DrawerListTileIcon(
            title: "Transaction",
            icon: Icons.attach_money_outlined,
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
          DrawerListTileIcon(
            title: "Users",
            icon: Icons.supervised_user_circle_outlined,
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PatientScreen(),
                ),
              );
            },
          ),
          DrawerListTileIcon(
            title: "Doctor",
            icon: Icons.volunteer_activism,
            press: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => DoctorScreen(),
                ),
              );
            },
          ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {
          //
          //   },
          // ),
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

class DrawerListTileIcon extends StatelessWidget {
  const DrawerListTileIcon({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Colors.white54,
        size: 16.0,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
