import 'dart:convert';
import 'package:api_flutter/models/Peaje.dart';
import 'package:http/http.dart' as http;


  const String api= 'http://localhost:5273/api/peaje';
  const String apiExterna = "https://www.datos.gov.co/resource/7gj8-j6i3.json";
  const String apiDolar = "https://wwwwww.datos.gov.co/resource/mcec-87by.json";


// GET: Listar Peajees
Future<List<Peaje>> fetchRegistrosPeajes() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5273/api/peaje'));
      List jsonResponse = json.decode(response.body);
      print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
    
      return jsonResponse.map((peaje) => Peaje.fromJson(peaje)).toList();
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error en la carga de la API: $e');
  }
}

// POST: Registrar nuevo Peaje
Future<void> registrarPeaje(Map peaje) async {
  try {
    final response = await http.post(Uri.parse('http://localhost:5273/api/peaje'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(peaje),
    );
    if (response.statusCode != 201) {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error en la carga de la API: $e');
  }
}

// PUT: Actualizar registro de peaje
Future<void> actualizarPeaje(int id, Map peaje) async {
  try {
    final response = await http.put(
      Uri.parse('$api/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(peaje),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      (response.statusCode);
      print(response.body);
      throw Exception('Error en la solicitud HTTP: $Error');
    }
  } catch (e) {
    throw Exception('Error en la carga de la API: $e');
  }
}

// GET: Obtener nombres de peajes desde la API externa
Future<List<String>> fetchNombresPeajes() async {
  try {
    final response = await http.get(Uri.parse(apiExterna));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<String> nombresPeajes =
          jsonResponse.map<String>((peaje) => peaje['peaje']).toList();
      return nombresPeajes;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error en la carga de la API externa: $e');
  }
}

// GET: Obtener valor del peaje basado en el nombre y la categoría
Future<String> fetchValorPeaje(
    String nombrePeaje, String categoriaTarifa) async {
  try {
    final response = await http.get(Uri.parse(apiExterna));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var peaje = jsonResponse.firstWhere(
          (peaje) =>
              peaje['peaje'] == nombrePeaje &&
              peaje['idcategoriatarifa'] == categoriaTarifa,
          orElse: () => null);
      if (peaje != null) {
        return peaje['valor'].toString();
      } else {
        throw Exception('Peaje no encontrado para los valores dados');
      }
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error en la carga de la API: $e');
  }
}

// DELETE: Eliminar registro de peaje
Future<void> eliminarPeaje(int id) async {
  try {
    final response =
        await http.delete(Uri.parse('$api/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode != 201 && response.statusCode != 204) {
      throw Exception('Error al eliminar peaje: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al eliminar peaje: $e');
  }
}

// GET Obtener valor del dólar actual 
Future<double> fetchDolarValue() async {
  final response = await http.get(Uri.parse(apiDolar));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    if (data.isNotEmpty) {
      var valorDolar = double.parse(data[0]['valor']);
      return valorDolar;
    } else {
      throw Exception('No hay datos disponibles.');
    }
  } else {
    throw Exception('Error al cargar los datos');
  }
}


// Future<int>fetchValorPeaje (String peajeId, String categoriaTarifa)async{
//     final response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['valor'];
//     } else {
//       throw Exception('Error al obtener el valor del peaje');
//     }
//   }


  //  Future<void> submitPeaje(Api api) async {
  //   final response = await http.post(
  //     Uri.parse('http://creamy-001-site1.dtempurl.com/api/peaje'), // Cambia esta URL por la URL de tu API
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(api),
  //   );

  //   if (response.statusCode != 201) {
  //     throw Exception('Error al enviar el peaje');
  //   }
  // }

