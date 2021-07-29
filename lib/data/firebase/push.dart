// import 'dart:html';
// import 'dart:js';


// import 'package:firebase/firebase.dart';
// import 'package:firebase/firestore.dart' as fs;
//
//
// void main() {
//   initializeApp(
//       apiKey: "AIzaSyAqTcPyjaFQu6UbIJhuLjJ3GRnmNgW8wF8",
//       authDomain: "complete-mental-health.firebaseapp.com",
//       databaseURL: "https://complete-mental-health-default-rtdb.firebaseio.com",
//       projectId: "complete-mental-health",
//       storageBucket: "complete-mental-health.appspot.com",
//       messagingSenderId: "916347443251",
//       appId: "1:916347443251:web:485af7beea19119739eb46",
//       measurementId: "G-9NRQ8Z3LXZ"
//   );
//
//   fs.Firestore store = firestore();
//   fs.CollectionReference ref = store.collection('detection/anxiety/scale1');
//
//   ref.onSnapshot.listen((querySnapshot) {
//     querySnapshot.docChanges().forEach((change) {
//       print(change.toString());
//     });
//   });
// }

class ApplicationState {
  ApplicationState() {
    // initAnxiety();
    // initDepression();
    // init3();
    // init_sip();
    // love_init();
    // ocd_init();
    // sip_info_init();
    // mp_info_init();
  }

  // Future<void> initAnxiety() async {
  //   await Firebase.initializeApp();
  //   var col_ref =
  //       FirebaseFirestore.instance.collection('/detection/anxiety/scale1');
  //
  //   for (int i = 0; i < questions_anxiety.length; i++) {
  //     var q = questions_anxiety[i];
  //
  //     q.level = i + 1;
  //     q.q_key = q.level.toString();
  //
  //     col_ref.doc(q.q_key).set(q.toMap());
  //   }
  // }

  Future<void> initDepressionInfo() async {
    // await Firebase.initializeApp();
    // var col_ref =
    //     FirebaseFirestore.instance.collection('/detection/depression/info');
    // col_ref.add(depression1Infonfo);
  }

  // Future<void> initDepression() async {
  //   await Firebase.initializeApp();
  //
  //   var col_ref =
  //       FirebaseFirestore.instance.collection('/detection/depression/scale1');
  //
  //   for (int i = 0; i < questions_depression.length; i++) {
  //     var q = questions_depression[i];
  //
  //     q.level = i + 1;
  //     q.q_key = q.level.toString();
  //
  //     col_ref.doc(q.q_key).set(q.toMap());
  //   }
  // }

  //
  // Future<void> initSip() async {
  //   // await Firebase.initializeApp();
  //
  //   var col_ref = FirebaseFirestore.instance
  //       .collection('/detection/social_interaction_problem/scale1');
  //
  //   for (int i = 0; i < social_int_problem.length; i++) {
  //     var q = social_int_problem[i];
  //
  //     q.level = i + 1;
  //     q.q_key = q.level.toString();
  //
  //     col_ref.doc(q.q_key).set(q.toMap());
  //   }
    //
    //   // col_ref.add(q);
    //
    //   // var snapshot = await col_ref.get();
    //   //
    //   // var docsmap =  snapshot.docs.map((doc) => doc.data());
    //   //
    //   // docsmap.forEach((element) {
    //   //   print(element.toString());
    //   // });
    // }
    //
    // Future<void> love_init() async {
    //   await Firebase.initializeApp();
    //   var col_ref = FirebaseFirestore.instance
    //       .collection('/detection/love_obsession/scale1');
    //
    //   for (int i = 0; i < love_obsession_problem.length; i++) {
    //     var q = love_obsession_problem[i];
    //
    //     q.level = i + 1;
    //     col_ref.add(q.toMap());
    //   }
    // }
    //
    // Future<void> init2() async {
    //     await Firebase.initializeApp();
    //
    //     var col_ref = FirebaseFirestore.instance
    //         .collection('/detection/love_obsession/info');
    //     col_ref.add(love_obsession_info);
    //     ocd_init();
    //     ocd_info_init();
    //   }
    //
    // Future<void> ocd_info_init() async {
    //   await Firebase.initializeApp();
    //
    //   var col_ref = FirebaseFirestore.instance
    //       .collection('/detection/ocd/info');
    //   col_ref.add(love_obsession_info);
    //
    // }
    //
    // Future<void> sip_info_init() async {
    //   await Firebase.initializeApp();
    //
    //   var col_ref = FirebaseFirestore.instance
    //       .collection('/detection/social_interaction_problem/info');
    //   await col_ref.add(social_int_info);
    //   print("done");
    // }
    //
    // Future<void> mp_info_init() async {
    //   await Firebase.initializeApp();
    //
    // var col_ref = FirebaseFirestore.instance
    //     .collection('/detection/marital_problem/info');
    // await col_ref.add(marital_problem_info);
    // print("done");
    // mp_prob_init();
    // }
    //
    // Future<void> mp_prob_init() async {
    //   // await Firebase.initializeApp();
    //   var col_ref =
    //       FirebaseFirestore.instance.collection('/detection/marital_problem/scale1');
    //
    //   for (int i = 0; i < marital_problem.length; i++) {
    //     var q = marital_problem[i];
    //
    //     q.level = i + 1;
    //     q.q_key = q.level.toString();
    //     // col_ref.add(q.toMap());
    //     col_ref.doc(q.level.toString()).set(q.toMap());
    //   }
    // }
    // Future<void> mp_prob_init() async {
    //   // await Firebase.initializeApp();
    //   var col_ref = FirebaseFirestore.instance
    //       .collection('/detection/love_obsession/scale1');
    //
    //   for (int i = 0; i < love_obsession_problem.length; i++) {
    //     var q = love_obsession_problem[i];
    //
    //     q.level = i + 1;
    //     q.q_key = q.level.toString();
    //     // col_ref.add(q.toMap());
    //     col_ref.doc(q.level.toString()).set(q.toMap());
    //   }
    // Future<void> ocd_init() async {
    //   // await Firebase.initializeApp();
    //   var col_ref = FirebaseFirestore.instance
    //       .collection('/detection/ocd/scale1');
    //
    //   for (int i = 0; i < questions_ocd.length; i++) {
    //     var q = questions_ocd[i];
    //
    //     q.level = i + 1;
    //     q.q_key = q.level.toString();
    //     // col_ref.add(q.toMap());
    //     col_ref.doc(q.level.toString()).set(q.toMap());
    //   }
  // }
}

void push() {
  new ApplicationState();
}
