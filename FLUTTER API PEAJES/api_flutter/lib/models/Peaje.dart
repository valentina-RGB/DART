//import 'package:intl/intl.dart';
class Peaje {
  final int id;
  final String placa;
  final String peaje;
  final String descripcion;
  final String categoria;
  final String fechaRegistro;
  final double valor;

  Peaje({required this.id,required this.placa, required this.peaje, required this.descripcion, required this.categoria,  required this.fechaRegistro, required this.valor});

  factory Peaje.fromJson(Map<String, dynamic> json) {
    return Peaje(
      id: json['idPeaje'],
      placa: json['placa'] as String,
      peaje: json['peaje'] as String,
      descripcion:json['descripcion'] as String,
      categoria: json['idCategoria'] as String,
      fechaRegistro:  json['fechaRegistro'] as String, // Fecha por defecto
      valor:json['precio'],
    );
  }
}