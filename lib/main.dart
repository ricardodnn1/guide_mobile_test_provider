import 'package:flutter/material.dart';
import 'package:guidemobileprov/app/trading/controller/trading_controller.dart';
import 'package:guidemobileprov/app_widget.dart';
import 'package:provider/provider.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [  
        ChangeNotifierProvider(create: (context) => HomeController()), 
      ],
      child: const AppWidget(),
    )
  );
} 