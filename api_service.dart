import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auto_part.dart';

class ApiService {
  final String baseUrl = 'https://67260d0b302d03037e6c3593.mockapi.io/autoparts';

  Future<List<AutoPart>> fetchAutoParts() async {
    final response = await http.get(Uri.parse('$baseUrl/AutoParts'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((item) => AutoPart.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка загрузки данных');
    }
  }

  Future<void> updateAutoPart(AutoPart part) async {
    final response = await http.put(
      Uri.parse('$baseUrl/AutoParts/${part.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(part.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка обновления записи');
    }
  }

  Future<void> createAutoPart(AutoPart part) async {
    final response = await http.post(
      Uri.parse('$baseUrl/AutoParts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(part.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Ошибка добавления записи');
    }
  }
}
