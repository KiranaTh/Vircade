const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

var database = admin.database();

exports.matchmaker = functions.database.ref('waitingRoom/{song}/{userUID}')
    .onCreate((snap, context) => {

        var gameID = generateGameID();
        var song = context.params.song;
        var userUID = context.params.userUID;

        console.log("song: " + song + "   userid: " + userUID)

        database.ref('waitingRoom').child(song).once('value').then(players => {
            console.log("success once value");
            var secondPlayer = null;
            players.forEach(player => {
                if (player.val() === "waiting" && player.key !== userUID) {
                    secondPlayer = player;
                    console.log("set second player:" + player.key);
                }
            });

            if (secondPlayer === null) return null;

            database.ref('waitingRoom').child(song).transaction(function (matchmaking) {

                // If any of the players gets into another game during the transaction, abort the operation
                if (matchmaking === null || matchmaking[userUID] !== "waiting" || matchmaking[secondPlayer.key] !== "waiting") {
                    return matchmaking;
                }

                console.log("success change value to gameID");
                matchmaking[userUID] = gameID;
                matchmaking[secondPlayer.key] = gameID;
                return matchmaking;

            }).then(result => {

                if (result.snapshot.child(userUID).val() !== gameID) {
                    console.log("result.snapshot.child(userUID).val()" + result.snapshot.child(userUID).val());
                    return;
                }
                var game = {
                    [userUID]: {
                        score: 0,
                        ML: ""
                    },
                    [secondPlayer.key]: {
                        score: 0,
                        ML: ""
                    },
                    song: song,
                    time: Date.now()
                }

                database.ref("games/" + gameID).set(game).then(snapshot => {

                    console.log("Game created successfully!")
                    return null;
                }).catch(error => {
                    console.log(error);
                });

                return null;

            }).catch(error => {
                console.log(error);
            });

            return null;
        }).catch(error => {
            console.log(error);
        });
    });

// exports.storeData = functions.database.ref('games/{gameID}/{userID}/score').onUpdate(snap, context) => {
//     var userUID = context.params.userUID;
//     const firestoreDb = admin.firestore();
//     return firestoreDb.collection("userData").doc(gameID).update({history.})
// }

// exports.calWinner = functions.database.ref('games/{gameID}/{userID}/score').onUpdate((snap, context) => {
//     var FirstPlayerScore = snap.val();
//     var FirstPlayer = context.params.userID;
//     var gameID = context.params.gameUID;
//     const firestoreDb = admin.firestore();
//     return firestoreDb.collection("userData").doc(gameID).once('value').then(players => {
//         console.log("success once value");
//         var secondPlayerScore = null;
//         var secondPlayer = null;
//         players.forEach(player => {
//             if (player.val["score"] !== null && FirstPlayerScore !== null) {
//                 secondPlayerScore = player.val["score"];
//                 secondPlayer = player.key
//                 console.log("set second player:" + secondPlayerScore);
//             }
//         });

//         if (secondPlayer === null && )
//         if (secondPlayerScore === null || FirstPlayerScore === null) return null;
// })
// });


// exports.cleanDB = functions.database.ref('games').onWrite((snap, context) => {

//     var gameID = context.params.gameID;
//     const timeNow = Date.now();

//     database.ref('games').once('value', (snapshot) => {
//         snapshot.forEach((child) => {
//             if ((Number(child.val()['time']) + 1800000) <= timeNow) {
//                 child.ref.set(null);
//             }
//         });
//     });
//     return res.status(200).end();
// });

exports.cleanDB = functions.database.ref('games/{gameID}').onWrite((change, context) => {
  var ref = change.after.ref.parent; 
  var now = Date.now();
  var cutoff = now - 360000;
  var oldItemsQuery = ref.orderByChild('time').endAt(cutoff);
  return oldItemsQuery.once('value', function(snapshot) {
    var updates = {};
    snapshot.forEach(function(child) {
      updates[child.key] = null
    });
    return ref.update(updates);
  });

});

function generateGameID() {
    var possibleChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var gameID = "";
    for (var i = 0; i < 20; i++) gameID += possibleChars.charAt(Math.floor(Math.random() * possibleChars.length));
    return gameID;
}

// }
