import 'package:flutter/material.dart';
import 'package:guidemobileprov/app/home/controller/home_controller.dart';
import 'package:guidemobileprov/app/home/models/trading_sessions_model.dart';
import 'package:guidemobileprov/shared/extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
   Widget build(BuildContext context) { 
     final controller = context.watch<HomeController>();
     print(controller.tradingSessionsList.length);

     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Consulta do ativo PETR4'),
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        height: 80,
        child: Center(
           child: ElevatedButton(
             style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black38
             ),
             onPressed: () {
                Navigator.of(context).pushNamed('/home/trading');
             },
             child: const Padding(
               padding: EdgeInsets.all(8.0),
               child: Text("Visualizar Gráfico"),
             ),
           ),
        ),
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: controller.tradingSessionsList.length > 0 ? ListView.builder(
            itemCount: controller.tradingSessionsList.length,
            itemBuilder: (_, index) {
              final TradingSessionsModel item = controller.tradingSessionsList[index];
              return ListTile(
                title: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(item.dataTrading!.parseDateTime()))),
                subtitle: Text('Cotação: ${item.quotationValue!.toStringAsFixed(4)}'),
              );
            },
          ) : Center(child: CircularProgressIndicator()),  
      )
    );
  }
}