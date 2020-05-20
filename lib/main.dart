import 'package:csocflutter/screens/mail_compose.dart';
import 'package:flutter/material.dart';
import './screens/mail_list_screen.dart';
import './screens/mail_detail_screen.dart';
import './screens/mail_compose.dart';
import 'package:provider/provider.dart';
import './provider/gmail_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
           visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MailItem(),
        routes: {
          MailItem.routeName : (ctx) => MailItem(),
          MailDetail.routeName : (ctx) => MailDetail(),
          NewMail.routeName : (ctx) => NewMail(),
         },
      );
  }
}

