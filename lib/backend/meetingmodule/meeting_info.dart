class MeetingInfo {
  late String? key;
  String doctor_id;
  String patient_id;
  DateTime? meetingTime;
  int duration;
  int type;
  String? problem;

  MeetingInfo({this.key,
    required this.doctor_id,
    required this.patient_id,
    required this.meetingTime,
    required this.duration,
    required this.type,
    this.problem,
  });

  static MeetingInfo fromMap(Map<String, dynamic> data) {
    return MeetingInfo(
      doctor_id: data['doctor']??'',
      patient_id: data['patient']??'',
      meetingTime: DateTime.tryParse(data['meeting_time'].toString()),
      type: data['type']??0,
      duration: data['duration'] ?? 0,
      problem: data['problem'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctor' : doctor_id,
      'patient' : patient_id,
      'meeting_time' : meetingTime,
      'duration' : duration,
      'type' : type,
      'problem' : problem,
    };
  }
}
