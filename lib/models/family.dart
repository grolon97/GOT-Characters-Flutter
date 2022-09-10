import 'dart:convert';

Family characterFromJson(String str) => Family.fromJson(json.decode(str));
String characterToJson(Family data) => json.encode(data.toJson());

class Family {

  Family({
    required this.id,
    required this.name
  });
  int id;
  String name;
  int? characterCount;
  
  factory Family.fromJson(Map<String, dynamic> json) => Family(
        id: json["id"],
        name: json["name"]
      );

      
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name
      };
}