import 'dart:async';

import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModuleElement {
  final List<UserInfoClass> doctors;
  final List<UserInfoClass> users;

  final DatabaseReference userRef;
  final StreamSubscription? dbSubscription;

  Map<String,String> idNameMap = {};
  List<String> doctorsIDs = [];
  List<String> userIDs = [];

  UserModuleElement({required this.userRef, this.dbSubscription, required this.doctors,required this.users}){
    doctorsIDs.clear();
    doctors.forEach((element) {
      if(element.key!=null) {
        doctorsIDs.add(element.key!);
        idNameMap[element.key!] = element.name;
      }
    });
    userIDs.clear();
    users.forEach((element) {
      if(element.key!=null) {
        userIDs.add(element.key!);
        idNameMap[element.key!] = element.name;
      }
    });
  }

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

  Future<bool> deleteUser(UserInfoClass info){
    if(info.key==null) return Future.value(false);
    bool noerr = true;
    userRef.child(info.key!).remove().then((value){
      noerr = true;
    }).catchError((onError){
      noerr = false;
    });
    return Future.value(noerr);
  }
  Future<bool> createUser(UserInfoClass info){
    if(info.key==null) return Future.value(false);
    bool noerr = true;
    userRef.child(info.key!).set(info.toMap()).then((value){
      noerr = true;
    }).catchError((onError){
      noerr = false;
    });
    return Future.value(noerr);
  }

  List<String> getUserKeys(){
    return userIDs;
  }
  List<String> getDoctorKeys(){

    return doctorsIDs;
  }

  List<String> getAllKeys(){
    return getUserKeys() + getDoctorKeys();
  }
}
