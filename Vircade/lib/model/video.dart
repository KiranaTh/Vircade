import 'package:cloud_firestore/cloud_firestore.dart';

var songs = [];
Future<List> getVideo() async {
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection('song').getDocuments();
  if (qn.documents.length != 0) {
    for (int i = 0; i < qn.documents.length; i++) {
      songs.add(qn.documents[i]);
    }
  } else {
    print("No data");
  }
  return songs;
}
