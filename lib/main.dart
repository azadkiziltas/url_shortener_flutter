import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener/bloc/link_history/link_history_bloc.dart';
import 'package:url_shortener/bloc/shorted_link/shorted_link_bloc.dart';
import 'package:url_shortener/provider/shorted_link_provider.dart';
import 'package:url_shortener/repository/link_history_repository.dart';
import 'package:url_shortener/repository/shorted_link_repository.dart';
import 'package:url_shortener/views/HomePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Url Shortener',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => ShortedLinkRepository(ShortedLinkProvider()),
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) =>
                ShortedLinkBloc(context.read<ShortedLinkRepository>()),
          ),
          BlocProvider(
            create: (context) => LinkHistoryBloc(LinkHistoryRepository()),
          )
        ], child: const HomePage()),
      ),
    );
  }
}
