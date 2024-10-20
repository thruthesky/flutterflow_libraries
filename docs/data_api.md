# Data API

Imagine you are building a social app that displays users' tweets, photos, and comments on a scrollable main screen. If your app grows, using Firestore can become expensive due to the costs associated with reading, writing, and downloading the size of documents from Firestore.

Using the Realtime Database is faster, cheaper, and simpler.

## Features

The `Data API` provides default CRUD operations for the Realtime Database:

- **readData**: Custom action to read data.
- **writeData**: Custom action to create or update data.
- **deleteData**: Custom action to delete data.
- **DataListView**: Widget to display a list of values in a data group.
- **Data**: Widget to display a value of the data.

## Comment API

With the `Comment API`, you can easily build blog or forum community apps. Refer to the `Comment API` documentation for more details.




## Database Structure

To achieve the concept of `SSOT` (Single Source of Truth), we save all data in the `/data` node in the Realtime Database.

### Security

- To prevent attacks that involve writing excessively large data (e.g., very long titles or content), you can add security rules to limit the size of these fields.

### Data Format

- Data in the Realtime Database is stored in JSON format.
- The first level of keys in the `/data` node are the IDs of the data entries.
- The second level of keys are the properties of each data entry.

### Example Structure

```json
/data {
    "key-1": {
        "property-1": "...",
        "property-2": "..."
    },
    "key-2": {
        "property-1": "...",
        "property-2": "..."
    }
}
```

### Fields of a Node

- **uid**: The creator's user ID.
- **category**: The category of the data, ordered by recent posts.
- **order**: The order of the data.
- **title**: The title of the data.
- **content**: The content of the data.
- **urls**: URLs of photos and files associated with the data.
- **createdAt**: The creation timestamp.
- **updatedAt**: The update timestamp.

Example representation:


```json
/data
  /key-1 {
    "category": "qna-1630000000000",
    "order": -1630000000000,
    "uid": "uid",
    "title": "title",
    "content": "content",
    "urls": ["url1", "url2"],
    "createdAt": 1630000000000,
    "updatedAt": 1630000000000
  }
```



## Developer's guide line


### To get data of a category in order

```dart
final ref = PostService.instance.postsRef
    .orderByChild('category')
    .startAt('$category-')
    .endAt('$category-9999999999999999999999');

final snapshot = await ref.get();
for (var v in snapshot.children) {
  log('v: ${v.key}, value: ${(v.value as Map)["title"]}');
}
```