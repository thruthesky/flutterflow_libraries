# Push notifications

The default behavior of FlutterFlow when it send push notifications is to read and write documents in the Firestore.

If your app has a group chat with active 1,000 users, and the app delivers push notifications on each chat, the app will create a document on each push notification and read more than 1,000 document of tokens. Yes, that's for every chat message. If your app has multiple active gruop chats, it will cost more.

We have our custom push notifications cloud functions. That works very much the same as the one provided by FlutterFlow. But it uses the Realtime Database. It will not cost anything by read/write.

You can simply copy and paste it into the Cloud functions menu and deploy.

The cloud functions will send messages by listening to the events of new chat message, comments, likes, and more.




## Installation

- You need to install a few cloud functions from your FlutterFlow dashboard.

### mirrorFcmTokens

- Create a new cloud function from your Cloud Functions in FlutterFlow
- Change the cloud function name as `mirrorFcmTokens`
- Copy the source code of [mirrorFcmTokens](https://raw.githubusercontent.com/thruthesky/super-library-firebase/refs/heads/main/mirror-fcm-tokens/functions/index.js)
- Replace the source code with the copy
- Deploy


### listenToChatMessage

- Create a new cloud function from your Cloud Functions in FlutterFlow
- Change the cloud function name as `pushNotificationOnChatMessage`
- Copy the source code of [super library send push notification](https://raw.githubusercontent.com/thruthesky/super-library-firebase/refs/heads/main/mirror-fcm-tokens/functions/index.js)
- Replace the source code with the copy
- Deploy



## Database structure


- **/mirrored-fcm-tokens**: is the node that will have the tokens. The key is the token. And the value is the user uid. The push tokens are mirrored from the `/users/<uid>/fcm_tokens/` collection.

