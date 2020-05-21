import 'dart:ui';

import 'package:csocflutter/provider/gmail_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './mail_list_screen.dart';
import '../utils/database.dart';

void _save(Gmail m) async {
  print("save intance");
var x  = await DBProvider.db.newMail(m);
print(x);  
}

class NewMail extends StatefulWidget {
  static const routeName = '/new-mail';
  @override
  _NewMailState createState() => _NewMailState();
}

class _NewMailState extends State<NewMail> {
  String mailTable = 'mail_table';
  final _form = GlobalKey<FormState>();
  var _to = FocusNode();
  var _from = FocusNode();
  var _subject = FocusNode();
  var _description = FocusNode();
  TextEditingController _subject1 = TextEditingController();
  TextEditingController _from1 = TextEditingController();
  TextEditingController _to1 = TextEditingController();
  TextEditingController _description1 = TextEditingController();
  @override
  /*void dispose() {
    _to.dispose();
    _from.dispose();
    _subject.dispose();
    _description.dispose();
    _subject1.dispose();
    _from1.dispose();
    _to1.dispose();
    _description1.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsetsDirectional.only(start: 40.0),
          child: Text(
            'Compose',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(MailItem.routeName);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: ()async {
              final isValid = _form.currentState.validate();
              if (!isValid) {
                return;
              }
              var composedMail = Gmail(
                id : DateTime.now().toString(),
            
                  by: _from1.text,
                  sent: _to1.text,
                  subject: _subject1.text,
                  description: _description1.text,
                  date: DateTime.now());
                  print(composedMail.id);
                  _save(composedMail);
              
                
              Navigator.of(context).pushReplacementNamed(MailItem.routeName);
               Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("Mail Created Successfuly")));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'From:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _from1,
                      focusNode: _from,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "From",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_to);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'To:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _to1,
                      focusNode: _to,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "To",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_subject);
                      },
                    ),
                  ),
                ],
              ),
              // SizedBox(width: 10,)
              TextFormField(
                focusNode: _subject,
                controller: _subject1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Subject",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_description);
                },
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _description1,
                focusNode: _description,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Compose Mail",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Row(
                children: <Widget>[
                  Text(
                    'To:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Flexible(
                      child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _to,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "To",
                    ),
                  )),
                ],
              ),






*/
