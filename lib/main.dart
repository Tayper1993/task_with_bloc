import 'package:flutter/material.dart';
import 'package:task1/api.dart';
import 'screenPersonList.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: ThemeColors.third, brightness: Brightness.dark),
        title: 'Rick and Morty',
        home: PersonListScreen(
          api: ApiImpl(),
        ));
  }
}
