class TradingSessionsModel {
  String? dataTrading;
  double? quotationValue;

  TradingSessionsModel({this.dataTrading, this.quotationValue});

  TradingSessionsModel.fromJson(Map<String, dynamic> json) {
    dataTrading = json['dataTrading'];
    quotationValue = json['quotationValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dataTrading'] = dataTrading;
    data['quotationValue'] = quotationValue;
    return data;
  }
}
