# User

- [User](#user)
  - [Overview](#overview)
  - [User Authentication](#user-authentication)
  - [UserAvatar](#useravatar)
  - [DisplayName](#displayname)
  - [User List View](#user-list-view)
    - [Alternative Option](#alternative-option)
    - [Customizing the UI](#customizing-the-ui)
    - [Horizontal Scrolling](#horizontal-scrolling)
    - [Examples](#examples)
  - [How to Customize UI Design in UserListView](#how-to-customize-ui-design-in-userlistview)
    - [Step 1: Create UserListIcon Component](#step-1-create-userlisticon-component)
    - [Step 2: Design UserListIcon Component](#step-2-design-userlisticon-component)
    - [Step 3: Create PublicProfileScreen](#step-3-create-publicprofilescreen)
    - [Step 4: Add onTap Action to UserListIcon](#step-4-add-ontap-action-to-userlisticon)
    - [Step 5: Design PublicProfileScreen](#step-5-design-publicprofilescreen)
  - [Different UI Design on Each Screen](#different-ui-design-on-each-screen)
- [User Search](#user-search)
  - [Setting Up User Search](#setting-up-user-search)
  - [Search Options](#search-options)
  - [Note](#note)
  - [Search Users by `display_name` (Case-Insensitive)](#search-users-by-display_name-case-insensitive)
    - [Example Users](#example-users)
    - [Search Criteria](#search-criteria)
    - [Important Note](#important-note)
  - [Functions](#functions)
    - [isAnonymous](#isanonymous)
  - [Blocking User](#blocking-user)
    - [Database structure for Blocking](#database-structure-for-blocking)
    - [blocking a user](#blocking-a-user)
    - [Un-blocking a User](#un-blocking-a-user)
    - [Listing the blocked users](#listing-the-blocked-users)
  - [Widgets](#widgets)
    - [BlockedUser](#blockeduser)
  - [Security](#security)


## Overview

- The user's `display_name` and `photo_url` are mirrored from Firestore to the Realtime Database.
- The user's `display_name` is also stored in `display_name_lowercase` (in lowercase) for better searchability in both Firestore and the Realtime Database.

## User Authentication

The Super Library supports Firebase user authentication only.

You can continue using FlutterFlow's authentication methods seamlessly with the Super Library.

## UserAvatar

Use the `UserAvatar` widget to display a user's photo. This widget gets user profile photo url from the Realtime Database.

- **No Photo URL**: If no photo URL is provided, it shows a user icon.
- **Background Color**: The background color is `FlutterFlowTheme.of(context).alternate`.
- **Foreground Color**: The foreground color is `FlutterFlowTheme.of(context).primaryText`.

| No photo url                      | With with photo url                |
| --------------------------------- | ---------------------------------- |
| ![image.png](/images/image_2.png) | ![image.png](/images/image(2).png) |



## DisplayName

Use the `DisplayName` widget to display the display name of a user. This widget displays user's display name from the Realtime Database.




## User List View

To list users from the Realtime Database, use the `UserListView` widget.

### Alternative Option

You can also use the built-in FlutterFlow Backend Query to list users from Firestore. This is a fine option if you are not concerned about the cost.

### Customizing the UI

You have several options to customize the UI design:

- **Default UI**: Use the built-in default UI.
- **Default Component**: Use the default component provided.
- **Custom Component**: Design your own component.

### Horizontal Scrolling

You can make the `UserListView` display and scroll horizontally.

### Examples

For examples, visit the [Super Library Example](https://github.com/thruthesky/super_library_example/tree/main/lib/screens/user).

## How to Customize UI Design in UserListView

### Step 1: Create UserListIcon Component

- **Parameters**:
    - `uid` (String, required)
    - `displayName` (String, required)
    - `photoUrl` (ImagePath, optional)

### Step 2: Design UserListIcon Component

- Customize the design of the `UserListIcon` component as needed.

### Step 3: Create PublicProfileScreen

- **Screen Name**: You can name this screen as you like.

### Step 4: Add onTap Action to UserListIcon

- **Action**: Open the `PublicProfileScreen` when `UserListIcon` is tapped.
- **Customization**: You can add any action and customize the UI/UX as desired.

### Step 5: Design PublicProfileScreen

- Customize the design of the `PublicProfileScreen` as needed.

## Different UI Design on Each Screen

You can design a different UI on each screen by following these steps:

1. **Design the Component**:
    1. Create components to display user in each screen.
2. **Call a Custom Action**:
    1. Use a custom action to set the `userListTile` component.
    2. Example: `Component.userListTile = (user) => ...`



# User Search

The Super Library does not provide UI or code for user search due to FlutterFlow's limitations. Follow these steps to create your own user search:

## Setting Up User Search

1. **Add `display_name_lowercase` Field**:
    1. This field will be automatically saved in the Firestore user document.
    2. Add a field named `display_name_lowercase` in the user schema.
    3. This field will store the lowercase version of the user's `display_name`.
2. **Search Implementation**:
    1. Compare user input in lowercase to the value of `display_name_lowercase`.
    2. Use the `.toLowerCase()` method for comparison.

## Search Options

You can filter/search the user's `display_name_lowercase`:

- **Equality Match**: Exact match.
- **Partial Match**: Match the beginning part of the name.

## Note

This is the nature of how FlutterFlow works, so the Super Library does not provide any UI for this feature. For an example, please see the [Super Library sample project](https://app.flutterflow.io/project/test-super-library-ldkmay).

You can also write custom code to search for users in the Realtime Database.

## Search Users by `display_name` (Case-Insensitive)

### Example Users

Let’s there are users whose display_name are;

- Young One
- younG Two
- You and Me

### Search Criteria

To search for users whose `display_name` begins with "you" (case-insensitive), you can query Firestore on `display_name_lowercase` field and display the results in a `ListView`.

### Important Note

Allowing users to search for other users with a single letter, like `a`, can result in a large number of users being listed. This can lead to spam messages being sent to users whom they don't know. To prevent this, it is recommended to limit the search to words that are longer than 3 or 4 characters. This helps ensure that search results are more specific and reduces the likelihood of spam.



## Functions

### isAnonymous

See the custom actions page


## Blocking User

### Database structure for Blocking

- `/users/<uid> { blockedUsers: [ ... ] }`: The uid of other users will be saved in the login user's Firestore document.
  - When the user A blocks the other user B, B's uid is saved in `/users/A/{ blockedUsers: [ B ] }`.
  - It's the string of uid. Not the reference of the user.

### blocking a user

- To block a user, you can call `blockUser` custom action to block a user.
  - Or you can simply create your own Backend Query to save the other user's uid into the `blockedUsers` array field in your user document.

- The `blockUser` custom action will save the user's uid into the `blockedUsers` array field.
  - And the `blockedUsers` field will be mirrored to `/blocked-users/<my-uid>/` by the `_mirrorUserData` method in the super library automatically.

### Un-blocking a User

- Super library does not provide any method to detect if a user is blocked by the login user or not to make it simple.
  - It's too easy to provide a helper logic.
- To know if a user is blocked or not, simply do the way how the FlutterFlow goes
  - The `blockedUsers` is in your document. Meaning, it will be automatically synced with the `Authenticated User` variable in FlutterFlow.
    - So, you don't need to query to the Firestore to know if someone is blocked by you or not.
  - To display if the user is blocked or not, check if the user's uid is in the `blockedUsers` of `Authenticated User`.
    - And if the uid exists, then the user is blocked and you can unblock the user.
    - Again super library does not provide any method for this. You can simply query the Firestore to remove the other user's uid from `blockedUsers` array field.
- The super library will automatically remove the user's uid from the Realtime Database if the uid is removed from the `blockedUsers` array field the user's document.


### Listing the blocked users

- Simply list the users of `blockedUsers` in the user's document.
- And remove the uid of the user from the `blockedUsers` in the user's document to rmeove the user from the blocked list.



## Widgets

### BlockedUser

This widget listens the blocked users in th Realtime Database and build the UI based on the status of the block.
This widget is usefuly on custom coding. You may not use it in the FlutterFlow canvas directly.





## Security

- We recommend locking the document to prevent unauthorized access. Instead, use the `UserAvatar` and `DisplayName` widgets to display user information.
  - This is because the user document in Firestore may contain private information such as phone numbers or email addresses.
  - And the `UserAvatar` and `DisplayName` access data from the Realtime Database where there should be no private information.







