# Super Library


## Why We Built the Super Library

Our goal was to create the best and most scalable apps.

FlutterFlow is an excellent tool. It allows you to build apps easily with visual development while supporting custom source coding. This gives you the freedom to build anything on top of your FlutterFlow app.

FlutterFlow supports Firestore and Supabase by default. However, for maximum scalability, we prefer something different.

We chose Realtime Database support because it is simpler, easier, faster, cheaper, and ideal for mid-size apps.

To be clear, the Realtime Database is our choice based on our specific needs. You may have different thoughts on scalability, and that's perfectly fine. We are not saying that Firestore and Supabase are not scalable. They are among the best and highly scalable options available. We just found that the Realtime Database scales better for our apps.


## How can I use it in my FlutterFlow project?

Simply add it as a dependency. And read the [best practice document](./best_practice.md).




## Is it for FlutterFlow only?

No. The Super Library can be used with any Flutter project. While it is built specifically for FlutterFlow, you can use it however you like. The library is available as a package on [pub.dev](https://pub.dev). We recommend forking it and adding it as a dependency in your Flutter project.



## Issues with Firestore

- **Document Reads**: Reading one document often requires reading additional related documents, like user information.
- **Data Usage**: Firestore requires downloading entire documents, increasing data usage and battery drain for end-users.

## Advantages of Realtime Database

- **Efficiency**: Faster, simpler, and cheaper than Firestore.
- **Selective Data**: Allows downloading only specific fields.
- **Ideal Use**: Suitable for large chat apps or social community apps with high read/write operations.

## Current Limitations

- **Widget Builder**: Supported only for Components, not Custom Widgets. This makes integration more complex.
- **Marketplace**: Super library may not be published in the Marketplace as it uses Firebase, which is against FlutterFlow's principles.

## Want to Use the Super Library?

Until the Super Library is published to the marketplace, you can:

- **Copy the Super Library**: Get a copy and create your own version. It's an open source.
- **Add as a Dependency**: Directly add the Super Library as a dependency to your project. You may ask me to add your account in the super library project for read preveileges.

If you need help, email me at: thruthesky@gmail.com




## Cost of Firestore

We chose the Realtime Database over Firestore mainly due to cost. While Firestore is popular and preferred by many developers, it is more expensive than the Realtime Database.

### Example Scenario

Imagine you have a chat app with 10,000 active users per day. Each user opens 10 chat rooms, and each chat room downloads 100 messages on average. Users may scroll up to load more messages.

- **Reads Calculation**: 
  - 10,000 users * 10 chat rooms * 100 messages = 10,000,000 reads
  - Cost: 10,000,000 reads = USD 3.1

### Additional Reads

There are extra document reads, such as reading user documents or documents in security rules to support chat functionality. Let's multiply the cost by 3.

- **Adjusted Cost**: 
  - USD 3.1 * 3 = USD 9.3 per day

### More Cases

Your app will likely read more documents, such as:

- Listing chat rooms in a "my-chat-room-list" screen
- Displaying the number of unread messages per chat room
- Showing the total number of unread messages across all chat rooms

Let's multiply the cost by 2.

- **Final Cost**: 
  - USD 9.3 * 2 = USD 18.6 per day

### Conclusion

Your app will read even more documents in various scenarios, and you also have to pay for writing documents.

With the Realtime Database, reading documents is free. Yes, there is no cost at all. Writing is also free.



## Simplicity

The Super Library includes the most common building blocks your app needs. Check out the features it provides. We've made it as simple as possible and will keep updating it to make it even simpler.




