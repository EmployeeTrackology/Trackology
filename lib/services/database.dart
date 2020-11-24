import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_tracker/models/leave.dart';

class DatabaseService {
  final CollectionReference leaves =
      FirebaseFirestore.instance.collection('leaves');
  var uid;
  DatabaseService({this.uid});
  Future updateUserLeave(fromDate, toDate, appliedDate, type, status) async {
    return await leaves.doc(uid).set({
      'fromDate': fromDate,
      'toDate': toDate,
      'appliedDate': appliedDate,
      'type': type,
      'status': status
    });
  }

  List<Leave> _leaveList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Leave(
          appliedDate: doc.data()['appliedDate'] ?? '0',
          fromDate: doc.data()['fromDate'] ?? '0',
          toDate: doc.data()['toDate'] ?? '0',
          type: doc.data()['type'] ?? '',
          status: doc.data()['status'] ?? '',
          userUid: doc.data()['userUid'] ?? '');
    }).toList();
  }

  Stream<List<Leave>> get leaveApp {
    return leaves.snapshots().map(_leaveList);
  }
}
