class Dealer {
  final String dealerName;
  final String address;
  final String mobileNo;
  final String emailAddress;

  Dealer(this.dealerName, this.address,this.mobileNo,this.emailAddress);

  Dealer.fromJson(Map<String, dynamic> json)
      : dealerName = json['dealerName'],
        address = json['address'],
        mobileNo = json['mobileNo'],
        emailAddress = json['emailAddress'];

  Map<String, dynamic> toJson() =>
      {
        'dealerName': dealerName,
        'address': address,
        'mobileNo': mobileNo,
        'emailAddress': emailAddress,

      };
}
