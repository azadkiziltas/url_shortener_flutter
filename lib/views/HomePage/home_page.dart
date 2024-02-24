import 'package:flutter/material.dart';
import 'package:url_shortener/constants/user_theme.dart';
import 'package:url_shortener/views/HomePage/widgets/history_list.dart';
import 'package:url_shortener/views/HomePage/widgets/url_shortener.dart';

class HomePage extends StatelessWidget {
   const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserTheme.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: UserTheme.primaryColor,
        surfaceTintColor: UserTheme.primaryColor,
        title: Text("Shorted Link History",style: TextStyle(color: UserTheme.background
        ),),
      ),
      body: Container(
        color: UserTheme.primaryColor,
        child: const Column(children: [
          Expanded(
            flex: 1,
            child: HistoryList()
          ),
          Expanded(
            flex: 0,
            child: UrlShortener()
          ),
        ]),
      ),
    );
  }
}
