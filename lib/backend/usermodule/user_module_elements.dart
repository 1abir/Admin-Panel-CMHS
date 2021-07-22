import 'dart:async';

import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModuleElement {
  final List<UserInfoClass> doctors;
  final List<UserInfoClass> users;

  final DatabaseReference userRef;
  final StreamSubscription? dbSubscription;

  UserModuleElement({required this.userRef, required this.dbSubscription, required this.doctors,required this.users});

  Future<bool> updateElement(UserInfoClass info){
    if(info.key==null) return Future.value(false);
    bool noerr = true;
    userRef.child(info.key!).update(info.toMap()).then((value){
      noerr = true;
    }).catchError((onError){
      noerr = false;
    });
    return Future.value(noerr);
  }
}
