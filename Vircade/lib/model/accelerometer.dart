import 'dart:async';

class Accelerometer {
  String userUID;
  String song;
  Timer time;
  List<List<String>> datas;

  Accelerometer({this.userUID, this.song, this.time, this.datas});
  Map<String, dynamic> toJson() {
    return {
      "userUID": userUID,
      "song": song,
      "time": time,
      "Data": datas,
    };
  }
}
