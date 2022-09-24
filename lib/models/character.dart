import 'dart:convert';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));
String characterToJson(Character data) => json.encode(data.toJson());

class Character {
  Character({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.title,
    required this.familyId,
    required this.imageUrl,
    this.familyName
  });
  int id;
  String firstName;
  String lastName;
  String fullName;
  String title;
  int familyId;
  String imageUrl;
  String? familyName;
  
  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["first_name"] + ' ' + json["last_name"],
        title: json["title"],
        familyId: json["family_id"],
        imageUrl: json["image_url"],
      );

      
  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "title": title,
        "familyId": familyId,
        "imageUrl": imageUrl,
      };
}
