import 'package:guidemobileprov/app/home/model/trading_sessions_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TradingSessionsRepository {
      List<TradingSessionsModel> tradingSessionsList = [];

      Future<List<TradingSessionsModel>> getTradingSessions() async {
        var client = http.Client();
         
        try {
          var url = Uri.parse('https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA');
          var response = await client.get(
              url 
          );

          if(response.statusCode == 200) {
            var jsonResult = jsonDecode(response.body);
            var timestamp = jsonResult["chart"]["result"][0]["timestamp"];
            var indicatorsOpen = jsonResult["chart"]["result"][0]["indicators"]["quote"][0]["open"];
            for(var i = 0;i < 30; i++) {
              tradingSessionsList.add(TradingSessionsModel(dataTrading: timestamp[i].toString(), quotationValue: indicatorsOpen[i]));
            } 
          }  

           return tradingSessionsList;
        } finally {
          client.close();
        } 
      }
}