import 'package:admin_panel/backend/meetingmodule/meeting_info.dart';
import 'package:firebase_database/firebase_database.dart';

class MeetingModule {
  List<MeetingInfo> sessions = [];
  final DatabaseReference meetingReference;

  MeetingModule({required this.sessions, required this.meetingReference});

}
