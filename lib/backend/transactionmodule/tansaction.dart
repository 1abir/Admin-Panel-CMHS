import 'package:admin_panel/backend/utils/formatter.dart';

class TransactionInfo {
  String? key;
  String txID;
  DateTime? dateTime;
  double amount;
  String type;
  String fromId;
  String? toId;
  String? meetingId;

  TransactionInfo(
      {this.key,
      required this.txID,
      required this.dateTime,
      required this.amount,
      required this.type,
      required this.fromId,
      this.toId,
      this.meetingId});

  Map<String, dynamic> toMap() {
    return {
      'txID': txID,
      'dateTime': FormattedDate.format(dateTime) ??
          FormattedDate.format(DateTime.now()),
      'amount': amount,
      'type': type,
      'from_id': fromId,
      'to_id': toId,
      'meeting_id': meetingId,
    };
  }

  static TransactionInfo fromMap(Map<String, dynamic> data) {
    return TransactionInfo(
      txID: data['txID'] ?? '',
      dateTime: DateTime.tryParse(data['dateTime'].toString()) ??
          FormattedDate.parse(data['dateTime']) ??
          DateTime.now(),
      amount: double.tryParse(data['amount'].toString()) ?? 0.0,
      type: data['type'] ?? '',
      fromId: data['from_id'] ?? '',
      toId: data['to_id'] ?? '',
      meetingId: data['meeting_id'] ?? '',
    );
  }

  void copyFrom(TransactionInfo other) {
    key = other.key;
    txID = other.txID;
    dateTime = other.dateTime;
    amount = other.amount;
    type = other.type;
    fromId = other.fromId;
    toId = other.toId;
    meetingId = other.meetingId;
  }
}
