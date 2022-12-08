import 'package:flutter/material.dart';
import 'package:guidemobile_provider/app/home/presenter/home_page.dart';

class MainWidgetApp extends StatelessWidget {
  const MainWidgetApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guide Mobile Teste',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, 
      initialRoute: '/',
      routes: {
        '/':(context) => const HomePage(),  
        '/home':(context) => const HomePage(), 
      },
    );
  }
}