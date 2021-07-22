import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/forms/article_form.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleAddnewutton extends StatelessWidget {
  const ArticleAddnewutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchFireBaseData>(builder: (context, appState, _) {
      Article article = Article.fromMap(<String,dynamic>{});
      article.type = 'article';
      var temp = Article.fromMap(article.toMap());
      return ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 1.5,
            vertical: defaultPadding /
                (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
              elevation: 5.0,
              barrierColor: Colors.white70,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              isScrollControlled: true,
              builder: (context) {
                return ArticleForm(
                  suggessions: appState.am!.articleCategories.toList(growable: false),
                    temp: temp,
                    article: article,
                    onSubmit: () async {
                      article.copyFrom(temp);
                      appState.am!.addArticle(article);
                      // appState.notify();
                    });
              });
        },
        icon: Icon(Icons.add),
        label: Text("Add New"),
      );
    });
  }
}
