import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'article.dart';

class ArticleModuleElement {
  CollectionReference? ref;
  StreamSubscription<QuerySnapshot>? subscription;
  List<Article>? articleList;
  var articleCategories = <String>{};

  ArticleModuleElement({this.articleList, this.ref, this.subscription});

  Future<void> updateArticle(Article qd) async {
    debugPrint("inside add question");
    if (ref != null) {
      debugPrint("inside add question ref");
      ref!.doc(qd.key).set(qd.toMap()).catchError((onError) {
        debugPrint('Error in add Question : ' + onError.toString());
      }).then((value) {});
    }
  }

  Future<void> addArticle(Article qd) async {
    debugPrint("inside update question");
    if (ref != null) {
      debugPrint("inside update question ref");
      ref!.add(qd.toMap()).catchError((onError) {
        debugPrint('Errir in add Question : ' + onError.toString());
      });
    }
  }

  Future<void> deleteArticle(Article qd) async {
    debugPrint("inside delete article");
    if (articleList != null) {
      debugPrint("inside delete article ref");
      debugPrint("Article delete: " +
          qd.key.toString() +
          "\n" +
          qd.toMap().toString());
      articleList!.remove(qd);
      return ref!.doc((qd.key)).delete().catchError((onError) {
        debugPrint('Error in delete Question : ' + onError.toString());
      });
    }
  }

  List<Article> getArticleSublist(String category) {
    if (!articleCategories.contains(category)) return [];
    List<Article> al = [];
    for (var article in articleList!) {
      if (article.category == category) al.add(article);
    }
    return al;
  }
}
