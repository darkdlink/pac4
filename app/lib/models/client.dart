import 'package:app/models/anamnesis_form.dart';

class Client {
  String id;
  String name;
  DateTime birthDate;
  AnamnesisForm anamnesis;

  Client({
    this.id = '', // ID vazio por padrão para novos clientes
    required this.name,
    required this.birthDate,
    required this.anamnesis,
  });

  Map<String, dynamic> toMap() {
    // Converte o objeto Client para um Map (para o Firestore)

    return {
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'anamnesis': anamnesis.toMap(),
    };
  }

  factory Client.fromMap(Map<String, dynamic> map, String documentId) {
    // Cria um objeto Client a partir de um Map (do Firestore)

    return Client(
      id: documentId,

      name: map['name'] ?? '', // Valor padrão se 'name' for nulo

      birthDate: (map['birthDate'] is String && map['birthDate'].isNotEmpty)
          ? DateTime.parse(map['birthDate'] as String)
          : DateTime.now(),

      anamnesis: AnamnesisForm.fromMap(map['anamnesis'] ?? {}),
    );
  }
}
