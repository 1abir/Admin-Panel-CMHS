import 'dart:async';

import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/backend/articlemodule/article_module.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/backend/meetingmodule/meeting_info.dart';
import 'package:admin_panel/backend/meetingmodule/meeting_module.dart';
import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/backend/transactionmodule/transaction_module.dart';
import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/backend/usermodule/user_module_elements.dart';
import 'package:admin_panel/backend/videomodule/videomodulelement.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/data/firebase/detection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoginStates {
 loggedIn,
 loggedOut,
 loggingIn,
}

class FetchFireBaseData extends ChangeNotifier {
  FirebaseApp? app;
  List<DetectionModuleElement> detectionModule = [];
  Map<String, DetectionModuleElement> detectionModuleMap = {};
  List<StreamSubscription> subscriptions = [];
  UserModuleElement? userModuleElement;
  MeetingModule? meetingModuleElement;
  TransactionModule? transactionModuleElement;
  ArticleModuleElement? am;
  VideoModuleElement? videoModule;
  GoogleSignInAccount? _googleUserAccount;
  StreamSubscription<User?>? _authSubscription;

  LoginStates loginState = LoginStates.loggedOut;
  final _googleSignIn = GoogleSignIn();

  FetchFireBaseData() {
    initAuth();
    init();
  }

  Future<void>initAuth()async{
    if (app == null) app = await Firebase.initializeApp();
    StreamSubscription<User?> authSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        loginState = LoginStates.loggedOut;
        clearSubscriptions();
        notifyListeners();
      } else {
        final uuid = user.uid;
        var dbRef = FirebaseDatabase.instance.reference().child('Users');
        dbRef.once().then((DataSnapshot? snapshot) {
            if (snapshot != null) {
              debugPrint("snapshot received");
              snapshot.value.forEach((key, value) {
                var d = Map<String, dynamic>.from(value);
                UserInfoClass user = UserInfoClass.fromMap(d);
                user.key = key.toString();
                if(user.key == uuid && user.isAdmin==1){
                  loginState = LoginStates.loggedIn;
                  notifyListeners();
                  return;
                }
              });
            }
          });

      }
    });
    subscriptions.add(authSubscription);
    // _authSubscription = authSubscription;
  }

  Future<void> init() async {
    app = await Firebase.initializeApp();
    fetchDetectionModule();
    fetchUserModule();
    fetchMeetingModule();
    fetchArticle();
    fetchVideo();
    fetchTransactionModule();
  }

  Future<void> fetchDetectionModule() async {
    for (int i = 0; i < detectionElementNames.length; i++) {
      DetectionModuleElement dm = await fetch(detectionElementNames[i]);
      detectionModule.add(dm);
      detectionModuleMap[detectionElementNames[i]] = dm;
      // dm.questionsList!.forEach((element) {
      //   debugPrint(element.toMap().toString());
      // });
    }
  }

  Future<DetectionModuleElement> fetch(String name) async {
    var dbRef = FirebaseDatabase.instance.reference();
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
        q.category = name;
        me.questionsList!.add(q);
        // var detDataRef = dbRef.child('Detection');
        // detDataRef.child('$name'+'_'+q.level.toString()).set(q.toMap()).then((value){
        //   debugPrint("Detection Done" + '  $name'+'_'+q.level.toString());
        // }).catchError((onError){
        //   debugPrint("Detection_push_error"+onError.toString());
        // });

      });
      notifyListeners();
    });
    me.subscription = subscription;
    me.ref = FirebaseFirestore.instance.collection('/detection/$name/scale1');
    subscriptions.add(subscription);
    return me;
  }



  Future<ArticleModuleElement?> fetchArticle() async {
    var dbRef = FirebaseDatabase.instance.reference();
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
        // debugPrint(data.toString());
        Article article = Article.fromMap(data);
        article.key = element.reference.id;
        // debugPrint('Article:' + article.toMap().toString());
        am!.articleList!.add(article);
        if (article.category != '') am!.articleCategories.add(article.category);
        // var detDataRef = dbRef.child('Article');
      //   detDataRef.child(element.reference.id).set(article.toMap()).then((value){
      //       debugPrint("Article Done");
      //   }).catchError((onError){
      //     debugPrint("Detection_push_error"+onError.toString());
      //   });
      });
      notifyListeners();
    });
    am!.subscription = subscription;
    am!.ref = FirebaseFirestore.instance.collection('/article');
    subscriptions.add(subscription);
    return am;
  }

  Future<VideoModuleElement?> fetchVideo() async {
    var dbRef = FirebaseDatabase.instance.reference();
    videoModule = VideoModuleElement(videoList: []);
    var subscription = FirebaseFirestore.instance
        .collection('/video')
        .snapshots()
        .listen((snapshot) {
      videoModule!.videoList!.clear();
      videoModule!.videoCategories.clear();
      snapshot.docs.forEach((element) {
        var data = element.data();
        // debugPrint(data.toString());
        Videos vid = Videos.fromMap(data);
        vid.key = element.reference.id;
        // debugPrint('Video:' + vid.toMap().toString());
        videoModule!.videoList!.add(vid);
        if (vid.category != '') videoModule!.videoCategories.add(vid.category);
        // var detDataRef = dbRef.child('Video');
        // detDataRef.child(element.reference.id).set(vid.toMap()).then((value){
        //   debugPrint("Article Done");
        // }).catchError((onError){
        //   debugPrint("Detection_push_error"+onError.toString());
        // });
      });
      notifyListeners();
    });
    videoModule!.subscription = subscription;
    videoModule!.ref = FirebaseFirestore.instance.collection('/video');
    subscriptions.add(subscription);
    return videoModule;
  }

  Future<void> fetchUserModule() async {
    debugPrint("Fetch User Called");
    if (app == null) app = await Firebase.initializeApp();
    var dbRef = FirebaseDatabase.instance.reference();

    var userDataRef = dbRef.child('Users');
    List<UserInfoClass> userList = [];
    List<UserInfoClass> doctorList = [];

    // userDataRef.onValue.listen((event) { })

    // userDataRef.get().then((DataSnapshot? snapshot) {
    //   if (snapshot != null) {
    //     debugPrint("snapshot received");
    //     snapshot.value.forEach((key, value) {
    //       var d = Map<String, dynamic>.from(value);
    //       UserInfoClass user = UserInfoClass.fromMap(d);
    //       user.key = key.toString();
    //       if (user.isDoctor == 0)
    //         userList.add(user);
    //       else
    //         doctorList.add(user);
    //     });
    //   }
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

    var subscription = userDataRef.onValue.listen((event) {
      userList.clear();
      doctorList.clear();
      final users = Map<String, dynamic>.from(event.snapshot.value);
      users.forEach((key, value) {
        var d = Map<String, dynamic>.from(value);
        UserInfoClass user = UserInfoClass.fromMap(d);
        // debugPrint(user.toMap().toString());
        user.key = key.toString();
        if (user.isDoctor == 0)
          userList.add(user);
        else
          doctorList.add(user);
      });
      userModuleElement = UserModuleElement(
          userRef: userDataRef,
          doctors: doctorList,
          users: userList);
      debugPrint('Doctor List Length: ' + doctorList.length.toString());
      notifyListeners();
    });

    subscription.onError((err) {
      debugPrint("error user Suscription : " + err.toString());
    });
    subscriptions.add(subscription);
  }

  Future<void> fetchMeetingModule() async {
    debugPrint("Fetch Meeting Called");
    if (app == null) app = await Firebase.initializeApp();
    var dbRef = FirebaseDatabase.instance.reference();

    var meetingDataRef = dbRef.child('Meeting');
    List<MeetingInfo> meetingList = [];

    var subscription = meetingDataRef.onValue.listen((event) {
      meetingList = [];
      final meetings = Map<String, dynamic>.from(event.snapshot.value);
      meetings.forEach((key, value) {
        var d = Map<String, dynamic>.from(value);
        MeetingInfo meet = MeetingInfo.fromMap(d);
        meet.key = key.toString();
        // debugPrint("meet : "+meet.toMap().toString());
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
  }
  Future<void> fetchTransactionModule() async {
    if (app == null) app = await Firebase.initializeApp();
    var dbRef = FirebaseDatabase.instance.reference();

    var transRef = dbRef.child('Transaction');
    List<TransactionInfo> transactionList = [];

    var subscription = transRef.onValue.listen((event) {
      transactionList.clear();
      final meetings = Map<String, dynamic>.from(event.snapshot.value);
      meetings.forEach((key, value) {
        var d = Map<String, dynamic>.from(value);
        TransactionInfo tx = TransactionInfo.fromMap(d);
        tx.key = key.toString();
        debugPrint("transaction : "+tx.toMap().toString());
        transactionList.add(tx);
      });
       transactionModuleElement = TransactionModule(
          transactions : transactionList, transactionRef: transRef);
      debugPrint('Transaction List Length: ' + transactionList.length.toString());
      notifyListeners();
    });
    subscription.onError((err) {
      debugPrint("error transaction Suscription : " + err.toString());
    });
    subscriptions.add(subscription);
  }

  Future<void> login()async{
   _googleUserAccount = await _googleSignIn.signIn();
   if(_googleUserAccount==null){
      loginState = LoginStates.loggedOut;
      // clearSubscriptions();
      // notifyListeners();
   }
   else{
     if (app == null) app = await Firebase.initializeApp();
     final googleAuth = await _googleUserAccount!.authentication;
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     await FirebaseAuth.instance.signInWithCredential(credential);
   }

  }

  void notify() {
    notifyListeners();
  }

  void dispose() {
    clearSubscriptions();
    for(var s in subscriptions){
      s.cancel();
    }
    subscriptions.clear();
    _authSubscription?.cancel();
    super.dispose();
  }

  void logout() async{
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
    // clearSubscriptions();
  }

  void clearSubscriptions(){
    // for(var s in subscriptions){
    //   s.cancel();
    // }
    // subscriptions.clear();
  }
}
