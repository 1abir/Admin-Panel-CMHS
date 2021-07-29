import 'package:admin_panel/backend/utils/formatter.dart';

class MeetingInfo {
  late String? key;
  String doctorId;
  String patientId;
  DateTime? meetingTime;
  int duration;
  int type;
  String? problem;

  MeetingInfo({
    this.key,
    required this.doctorId,
    required this.patientId,
    required this.meetingTime,
    required this.duration,
    required this.type,
    this.problem,
  });

  static MeetingInfo fromMap(Map<String, dynamic> data) {
    return MeetingInfo(
      doctorId: data['doctor'] ?? '',
      patientId: data['patient'] ?? '',
      meetingTime: DateTime.tryParse(data['meeting_time'].toString()) ??
          FormattedDate.parse(data['meeting_time']),
      type: data['type'] ?? 0,
      duration: data['duration'] ?? 0,
      problem: data['problem'],
    );
  }

  static MeetingInfo fromMap2(Map<String, dynamic> data) {
    return MeetingInfo(
      doctorId: data['id'] ?? '',
      patientId: data['patient'] ?? '',
      meetingTime: DateTime.tryParse(data['time'].toString()) ??
          FormattedDate.parse(data['time']),
      type: data['type'] ?? 0,
      duration: data['duration'] ?? 0,
      problem: data['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctor': doctorId,
      'patient': patientId,
      'meeting_time': FormattedDate.format(meetingTime),
      'duration': duration,
      'type': type,
      'problem': problem,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'id': doctorId,
      'time': FormattedDate.format(meetingTime),
      'duration': duration,
      'type': type,
      'comment': problem,
    };
  }
}
