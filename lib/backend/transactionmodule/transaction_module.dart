import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionModule {
  List<TransactionInfo> transactions = [];
  List<String> txIds = [];
  final DatabaseReference transactionRef;
  final DatabaseReference rtdbRef;

  TransactionModule(
      {required this.transactions,
      required this.transactionRef,
      required this.rtdbRef}) {
    for (var i in transactions) {
      if (i.txID != '') {
        txIds.add(i.txID);
      }
    }
  }

  Future<bool> updateMeeting(TransactionInfo info) {
    var key = info.txID;
    var userID = info.toId;
    if (info.key == null) return Future.value(false);
    bool noerr = true;
    transactionRef.child(key).set(info.toMap()).then((value) {
      noerr = true;
    }).catchError((onError) {
      noerr = false;
    });
    rtdbRef
        .child('UserData/$userID/WithDrawHistory/$key')
        .set(info.toMap())
        .then((value) {
      print("done WithdrawHistory");
    }).catchError((onError) {
      print("Error in WithdrawHistory");
      print(onError);
    });
    return Future.value(noerr);
  }

  Future<bool> deleteMeeting(TransactionInfo info) {
    if (info.key == null) return Future.value(false);
    bool noerr = true;
    transactionRef.child(info.key!).remove().then((value) {
      noerr = true;
    }).catchError((onError) {
      noerr = false;
    });
    return Future.value(noerr);
  }

  Future<bool> createMeeting(TransactionInfo info) {
    // if(info.key==null) return Future.value(false);
    bool noerr = true;
    var key = info.txID;
    var userID = info.toId;
    transactionRef.child(key).set(info.toMap()).then((value) {
      print("done transaction");
    }).catchError((onError) {
      print("transaction error");
      print(onError);
    });

    rtdbRef
        .child('UserData/$userID/WithDrawHistory/$key')
        .set(info.toMap())
        .then((value) {
      print("done WithdrawHistory");
    }).catchError((onError) {
      print("Error in WithdrawHistory");
      print(onError);
    });

    return Future.value(noerr);
  }
}
