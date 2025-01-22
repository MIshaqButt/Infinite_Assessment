class AppUrl {
  AppUrl._();

  // base url
  static const String baseUrl = "https://randomuser.me/api/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds:  15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds:  15000);


  static String postDataUrl(int pageNo, int resultCount) =>"?page=$pageNo&results=$resultCount";

  static const String addPost = "addPost";

  static const String deletePost = "deletePost";

  static const String updatePost = "updatePost";

}