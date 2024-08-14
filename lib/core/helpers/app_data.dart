import 'package:firebase_auth/firebase_auth.dart';

class AppData {
  static final AppData _instance = AppData._internal();

  String? appFlavor;
  User? currentUser;

  AppData._internal();

  factory AppData() {
    return _instance;
  }

  void initialize({String? flavor, User? user}) {
    appFlavor = flavor;
    currentUser = user;
  }
}
