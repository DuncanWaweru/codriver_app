import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:co_driver/Repo/AppConstants.dart';

import 'GetSharedPrefs.dart';
class MakeApiCalls{
  static Future<http.Response> makeAGetRequest(String endpoint) async{
    var accessToken ='Bearer '+ await GetSharedPrefs.getNamePreference('access_token');
    endpoint = AppConstants.appEndpoint+endpoint;
print(endpoint);
    http.Response response = await http.get(
      Uri.parse(endpoint),
      headers: {
        "Authorization": accessToken,
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
  static Future<http.Response> makeAPostRequest(String endpoint,Map<String, dynamic> json) async{
    endpoint = AppConstants.appEndpoint+endpoint;
    var accessToken ='Bearer '+ await GetSharedPrefs.getNamePreference('access_token');
    var finalJson = jsonEncode(json);
    print(finalJson);
    http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Authorization": accessToken,
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',

      },
        body: (finalJson)

    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
  static Future<http.StreamedResponse>  makeAPostRequestWithAFile(String endpoint,File sample1) async{
    var accessToken ='Bearer '+ await GetSharedPrefs.getNamePreference('access_token');
    endpoint = AppConstants.appEndpoint+endpoint;
    print(endpoint);
    print(accessToken);
    var request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.files
        .add(await http.MultipartFile.fromPath('file', sample1.path));
    request.headers.addAll(
      {
        "Authorization": accessToken,
        "Accept": "text/plain",
        'Content-Type': 'application/form-data;',
      },
    );
    http.StreamedResponse response = await request.send();
    return response;

  }

}