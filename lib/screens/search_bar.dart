import 'package:csocflutter/utils/database.dart';
import 'package:flutter/material.dart';
import '../provider/gmail_model.dart';
import '../utils/database.dart';
import 'package:intl/intl.dart';
import '../screens/mail_detail_screen.dart';


List<Gmail> xyz =[];
 void getitem() async {
 xyz = await DBProvider.db.getAllMails();

}


class DataSearch extends SearchDelegate<String> {
  
  // static const routeName = '/search-mail';
 

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Gmail> finlist=[];
    if (query.isEmpty) {
       xyz=DBProvider.db.listitems;
     finlist = [];
     print(xyz.length);
    }
     else {
     // getitem();
     xyz=DBProvider.db.listitems;
        xyz.map((e) {
        if (e.subject.startsWith(query)) {
          finlist.add(e);

        }
      }).toList();
    //if(finlist.length!=0) print(finlist[0].subject.toString());
      
    }
    List<Gmail>finlist2 = finlist;
    int cnt;
    if(finlist2.isEmpty)cnt=0;
    else cnt = finlist2.length;

      return  ListView.builder(
        itemBuilder: (BuildContext ctx, int index) => Card(
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
              title: Text("From: ${finlist2[index].by}"),
              subtitle: Text(finlist2[index].subject),
              isThreeLine: true,
              trailing: Text(DateFormat.yMd().format(finlist2[index].date)),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MailDetail.routeName, arguments: finlist2[index]);
              }),
        ),
        itemCount: cnt,
      );
  }

  @override
  Widget buildResults(BuildContext context) => Text('results');

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              query = " ";
            }),
      ];
}
