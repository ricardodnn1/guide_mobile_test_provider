import 'package:flutter/material.dart';
import 'package:guidemobileprov/app/trading/model/trading_sessions_model.dart';
import 'package:guidemobileprov/app/trading/repository/trading_sessions_repository.dart';

class HomeController extends ChangeNotifier {

    late TradingSessionsRepository repository;
    List<TradingSessionsModel> tradingSessionsList = [];

    HomeController() {
      repository = TradingSessionsRepository();
      getTradingSessionsList();
    }

    getTradingSessionsList() async {
      tradingSessionsList = await repository.getTradingSessions();
      notifyListeners();
    }
}