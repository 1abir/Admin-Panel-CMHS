import 'package:admin_panel/backend/meetingmodule/meeting_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MeetingModule {
  List<MeetingInfo> sessions = [];
  final DatabaseReference meetingReference;
  List<String> meetingIds = [];

  MeetingModule({required this.sessions, required this.meetingReference}) {
    sessions.forEach((element) {
      if (element.key != null) {
        meetingIds.add(element.key!);
      }
    });
  }

  Future<bool> updateMeeting(MeetingInfo info) {
    debugPrint("updateMeetingCalled");
    if (info.key == null) {
      debugPrint("null key");
      return Future.value(false);
    }
    bool noerr = true;
    meetingReference.child(info.key!).update(info.toMap()).then((value) {
      debugPrint("success");
      noerr = true;
    }).catchError((onError) {
      debugPrint("error"+onError.toString());
      noerr = false;
    });
    return Future.value(noerr);
  }

  Future<bool> deleteMeeting(MeetingInfo info) {
    if (info.key == null) return Future.value(false);
    bool noerr = true;
    meetingReference.child(info.key!).remove().then((value) {
      noerr = true;
    }).catchError((onError) {
      noerr = false;
    });
    return Future.value(noerr);
  }

  Future<bool> createMeeting(MeetingInfo info) {
    // if(info.key==null) return Future.value(false);
    bool noerr = true;
    meetingReference.push().set(info.toMap()).then((value) {
      noerr = true;
    }).catchError((onError) {
      noerr = false;
    });
    return Future.value(noerr);
  }

  List<String> getMeetingKeys() {
    List<String> ret = [];
    sessions.forEach((element) {
      if (element.key != null)
        ret.add(element.key!);
    });
    return ret;
  }
}
