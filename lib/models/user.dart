class UdharUser {
  final String uid;
  final String email;
  final String phone;
  final int udharScore;
  final int credit;
  final int debit;
  final String imageURL;

  UdharUser({
    // required this.transactionID,
    required this.uid,
    required this.email,
    required this.phone,
    required this.udharScore,
    required this.credit,
    required this.debit,
    required this.imageURL,
  });

  factory UdharUser.fromJson(Map<dynamic, dynamic> json) {
    return UdharUser(
      // transactionID: json['transactionID'] ?? '',
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      udharScore: json['udharScore'] ?? '',
      credit: json['credit'] ?? '',
      debit: json['debit'] ?? '',
      imageURL: json['imageURL'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'udharScore': udharScore,
      'credit': credit,
      'debit': debit,
      'imageURL': imageURL,
    };
  }
}
