class UserInfoClass {
  int byear;
  double credit;
  String gender;
  String name;
  String? ftype;
  int type;
  int isDoctor;
  int isAdmin;
  String affiliation;
  String? specialization;
  String? key;

  UserInfoClass({
    required this.byear,
    required this.credit,
    required this.gender,
    required this.name,
    required this.ftype,
    required this.type,
    required this.isDoctor,
    required this.affiliation,
    this.specialization,
    required this.isAdmin,
  });

  static UserInfoClass fromMap(Map<String, dynamic> data) {
    // debugPrint("Error was here");
    return UserInfoClass(
      byear: int.tryParse(data['byear'].toString()) ?? 0,
      credit: double.tryParse(data['credit'].toString()) ?? 0,
      gender: data['gender'] ?? '',
      name: data['name'] ?? '',
      type: data['type'] ?? 0,
      affiliation: data['affiliation'] ?? '',
      isDoctor: data['isDoctor'] ?? 0,
      ftype: data['ftype'],
      specialization: data['specialization'],
      isAdmin: data['isAdmin'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'byear': byear.toString(),
      'credit': credit,
      'gender': gender,
      'name': name,
      'type': type,
      if (isDoctor == 1) 'affiliation': affiliation,
      if (isDoctor == 1) 'isDoctor': isDoctor,
      if (isDoctor == 1) 'specialization': specialization,
      if (isAdmin == 1) 'isAdmin': isAdmin,
    };
  }
}
