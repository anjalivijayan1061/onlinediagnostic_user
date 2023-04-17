import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

Future<String> createOrder(int amount) async {
  String username = 'rzp_test_j07YpjyCexi5xr'; // razorpay pay key
  String password = "XJB87U2OC7H8p8JJux4pGAde"; // razoepay secret key
  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  Map<String, dynamic> body = {
    "amount": amount * 100,
    "currency": "INR",
  };
  var res = await http.post(
    Uri.https("api.razorpay.com", "v1/orders"),
    headers: <String, String>{
      "Content-Type": "application/json",
      'authorization': basicAuth,
    },
    body: jsonEncode(body),
  );

  if (res.statusCode == 200) {
    return jsonDecode(res.body)['id'];
  } else {
    return '';
  }
}
