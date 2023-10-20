import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Contact {
  final String objectId;
  final String name;
  final String phone;
  final String email;
  final String imagePath;

  Contact({
    this.objectId,
    this.name,
    this.phone,
    this.email,
    this.imagePath,
  });

  factory Contact.fromApi(ParseObject parseObject) {
    return Contact(
      objectId: parseObject.objectId,
      name: parseObject.get('name'),
      phone: parseObject.get('phone'),
      email: parseObject.get('email'),
      imagePath: parseObject.get('imagePath'),
    );
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Contact')
      ..objectId = objectId
      ..set('name', name)
      ..set('phone', phone)
      ..set('email', email)
      ..set('imagePath', imagePath);

    return parseObject;
  }
}
