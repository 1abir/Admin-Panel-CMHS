import 'dart:async';

import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/backend/articlemodule/article_module.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/backend/meetingmodule/meeting_info.dart';
import 'package:admin_panel/backend/meetingmodule/meeting_module.dart';
import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/backend/usermodule/user_module_elements.dart';
import 'package:admin_panel/data/firebase/detection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FetchFireBaseData extends ChangeNotifier {
  FirebaseApp? app;
  List<DetectionModuleElement> detectionModule = [];
  Map<String, DetectionModuleElement> detectionModuleMap = {};
  List<StreamSubscription> subscriptions = [];
  UserModuleElement? userModuleElement;
  MeetingModule? meetingModuleElement;
  ArticleModuleElement? am;

  FetchFireBaseData() {
    init();
  }

  Future<void> init() async {
    app = await Firebase.initializeApp();
    fetchDetectionModule();
    fetchUserModule();
    fetchMeetingModule();
    fetchArticle();
  }

  Future<void> fetchDetectionModule() async {
    for (int i = 0; i < detectionElementNames.length; i++) {
      DetectionModuleElement dm = await fetch(detectionElementNames[i]);
      detectionModule.add(dm);
      detectionModuleMap[detectionElementNames[i]] = dm;
      dm.questionsList!.forEach((element) {
        debugPrint(element.toMap().toString());
      });
    }
  }

  Future<DetectionModuleElement> fetch(String name) async {
    DetectionModuleElement me =
        DetectionModuleElement(name: name, questionsList: []);
    var subscription = FirebaseFirestore.instance
        .collection('/detection/$name/scale1')
        .orderBy('level')
        .snapshots()
        .listen((snapshot) {
      me.questionsList!.clear();
      snapshot.docs.forEach((element) {
        var data = element.data();
        FirebaseQuestionDetection q = FirebaseQuestionDetection.fromMap(data);
        me.questionsList!.add(q);
      });
      notifyListeners();
    });
    me.subscription = subscription;
    me.ref = FirebaseFirestore.instance.collection('/detection/$name/scale1');
    subscriptions.add(subscription);
    return me;
  }

  Future<ArticleModuleElement?> fetchArticle() async {
    debugPrint("Article Category called");
    am = ArticleModuleElement(articleList: []);
    var subscription = FirebaseFirestore.instance
        .collection('/article')
        .snapshots()
        .listen((snapshot) {
      am!.articleList!.clear();
      am!.articleCategories.clear();
      snapshot.docs.forEach((element) {
        var data = element.data();
        debugPrint(data.toString());
        Article article = Article.fromMap(data);
        article.key = element.reference.id;
        debugPrint('Article:' + article.toMap().toString());
        am!.articleList!.add(article);
        if (article.category != '') am!.articleCategories.add(article.category);
      });
      notifyListeners();
    });
    am!.subscription = subscription;
    am!.ref = FirebaseFirestore.instance.collection('/article');
    subscriptions.add(subscription);
    return am;
  }

  Future<void> fetchUserModule() async {
    debugPrint("Fetch User Called");
    if (app == null) app = await Firebase.initializeApp();
    var dbRef = FirebaseDatabase.instance.reference();

    var userDataRef = dbRef.child('Users');
    List<UserInfoClass> userList = [];
    List<UserInfoClass> doctorList = [];

    // userDataRef.onValue.listen((event) { })

    userDataRef.get().then((DataSnapshot? snapshot) {
      if (snapshot != null) {
        debugPrint("snapshot received");
        snapshot.value.forEach((key, value) {
          var d = Map<String, dynamic>.from(value);
          UserInfoClass user = UserInfoClass.fromMap(d);
          user.key = key.toString();
          if (user.isDoctor == 0)
            userList.add(user);
          else
            doctorList.add(user);
        });
      }
    }).whenComplete(() {
      userModuleElement = UserModuleElement(
          userRef: userDataRef,
          dbSubscription: null,
          doctors: doctorList,
          users: userList);
      debugPrint('Doctor List Length: ' + doctorList.length.toString());
      notifyListeners();
    }).catchError((onError) {
      debugPrint("error occured in reading rtdb: " + onError.toString());
    });
    // userDataRef.once().then((DataSnapshot snapshot) {
    //   snapshot.value.forEach((key, value) {
    //     var d = Map<String, dynamic>.from(value);
    //     UserInfoClass user = UserInfoClass.fromMap(d);
    //     user.key = key.toString();
    //     if (user.isDoctor == 0)
    //       userList.add(user);
    //     else
    //       doctorList.add(user);
    //   });
    // }).whenComplete(() {
    //   userModuleElement = UserModuleElement(
    //       userRef: userDataRef,
    //       dbSubscription: null,
    //       doctors: doctorList,
    //       users: userList);
    //   debugPrint('Doctor List Length: ' + doctorList.length.toString());
    //   notifyListeners();
    // }).catchError((onError) {
    //   debugPrint("error occured in reading rtdb: " + onError.toString());
    // });
  }

  Future<void> fetchMeetingModule() async {
    debugPrint("Fetch Meeting Called");
    if (app == null) app = await Firebase.initializeApp();
    var dbRef = FirebaseDatabase.instance.reference();

    var meetingDataRef = dbRef.child('Meeting');
    List<MeetingInfo> meetingList = [];

    var subscription = meetingDataRef.onValue.listen((event) {
      final meetings = Map<String, dynamic>.from(event.snapshot.value);
      meetings.forEach((key, value) {
        meetingList = [];
        var d = Map<String, dynamic>.from(value);
        MeetingInfo meet = MeetingInfo.fromMap(d);
        meet.key = key.toString();
        debugPrint("meet : "+meet.toMap().toString());
        meetingList.add(meet);
      });
      meetingModuleElement = MeetingModule(
          sessions: meetingList, meetingReference: meetingDataRef);
      debugPrint('Meeting List Length: ' + meetingList.length.toString());
      notifyListeners();
    });
    subscription.onError((err) {
      debugPrint("error meeting Suscription : " + err.toString());
    });
    subscriptions.add(subscription);
    // meetingDataRef.once().then((DataSnapshot snapshot) {
    //   snapshot.value.forEach((key, value) {
    //     var d = Map<String, dynamic>.from(value);
    //     MeetingInfo meet = MeetingInfo.fromMap(d);
    //     meet.key = key.toString();
    //
    //     meetingList.add(meet);
    //   });
    // }).whenComplete(() {
    //   meetingModuleElement = MeetingModule(
    //       sessions: meetingList, meetingReference: meetingDataRef);
    //   debugPrint('Meeting List Length: ' + meetingList.length.toString());
    //   notifyListeners();
    // }).catchError((onError) {
    //   debugPrint(
    //       "error occured in reading rtdb meeting : " + onError.toString());
    // });
  }

  void notify() {
    notifyListeners();
  }

  void dispose() {
    for (var s in subscriptions) {
      s.cancel();
    }
    super.dispose();
  }
}
