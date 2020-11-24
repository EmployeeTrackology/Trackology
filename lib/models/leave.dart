

enum LeaveStatus { approved, pending, rejected, undetermined }
enum LeaveType { ml, al, cl, undetermined }
class Leave {
  DateTime appliedDate;
  DateTime fromDate;
  DateTime toDate;
  LeaveStatus status;
  bool withdrawalStatus;
  String message;
  LeaveType type;
  String name;
  String userUid;

  Leave(
      {
      this.appliedDate,
      this.fromDate,
      this.toDate,
      this.type,
      this.status,
      this.userUid
      });

  factory Leave.fromJson(String key, Map<String, dynamic> parsedJson) {
    return Leave(
        appliedDate: formattedProperDateTime(parsedJson['appliedDate']),
        fromDate: formattedProperDateTime(parsedJson['fromDate']),
        toDate: formattedProperDateTime(parsedJson['toDate']),
        type: getType(parsedJson['type']),
        status: getStatus(parsedJson['status'])
        );
  }
}

DateTime formattedProperDateTime(String date) {
  return DateTime.parse(
      date.toString().split("-").reversed.join("-").toString() + " 01:00:00");
}

LeaveType getType(String type) {
  if (type == "al") {
    return LeaveType.al;
  }
  if (type == "cl") {
    return LeaveType.cl;
  }
  if (type == "ml") {
    return LeaveType.ml;
  }
  return LeaveType.undetermined;
}

LeaveStatus getStatus(String status) {
  if (status == "approved") {
    return LeaveStatus.approved;
  }
  if (status == "pending") {
    return LeaveStatus.pending;
  }
  if (status == "rejected") {
    return LeaveStatus.rejected;
  }
  return LeaveStatus.undetermined;
}
