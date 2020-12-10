class User {
  final int id;
  final String name;
  final String imageUrl;
  final String score;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.score,
  });
}

final User sam =
    User(id: 0, name: 'SAM', imageUrl: 'assets/video1.jpg', score: '93248');
final User steven =
    User(id: 1, name: 'STEVEN', imageUrl: 'assets/video1.jpg', score: '78697');
final User olivia =
    User(id: 2, name: 'OLIVIA', imageUrl: 'assets/video1.jpg', score: '66757');
final User john =
    User(id: 3, name: 'JOHN', imageUrl: 'assets/video1.jpg', score: '57678');
final User greg =
    User(id: 4, name: 'GERG', imageUrl: 'assets/video1.jpg', score: '49677');
final User emma =
    User(id: 5, name: 'EMMA', imageUrl: 'assets/video1.jpg', score: '46547');
final User dean =
    User(id: 6, name: 'DEAN', imageUrl: 'assets/video1.jpg', score: '43234');
final User tiffany =
    User(id: 7, name: 'TIFFANY', imageUrl: 'assets/video1.jpg', score: '34325');
final User jessica =
    User(id: 8, name: 'JESSICA', imageUrl: 'assets/video1.jpg', score: '21434');
final User krystal =
    User(id: 9, name: 'KRYSTAL', imageUrl: 'assets/video1.jpg', score: '15694');

//import 'package:cloud_firestore/cloud_firestore.dart';

// FAVORITE CONTACTS
List<User> tops = [
  sam,
  steven,
  olivia,
  john,
  greg,
  emma,
  dean,
  tiffany,
  jessica,
  krystal
];
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//
//class User {
//  String uid;
//  String song;
//  String score;
//
//  User.fromJson(this.uid, Map data) {
//    score = data['score'];
//    song = data['song'];
//  }
//}

//import 'package:cloud_firestore/cloud_firestore.dart';
//
//var act = [];
//Future<List> getAct() async {
//  var firestore = Firestore.instance;
//  QuerySnapshot qn = await firestore.collection('activities').getDocuments();
//  if (qn.documents.length != 0) {
//    for (int i = 0; i < qn.documents.length; i++) {
//      act.add(qn.documents[i]);
//    }
//  } else {
//    print("No data");
//  }
//  return act;
//}
//class RankList {
//  String time;
//  Map<String, dynamic> sets = {};
//  String score;
//  String song;
//  RankList(this.time, this.song, this.score);
//  RankList.fromMap(json)
//      : song = json['song'].toString(),
//        score = json['score'].toString();
//
//
//}
