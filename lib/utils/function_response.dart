import 'dart:developer';

class FunctionResponse {
  bool success;
  dynamic data;
  String message;
  int count;

  FunctionResponse({
    this.success = false,
    this.data,
    this.message = 'Could not process your request.',
    this.count = 0,
  });

  void passed({String? message}) {
    success = true;
    if (!isEmptyOrNull(message)) {
      this.message = message.toString();
    }
  }

  void failed({String? message}) {
    success = false;
    if (!isEmptyOrNull(message)) {
      this.message = message.toString();
    }
  }

  void feedback(String msg) {
    message = msg;
  }

  bool isEmptyOrNull(msg) => (msg == null || msg == '') ? true : false;

  void printResponse() {
    // ignore: avoid_print
    log(message);
  }
}
