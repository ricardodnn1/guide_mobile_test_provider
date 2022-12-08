
import 'package:flutter/material.dart';
import 'package:guidemobileprov/app/home/view/home_view.dart';
import 'package:guidemobileprov/app/trading/view/trading_view.dart';
import 'package:guidemobileprov/app/trading/view/trading_chart_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guide Mobile Teste - Provider',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, 
      initialRoute: '/',
      routes: {
        '/':(context) => const HomeView(), 
        '/home':(context) => const HomeView(),
        '/trading':(context) => const TradingView(),
        '/trading/chart':(context) => const TradingChartView()
      },
    );
  }
}