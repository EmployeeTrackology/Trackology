import 'dart:async';
import 'package:flutter/material.dart';
import 'package:emp_tracker/locator.dart';
import '../services/api.dart';
import 'package:emp_tracker/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<TheUser> users;

  Future<List<TheUser>> fetchTheUsers() async {
    var result = await _api.getDataCollection();
    users = result.docs
        .map((doc) => TheUser.fromMap(doc.data, doc.documentId))
        .toList();
    return users;
  }

  Stream<QuerySnapshot> fetchTheUsersAsStream() {
    return _api.streamDataCollection();
  }

  Future<TheUser> getTheUserById(String id) async {
    var doc = await _api.getDocumentById(id);
    return TheUser.fromMap(doc.data, doc.documentID);
  }

  Future removeTheUser(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateTheUser(TheUser data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addTheUser(TheUser data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
