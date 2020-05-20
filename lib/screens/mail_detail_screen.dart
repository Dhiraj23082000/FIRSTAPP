import 'package:csocflutter/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './mail_list_screen.dart';


class MailDetail extends StatefulWidget {
  static const routeName = '/detail';

  @override
  _MailDetailState createState() => _MailDetailState();
}

class _MailDetailState extends State<MailDetail> {
  @override
  Widget build(BuildContext context) {
    final mailid = ModalRoute.of(context).settings.arguments as String;
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    var loadedMail;
    DBProvider.db.getMail(mailid).then((value) => loadedMail=value);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(MailItem.routeName);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
             DBProvider.db.deleteMail(mailid);
              Navigator.of(context).pop();
              
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  loadedMail.subject,
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "From: ",
                      style: TextStyle(color: Colors.grey,fontSize: 20),
                    ),
                    Text(
                      loadedMail.from,
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height:10),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "To: ",
                      style: TextStyle(color: Colors.grey,fontSize: 20),
                    ),
                    Text(
                      loadedMail.sent,
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                  ],
                ),
                 SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Date: ",
                      style: TextStyle(color: Colors.grey,fontSize: 20),
                    ),
                    Text(
                    df.format(loadedMail.date),
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                     
                  ],
                ),
                
              ],
            ),
          ),

          SizedBox(height: 10),
              Expanded(child: Text(loadedMail.description),)
        ],
      ),
    );
  }
}

//Text("From: ${loadedMail.from}"),
//             Text("TO: ${loadedMail.to}"),
//            Text("Date: ${loadedMail.to}"),
