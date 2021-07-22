import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/models/RecentFile.dart';
import 'package:admin_panel/screens/article_sc/article_cat_single_view/article_category_single_screen.dart';
import 'package:admin_panel/screens/article_sc/article_cat_single_view/components/article_add_new.dart';
import 'package:admin_panel/screens/article_sc/category/article_cat_screen.dart';
import 'package:admin_panel/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class ArticleCategoryView extends StatelessWidget {
  const ArticleCategoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                // Expanded(child: SearchField()),
                SizedBox(
                  width: defaultPadding,
                ),
                ArticleAddnewutton(),
                SizedBox(
                  width: defaultPadding,
                ),
              ],
            ),
          ),
          SizedBox(height: defaultPadding),
          Flexible(
            flex: 1,
            child: Text(
              "Article Categories",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Flexible(
            flex: 11,
            child: SingleChildScrollView(
              child: Consumer<FetchFireBaseData>(
                builder: (context, appState, _) => SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("Name"),
                      ),
                    ],
                    rows: appState.am == null ||
                            appState.am!.articleCategories.isEmpty
                        ? []
                        : List.generate(
                            appState.am!.articleCategories.length,
                            (index) {
                              return _articleCatDataRow(
                                  context,
                                  appState.am!.articleCategories
                                      .elementAt(index));
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _articleCatDataRow(BuildContext context, String category) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/media_file.svg",
                height: 30,
                width: 30,
              ),
              // Builder(
              //   builder:(context)=>
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement<void, void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          ArticleCategorySingleScreen(
                        category: category,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(category),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
