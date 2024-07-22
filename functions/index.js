const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

const firestore = admin.firestore();

exports.onUserStatusChange = functions.database.ref('/{uid}/active').onUpdate(
    async(change, context)=> {
        // get the data from realtime database
        const isActive = change.after.val();
        // get reference to cloud firestore doc
        const firestore = firestore.doc(`users/${context.params.uid}`);
        //update the value of firestore database
        return firestoreRef.update({
            active: isActive,
            lastSeen: Date.now(),
        })
    }
);