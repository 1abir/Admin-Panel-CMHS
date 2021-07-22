import 'dart:async';

import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoModuleElement {
  CollectionReference? ref;
  StreamSubscription<QuerySnapshot>? subscription;
  List<Videos>? videoList;
  var videoCategories = <String>{};

  VideoModuleElement({this.videoList, this.ref, this.subscription});

  Future<void> updateVideos(Videos qd) async {
    if (ref != null) {
      ref!.doc(qd.key).set(qd.toMap()).catchError((onError) {
        debugPrint('Error in add Question : ' + onError.toString());
      }).then((value) {});
    }
  }

  Future<void> addVideos(Videos qd) async {
    if (ref != null) {
      debugPrint("inside update question ref");
      ref!.add(qd.toMap()).catchError((onError) {
        debugPrint('Errir in add Question : ' + onError.toString());
      });
    }
  }

  Future<void> deleteVideos(Videos qd) async {
    return ref!.doc((qd.key)).delete().catchError((onError) {
      debugPrint('Error in delete Question : ' + onError.toString());
    });
  }

  List<Videos> getVideosSublist(String category) {
    if (!videoCategories.contains(category)) return [];
    List<Videos> al = [];
    for (var video in videoList!) {
      if (video.category == category) al.add(video);
    }
    return al;
  }
}
