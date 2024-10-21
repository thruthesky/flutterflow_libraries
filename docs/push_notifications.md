# Push notifications

The default behavior of FlutterFlow when it send push notifications is to create a document in the Firestore. That soon flood in the full of documents. Imagine you have a busy chat app that have multiple group chat rooms with thoughs of active users. For every chat message, it will create a document.



We have our custom push notifications cloud functions. You can simply copy and paste it into the Cloud functions menu and deploy.

The cloud functions will send messages by listening to the events of new chat message, comments, likes, and more.


