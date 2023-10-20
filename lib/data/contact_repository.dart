import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:your_app_name/models/contact.dart';

class ContactRepository {
  final ParseObject parseObject;

  ContactRepository(this.parseObject);

  Future<List<Contact>> getAllContacts() async {
    final queryBuilder = QueryBuilder<Contact>(parseObject)
      ..orderByAscending('name');

    final apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results.map((e) => Contact.fromApi(e)).toList();
    } else {
      throw Exception('Erro ao buscar contatos.');
    }
  }

  Future<Contact> addContact(Contact contact) async {
    final parseObject = ParseObject('Contact')
      ..set<String>('name', contact.name)
      ..set<String>('phone', contact.phone)
      ..set<String>('email', contact.email);

    if (contact.imagePath != null) {
      parseObject.set<String>('imagePath', contact.imagePath);
    }

    final apiResponse = await parseObject.save();

    if (apiResponse.success) {
      return Contact.fromApi(apiResponse.result);
    } else {
      throw Exception('Erro ao adicionar contato.');
    }
  }

  Future<void> updateContact(Contact contact) async {
    final queryBuilder = QueryBuilder<Contact>(parseObject)
      ..whereEqualTo('objectId', contact.objectId);

    final apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.results != null) {
      final contactObject = apiResponse.results.first;

      contactObject
        ..set<String>('name', contact.name)
        ..set<String>('phone', contact.phone)
        ..set<String>('email', contact.email);

      if (contact.imagePath != null) {
        contactObject.set<String>('imagePath', contact.imagePath);
      }

      final updateResponse = await contactObject.save();

      if (!updateResponse.success) {
        throw Exception('Erro ao atualizar contato.');
      }
    } else {
      throw Exception('Contato não encontrado.');
    }
  }
}
