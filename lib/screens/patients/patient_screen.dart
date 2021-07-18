import 'package:admin_panel/controllers/MenuController.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main/components/side_menu.dart';
import 'components/patient_view.dart';

class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child:
        // ListView(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Expanded(child: SearchField()),
        //         SizedBox(width: defaultPadding,),
        //         ElevatedButton.icon(
        //           style: TextButton.styleFrom(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: defaultPadding * 1.5,
        //               vertical:
        //               defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        //             ),
        //           ),
        //           onPressed: () {},
        //           icon: Icon(Icons.add),
        //           label: Text("Add New"),
        //         ),
        //         SizedBox(width: defaultPadding,),
        //       ],
        //     ),
        //     SizedBox(height: defaultPadding),
            Row(
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
                  child: PatientView(),
                ),
              ],
          //   ),
          // ],
        ),
      ),
    );
  }
}
