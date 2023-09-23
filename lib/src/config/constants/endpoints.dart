class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://face.titkul.com";
  static const String baseUrl1 = "http://01.mypbx.com.vn";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // endpoints
  static const String getCardId = "$baseUrl//get_cardid.php";

  static const String getCallApi = "$baseUrl1/services/getapi.php";
}
