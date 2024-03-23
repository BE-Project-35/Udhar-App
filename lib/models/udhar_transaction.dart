enum Status { requested, accepted, completed }

class UdharTransaction {
  final String transactionID;
  final String borrowerID;
  final String lenderID;
  final int amount;
  final int ROI;
  final String requestedDt;
  late String acceptedDt = "";
  final String end;
  final String status;
  final String borrowerName;
  final String lenderName;

  UdharTransaction({
    required this.transactionID,
    required this.borrowerID,
    required this.lenderID,
    required this.ROI,
    required this.amount,
    required this.end,
    required this.requestedDt,
    required this.status,
    required this.borrowerName,
    required this.lenderName,
  });

  factory UdharTransaction.fromJson(Map<dynamic, dynamic> json) {
    return UdharTransaction(
      transactionID: json['transactionID'] ?? '',
      borrowerID: json['borrowerID'] ?? '',
      lenderID: json['lenderID'] ?? '',
      ROI: json['ROI'] ?? '',
      amount: json['amount'] ?? '',
      requestedDt: json['requestedDt'] ?? '',
      status: json['status'] ?? '',
      end: json['end'] ?? '',
      borrowerName: json['borrowerName'] ?? '',
      lenderName: json['lenderName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionID': transactionID,
      'borrowerID': borrowerID,
      'lenderID': lenderID,
      'ROI': ROI,
      'amount': amount,
      'requestedDT': requestedDt,
      'status': status,
      'end': end,
      'lenderName': lenderName,
      'borrowerName': borrowerName,
    };
  }
}
