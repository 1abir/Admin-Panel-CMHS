import 'dart:async';

import 'package:admin_panel/backend/detectionmodule/detection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var detectionElementNames = <String>[
  'anxiety',
  'depression',
  'love_obsession',
  'marital_problem',
  'ocd',
  'social_interaction_problem',
];

class DetectionModuleElement {
  String name;
  CollectionReference? ref;
  StreamSubscription<QuerySnapshot>? subscription;
  List<FirebaseQuestionDetection>? questionsList;

  DetectionModuleElement(
      {required this.name, this.questionsList, this.ref, this.subscription});

  Future<void> addQuestion(FirebaseQuestionDetection qd) async {
    debugPrint("inside add question");
    if (ref != null) {
      debugPrint("inside add question ref");
      ref!.doc(qd.qKey).set(qd.toMap()).catchError((onError) {
        debugPrint('Error in add Question : ' + onError.toString());
      }).then((value) {});
    }
  }

  Future<void> updateQuestion(FirebaseQuestionDetection qd) async {
    debugPrint("inside update question");
    if (ref != null) {
      debugPrint("inside update question ref");
      ref!.doc(qd.qKey).set(qd.toMap()).catchError((onError) {
        debugPrint('Errir in add Question : ' + onError.toString());
      });
    }
  }

  Future<void> deleteQuestion(FirebaseQuestionDetection qd) async {
    debugPrint("inside delete question");
    if (questionsList != null) {
      debugPrint("inside delete question ref");
      questionsList!.remove(qd);
      return ref!.doc((qd.qKey)).delete().catchError((onError) {
        debugPrint('Errir in delete Question : ' + onError.toString());
      });
    }
  }
}
