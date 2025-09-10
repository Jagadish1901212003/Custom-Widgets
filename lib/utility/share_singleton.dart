class SharedSingleton {
  static final SharedSingleton _singleton = SharedSingleton._internal();
  SharedSingleton._internal();
  static SharedSingleton get shared => _singleton;
  String accessToken = "";
  String apiAccessToken = "";
  String loginUserId = "";
  String loginUserName = "";
}
