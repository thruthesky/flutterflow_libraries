# Cloud Functions

There are many ways of deploying Cloud functions. And since FlutterFlow has its own cloud functions feature for editing and deploying code to Firebase, we decided to build the cloud functions in JavaScript. FlutterFlow developers can simply copy the code and paste it into their FlutterFlow cloud functions menu.

These cloud functions can be used with any FlutterFlow project, even if you are not using the Super Library.

## Rules

- All cloud function calls return an object.
- If a cloud function call encounters an error, it returns an object containing the `error` field instead of throwing an exception. This applies to both `HTTP requests` and `callable functions`.
  - Handling exceptions from Cloud Functions in FlutterFlow can be challenging, so our cloud functions always return as if they were successful.
  - To check if a call failed, simply check for the presence of the `error` field in the return object.
  - If there is an error, the return object will look like `{ error: ..., message: ... }`.
    - The `error` has an error code and the `message` has the detail error message.



## Known issues


### Cannot use the returned data from cloud function call

It's an unfortune that we cannot use the return value from the action call of the flutterflow. I created an [issue - Can not use the return result from the Cloud (callable) functions](https://github.com/FlutterFlow/flutterflow-issues/issues/4541) about it.

For the meantime until it works, you can create an custom action that uses the return value from the cloud functions.

