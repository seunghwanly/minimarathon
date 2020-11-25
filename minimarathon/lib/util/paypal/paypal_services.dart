import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {

  /*
      PAYPAL ACCOUNT : ksccla@gmail.com
  */
  // ! ALERT !
  // TODO :  SELECT YOUR MODE !!
  //PAYPAL SANDBOX MODE !
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
  String clientId = 'ARahzR1w-18UQHwWNJwHNGjPLAJqqqsYj2jVTXvO76qj1aRZyBl-lW_kaAX4McKqlK3UgkzNw99wOUQ-';
  String secret = 'EA_dz86eXTo229RBItz0hR30QO2SicYFBUZ1yq3yAejaGvhX5PNT8UkC0RIEVE3hQumP4-tZlhNIBtxC';

  //PAYPAL LIVE MODE !
  //  String domain = "https://api.paypal.com"; // for production mode
  // String clientId = 'AcJIOyUMTQJypdrxI40RcOvHxsGGBquYVEBnZlozp3Ia5FmTpxrXSqKc3uuhh3Yri4jq9cU_4SwVhcMj';
  // String secret = 'EELx1Yn5oNgU7MO-T6yc3xju7h9E1hvVv5jXzevar0tdkmGeWPsJCg1fVvJXbmO01r11wtZQiAfmHSKW';


  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post('$domain/v1/oauth2/token?grant_type=client_credentials');
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post("$domain/v1/payments/payment",
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      print("ㄴ>> : " + body['state']);
      if (response.statusCode == 200) { // succesful response
        print('success\n' + body.toString());
        // return new Result.fromJson(body).state.toString();
        return body['state'];
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}