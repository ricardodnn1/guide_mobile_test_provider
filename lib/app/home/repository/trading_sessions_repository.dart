import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:guidemobile_provider/app/home/models/trading_sessions_model.dart';
import 'package:guidemobile_provider/shared/constants/endpoint.dart';

class TradingSessionsRepository {

  @override
  Future<List<TradingSessionsModel>> getAllTraiding() async {
     try {
         Response response;
         List<TradingSessionsModel> listTradingSessions = [];
         response = await Dio().get(
            endpoint,
            options: Options(
                responseType: ResponseType.json,
            ),
         );


         if(response.statusCode == 200) {
          var timestamp = jsonDecode(response.data["chart"]["result"][0]["timestamp"].toString());
          var indicatorsOpen = jsonDecode(response.data["chart"]["result"][0]["indicators"]["quote"][0]["open"].toString());

          for(var i = 0;i <= 30; i++) {
              listTradingSessions.add(TradingSessionsModel(dataTrading: timestamp[i].toString(), quotationValue: indicatorsOpen[i]));
          } 
         }  

        return listTradingSessions;
      } catch (e) {
        return [];
      }
  }
}