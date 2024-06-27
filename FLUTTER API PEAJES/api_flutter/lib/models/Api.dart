
import 'package:intl/intl.dart';
class Api {
  //final int id;
  final String placa;
  final String peaje;
  final String descripcion;
  final String categoria;
  final String fechaRegistro;

  final int valor;

  Api({required this.placa, required this.peaje, required this.descripcion, required this.categoria,  required this.fechaRegistro, required this.valor});

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
      //id: json['idPeaje'],
      placa: json['placa'] as String,
      peaje: json['peaje'] as String,
      descripcion:json['descripcion'] as String,
      categoria: json['idcategoria'] as String,
      fechaRegistro: DateFormat('yyyy-MM-dd').format(DateTime.now()), // Fecha por defecto
      valor: int.parse(json['precio']),
    );
  }
}