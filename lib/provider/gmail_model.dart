import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class Gmail {
  final String id;
  final String by;
  final String sent;
  final String subject;
  final DateTime date;
  final String description;

  Gmail({
   // @required this.id,
   this.id,
    @required this.by,
    @required this.sent,
    @required this.subject,
    @required this.description,
    @required this.date,
  });
  factory Gmail.fromMap(Map<String, dynamic> json) => new Gmail(
      id:  json["id"],
      by:  json["by"],
      sent:  json["sent"],
      subject:  json["subject"],
      description:  json["description"],
       date: json["date"],
      );


  Map<String, dynamic> toMap(){

		var map = Map<String, dynamic>();
		
			map['id'] = id;
	
		map['by'] = by;
		map['sent'] = sent;
		map['subject'] = subject;
    map['description'] = description;
    map['date'] = date.toIso8601String();

		return map;
	}
  

}

