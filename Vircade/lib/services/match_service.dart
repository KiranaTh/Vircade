 //import 'dart:js_util';

 //import 'package:Vircade/widgets/provider_widget.dart';
import 'package:firebase_database/firebase_database.dart';
 //import 'dart:async';

 //import 'package:flutter/foundation.dart';

// class MatchDatabase {
//   String uid;
//   String battlesong;
//   Future<void> createWaitingRoom(context, song) async {
//     uid = await Provider.of(context).auth.getCurrentUID();
//     battlesong = song;
//     return FirebaseDatabase.instance
//         .reference()
//         .child("waitingRoom")
//         .child(battlesong)
//         .set({"userUID": uid});
//   }

//   Future<StreamSubscription<Event>> matchGame(song) async {
//     StreamSubscription<Event> subscription = FirebaseDatabase.instance
//         .reference()
//         .child("waitingRoom")
//         .child(song)
//         .onChildAdded
//         .listen((Event event){
//       var waiting = new Waiting.fromJson(event.snapshot.key, event.snapshot.value);
//       onData(waiting);
//     });
//     return subscription;
//   }
//
// }
class Waiting {
  String key;
  String userUID;

  Waiting(this.userUID);

  Waiting.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userUID = snapshot.value["userUID"];

  toJson() {
    return {"$userUID": userUID, "$userUID": userUID };
  }
}

//class Waiting {
//  String song;
//  String userUID;
//
//  Waiting.fromJson(this.song, Map data){
//    userUID = data['userUID'];
//    if(userUID == null){
//      userUID = "";
//    }
//  }
//}
