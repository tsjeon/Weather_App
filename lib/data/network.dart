import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'afcfe5483027dead8702ed9adc18a789';

class Network {
  final String url;
  final String url2;

  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    print(response.statusCode);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var pasingData = jsonDecode(jsonData);

      return pasingData;
    }
  }
}
