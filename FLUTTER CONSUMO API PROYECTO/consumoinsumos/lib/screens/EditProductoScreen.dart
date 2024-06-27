import 'package:consumodeapis/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProductScreen extends StatefulWidget {
  final Insumo insumo;

  EditProductScreen({required this.insumo});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _categorieController;
  late TextEditingController _precioController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.insumo.name);
    _categorieController = TextEditingController(text: widget.insumo.categorie.toString());
    _precioController = TextEditingController(text: widget.insumo.price.toString());
  }

  Future<void> _updateInsumo() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://localhost:5170/api/product/${widget.insumo.id}');
      final response = await http.put(
        url,
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
  
        body: jsonEncode({
          'idProduct': widget.insumo.id,
          'name': _nombreController.text,
          'price':double.parse(_precioController.text),
          'categoriaId': 1,
        }),
      );

      if (response.statusCode == 204) {
        Navigator.of(context).pop(true);
      } else {
         print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el productos: ${response.statusCode}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Insumo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categorieController,
                decoration: const InputDecoration(labelText: 'Categorie'),
                 keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una medida';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un stock';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateInsumo,
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
