import 'package:admin_panel/backend/utils/formatter.dart';

class TransactionInfo {
  String? key;
  String txID;
  DateTime? dateTime;
  double amount;
  String type;
  String from_id;
  String? to_id;
  String? meeting_id;

  TransactionInfo(
      {this.key,
      required this.txID,
      required this.dateTime,
      required this.amount,
      required this.type,
      required this.from_id,
      this.to_id,
      this.meeting_id});

  Map<String, dynamic> toMap() {
    return {
      'txID': txID,
      'dateTime': dateTime,
      'amount': amount,
      'type': type,
      'from_id': from_id,
      'to_id': to_id,
      'meeting_id': meeting_id,
    };
  }

  static TransactionInfo fromMap(Map<String, dynamic> data) {
    return TransactionInfo(
      txID: data['txID'] ?? '',
      dateTime: DateTime.tryParse(data['dateTime'].toString()) ??
          FormattedDate.parse(data['dateTime'].toString()),
      amount: double.tryParse(data['amount'].toString()) ?? 0.0,
      type: data['type'] ?? '',
      from_id: data['from_id'] ?? '',
      to_id: data['to_id'],
      meeting_id: data['meeting_id'],
    );
  }

  void copyFrom(TransactionInfo other) {
    key = other.key;
    txID = other.txID;
    dateTime = other.dateTime;
    amount = other.amount;
    type = other.type;
    from_id = other.from_id;
    to_id = other.to_id;
    meeting_id = other.meeting_id;
  }
}
