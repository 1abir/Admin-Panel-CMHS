import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionModule {
  List<TransactionInfo> transactions = [];
  List<String> txIds=[];
  final DatabaseReference transactionRef;

  TransactionModule({required this.transactions, required this.transactionRef}){
    for(var i in transactions){
      if(i.txID!=''){
        txIds.add(i.txID);
      }
    }
  }

  Future<bool> updateMeeting(TransactionInfo info){
    if(info.key==null) return Future.value(false);
    bool noerr = true;
    transactionRef.child(info.key!).update(info.toMap()).then((value){
      noerr = true;
    }).catchError((onError){
      noerr = false;
    });
    return Future.value(noerr);
  }

  Future<bool> deleteMeeting(TransactionInfo info){
    if(info.key==null) return Future.value(false);
    bool noerr = true;
    transactionRef.child(info.key!).remove().then((value){
      noerr = true;
    }).catchError((onError){
      noerr = false;
    });
    return Future.value(noerr);
  }
  Future<bool> createMeeting(TransactionInfo info){
    // if(info.key==null) return Future.value(false);
    bool noerr = true;
    transactionRef.push().set(info.toMap()).then((value){
      noerr = true;
    }).catchError((onError){
      noerr = false;
    });
    return Future.value(noerr);
  }

}