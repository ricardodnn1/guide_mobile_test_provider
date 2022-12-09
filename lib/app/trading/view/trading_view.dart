import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidemobileprov/app/trading/controller/trading_controller.dart';
import 'package:guidemobileprov/app/trading/model/trading_sessions_model.dart';
import 'package:guidemobileprov/shared/extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TradingView extends StatelessWidget {
  const TradingView({super.key});

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
           child: SizedBox(
             width: 200,
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black38
               ),
               onPressed: () {
                  Navigator.of(context).pushNamed('/trading/chart');
               },
               child: Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Text("Visualizar Gráfico"),
                     Icon(Icons.show_chart)
                   ],
                 ),
               ),
             ),
           ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color(0xFFEEEEEE),
        child: controller.tradingSessionsList.length > 0 ? ListView.builder(
            itemCount: controller.tradingSessionsList.length,
            itemBuilder: (_, index) {
              final TradingSessionsModel item = controller.tradingSessionsList[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ListTile(
                  title: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(item.dataTrading!.parseDateTime())), style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600 ,color: Colors.black)),
                  subtitle: Text('Cotação: ${item.quotationValue!.toStringAsFixed(4)}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500 ,color: Colors.black)),
                ),
              );
            },
          ) : Center(child: CircularProgressIndicator()),  
      )
    );
  }
}