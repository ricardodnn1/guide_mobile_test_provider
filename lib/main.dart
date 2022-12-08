import 'package:flutter/material.dart';
import 'package:guidemobile_provider/app/home/presenter/controller/home_controller.dart';
import 'package:guidemobile_provider/main_widget.dart';
import 'package:provider/provider.dart';

void main() {
  MultiProvider(
    providers: [  
      ChangeNotifierProvider(create: (context) => HomeController()), 
    ],
    child: const MainWidgetApp(),
  );
} 