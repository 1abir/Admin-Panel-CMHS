import 'dart:async';

import 'package:admin_panel/data/firebase/detection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DetectionModuleElement{
  String name;
  CollectionReference? ref;
  StreamSubscription<QuerySnapshot>? subscription;
  List<FirebaseQuestionDetection>? questionsList;

  DetectionModuleElement(
      {required this.name,
        this.questionsList,
        this.ref,
        this.subscription});

  Future<void> addQuestion(FirebaseQuestionDetection qd) async {
    if(ref != null){
      return ref!.doc(qd.q_key).set(qd.toMap());
    }
  }
}
var detectionElementNames = <String>[
  'anxiety',
  'depression',
  'love_obsession',
  'marital_problem',
  'ocd',
  'social_interaction_problem',
];
class FetchFireBaseData extends ChangeNotifier{
  List<DetectionModuleElement> detectionModule = [];
  Map<String,DetectionModuleElement> detectionModuleMap = {};

  FetchFireBaseData() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    for(int i=0;i<detectionElementNames.length;i++) {
      DetectionModuleElement dm  = await fetch(detectionElementNames[i]);
      detectionModule.add(dm);
      detectionModuleMap[detectionElementNames[i]] = dm;
      dm.questionsList!.forEach((element) {debugPrint(element.toMap().toString());});
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
      snapshot.docs.forEach((element) {
        var ref = element.reference.id;
        var data = element.data();
        FirebaseQuestionDetection q = FirebaseQuestionDetection.fromMap(data);
        // if(q.q_key!= ref){
        //   q.q_key = ref;
        //   element.reference.set(q.toMap());
        // }
        //
        me.questionsList!.add(q);
      });
      notifyListeners();
    });
    me.subscription = subscription;
    return me;
  }
}
