import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/backend/articlemodule/article_module.dart';
import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/forms/article_form.dart';
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/article_sc/article_cat_single_view/components/article_add_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ArticleCategorySingleView extends StatelessWidget {
  final String category;

  const ArticleCategorySingleView({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        height: MediaQuery.of(context).size.height * .99,
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
                category,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: Consumer<FetchFireBaseData>(
                  builder: (context, appState, _) {
                    List<Article> articleList = appState.am!.getArticleSublist(category);
                    return SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 0,
                        columnSpacing: defaultPadding,
                        columns: [
                          DataColumn(
                            label: Text("Article"),
                          ),
                        ],
                        rows: List.generate(
                          articleList.length,
                          (i) => _dataRow(
                              articleList[i],
                              context,
                              appState.am!,
                              appState),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

DataRow _dataRow(
    Article article,
    BuildContext context,
    ArticleModuleElement am,
    FetchFireBaseData appState) {
  var temp = Article.fromMap(article.toMap());
  temp.key = article.key;

  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            CircleAvatar(
              child: Card(
                child: Icon(Icons.assignment_outlined),
              ),
              radius: 22,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  article.head,
                  overflow: TextOverflow.fade,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    isScrollControlled: true,
                    builder: (context) {
                      return ArticleForm(
                        suggessions: am.articleCategories.toList(growable: false),
                        article: article,
                        temp: temp,
                        onSubmit: () async {
                          article.copyFrom(temp);
                          am.updateArticle(article);
                        },
                        onDelete: () async {
                          am.deleteArticle(article);
                          // appState.notify();
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    ],
  );
}
