import 'package:csocflutter/provider/gmail_model.dart';
import 'package:csocflutter/screens/search_bar.dart';
import '../utils/database.dart';
import 'package:flutter/material.dart';
import '../screens/search_bar.dart';
import './mail_detail_screen.dart';
import './mail_compose.dart';
import 'package:intl/intl.dart';

class MailItem extends StatefulWidget {
  static const routeName = '/list';

  @override
  _MailItemState createState() => _MailItemState();
}

class _MailItemState extends State<MailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        leading: IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: null),
        title: Text(
          "Gmail",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(NewMail.routeName);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: FutureBuilder<List<Gmail>>(
        future: DBProvider.db.getAllMails(),
        builder: (BuildContext context, AsyncSnapshot<List<Gmail>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Gmail item = snapshot.data[index];
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: ObjectKey(item),
                  onDismissed: (direction) {
                    DBProvider.db.deleteMail(item.id);
                    Navigator.of(context)
                        .pushReplacementNamed(MailItem.routeName);
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Mail Deleted")));
                  },
                  child: Card(
                    elevation: 10.0,
                    shadowColor: Colors.brown[300],
                    child: ListTile(
                        leading: CircleAvatar(
                          child: Center(
                            child: Text(
                              "Me",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          backgroundColor: Colors.purple,
                        ),
                        title: Text("From: ${item.by}"),
                        subtitle: Text(item.subject),
                        isThreeLine: true,
                        trailing: Text(DateFormat.yMd().format(item.date)),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MailDetail.routeName, arguments: item);
                        }),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No mails in the Sent Inbox"),
            );
          }
        },
      ),
    );
  }
}

/*Card(
          elevation: 10.0,
          shadowColor: Colors.brown[300],
          child: ListTile(
            leading: CircleAvatar(
              child: Center(
                child: Text(
                  "Me",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: Colors.purple,
            ),
            title: Text("From: ${mailData[index].from}"),
            subtitle: Text(mailData[index].subject),
            isThreeLine: true,
            trailing:  Text(DateFormat.yMd().format(mailData[index].date)),
                
                   onTap: (){
              Navigator.of(context).pushNamed(MailDetail.routeName,arguments: mailData[index].id);
                   }
          ),
        ),*/
