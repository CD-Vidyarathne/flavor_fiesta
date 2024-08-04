class User {
  final String userId;
  final bool isAdmin;
  final bool isAuthenticated;
  final String userName;
  final String email;
  String? profilePictureURL;
  String? defaultAddress;
  List<String> previousOrders;

  User(
      {this.userId = "0000",
      this.isAdmin = false,
      this.isAuthenticated = false,
      required this.userName,
      required this.email,
      this.profilePictureURL,
      this.defaultAddress,
      required this.previousOrders});

  void checkOut(String orderId) {
    previousOrders.add(orderId);
  }
}
