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


### pushNotificationOnChatMessage

- Create a new cloud function from your Cloud Functions in FlutterFlow
- Change the cloud function name as `pushNotificationOnChatMessage`
- Copy the source code of [super library send push notification](https://raw.githubusercontent.com/thruthesky/super-library-firebase/refs/heads/main/send-push-notifications/functions/index.js)
- Replace the source code with the copy
- Deploy

### pushNotificationOnData

- Do the same as `pushNotificationOnChatMessage` except changing the cloud function name to `pushNotificationOnData`.

### pushNotificationOnComment

- Do the same as `pushNotificationOnChatMessage` except changing the cloud function name to `pushNotificationOnComment`.




## Database structure

### Push notification tokens

- **/mirrored-fcm-tokens**: is the node that will have the tokens. The key is the token. And the value is the user uid. The push tokens are mirrored from the `/users/<uid>/fcm_tokens/` collection.



### Push notification subscriptions

- `/fcm-subscriptions/<group-id>`: is the node that will save all the subscriptions.
  - The `group-id` can be a `category` of data group, a `chat room id`, or it can be somethign else.

- For the `category` of the data group, the uids of the users who subscribe for that category will be saved as a key and the value will be `true`.
  - If the category is `qna` and the user uid is `user-A`, then the data structure is like below.
    - `/fcm-subscriptions/qna { user-A: true }`
  - You can provide an icon to turn on/off on each forum category. Or you can give a user of a subscription settings screen to manage the whole subscription options available in the app.

- For the chat room, the behavior of subscription of the chat room is reversed. Meaning, the user's uid is saved under the `/fcm-subscriptions/<chat-room-id>`, it means the user has unsubscribed the chat room. And when there is no uid saved under the subscription node, the subscription for the user is on.
    - To achieve this,
      - display the subscription icon on when there is no uid under the subscription path.
      - Display the subscription icon off when there is uid under the subscription path.
      - Send push notification (on every chat message) to those users (of the chat room) whose uid is NOT in the subscription path.



- For like of profile
  - Let each user to choose to get push notifications or not when somebody liked on his profile.
  - By default, it's on.


- For like of data
  - Let each user to choose to get push notifications or not when somebody liked on his data.
  - By default, it's on.


- For like of comment
  - Let each user to choose to get push notifications or not when somebody liked on his comment.
  - By default, it's on.


### Push notification icon

Use `PushNotificationIcon` to display the subscription on/off.


