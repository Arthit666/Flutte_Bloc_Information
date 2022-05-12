import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/Screens/all_user.dart';
import 'package:state_manage/Screens/home.dart';
import 'package:state_manage/Screens/update.dart';

import 'package:state_manage/bloc/profile_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          AllUserScreen.routeName: (context) => AllUserScreen(),
          UpdateScreen.routeName: (context) => UpdateScreen(),
        },
      ),
    );
  }
}
