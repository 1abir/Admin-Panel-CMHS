import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

import 'components/question_category_view.dart';


class QuestionCategoryScreen extends StatelessWidget {
  final String category;

  const QuestionCategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child:
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
                  child: QuestionCategoryView(category: category,),
                ),
              ],
            ),
        //   ],
        // ),
      ),
    );
  }
}
