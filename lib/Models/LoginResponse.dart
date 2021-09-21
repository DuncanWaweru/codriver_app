class LoginResponse {
  String token;
  String userName;
  String expiryDate;

  LoginResponse({this.token, this.userName, this.expiryDate});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userName = json['userName'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userName'] = this.userName;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}