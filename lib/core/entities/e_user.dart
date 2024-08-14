class AppUser {
  final String userId;
  final bool isAdmin;
  final String userName;
  final String email;
  String? profilePictureURL;
  String? defaultAddress;
  List<String> previousOrders;

  AppUser(
      {required this.userId,
      this.isAdmin = false,
      required this.userName,
      required this.email,
      this.profilePictureURL = "",
      this.defaultAddress = "",
      required this.previousOrders});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'isAdmin': isAdmin,
      'userName': userName,
      'email': email,
      'profilePictureURL': profilePictureURL,
      'defaultAddress': defaultAddress,
      'previousOrders': previousOrders,
    };
  }

  void checkOut(String orderId) {
    previousOrders.add(orderId);
  }
}
