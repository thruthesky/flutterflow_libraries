
# Quick Start

To use the Super Library, you need to add initialization code.

## Why Initialization is Needed

- **Web**: Firebase Realtime Database requires the databaseURL option to run the web applications.

There are three different cases to set up for the web application.

1. If you are not running your app in the web application, you don't need to init it.
2. 



## Adding initApp Custom Action

Add the `initApp` custom action as shown below:

```dart
import 'package:super_library/custom_code/actions/super_library.dart';

Future initApp() async {
  SuperLibrary.instance.init(
    getDatabaseUrl: () => 'https://withcenter-test-4-default-rtdb.firebaseio.com',
    debug: true,
  );
}
```

If you are using Dev Environment variable, you can initialize it like below;

```dart
  SuperLibrary.instance.init(
    getDatabaseUrl: () => FFDevEnvironmentValues().databaseURL,
  );
```

Note: The `getDatabaseUrl` function is optional and only required for the web platform. For Android and iOS, the `databaseURL` is set by FlutterFlow in the `google-service.json` and `GoogleService-Info.plist` files.


## Explanation

**getDatabaseUrl**: A callback function to return the database URL. It Supports environment variables, which are initialized after initApp is called.
If not using environment variables, simply return the URL as a string.

## Handling Errors

If you see an error like Target of URI doesn't exist: 'package:super_library/custom_code/actions/super_library.dart', run the app with "Exclude from compilation".

## Adding initApp to main.dart
Make sure to add the initApp custom action in your main.dart file.