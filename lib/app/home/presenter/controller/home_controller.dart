import 'package:flutter/material.dart';
import 'package:guidemobile_provider/app/home/models/trading_sessions_model.dart';
import 'package:guidemobile_provider/app/home/repository/trading_sessions_repository.dart';

class HomeController extends ChangeNotifier {
    
    TradingSessionsRepository repository = TradingSessionsRepository();
    bool loaded = false;
 

    Future<void> getAllTrading() async {
       
    }

    Future<List<TradingSessionsModel>> getAllTradingDtChart() async {
      final data = await repository.getAllTraiding();
      return data;
    }
}