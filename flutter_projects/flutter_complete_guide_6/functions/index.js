const functions = require('firebase-functions');
const admin = require('firebase-admin');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

admin.initializeApp();

exports.myFunction = functions.firestore
    .document('chat/{message}')
    .onCreate((snapshot, context) => {
        const data = snapshot.data();
        return admin.messaging().sendToTopic('chat', {
            notification: {
                title: data.username,
                body: data.text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            }
        });
    });
