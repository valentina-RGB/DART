import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewProductScreen extends StatefulWidget {
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Producto'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _categoriaController,
               keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Categoria'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la medida';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Precio'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el stock';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: const Text('Guardar'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final nuevoProducto = {
        'name': _nombreController.text,
        'categoriaId': int.parse(_categoriaController.text),
        'price': int.parse(_precioController.text),
      };

      final url = Uri.parse('http://localhost:5170/api/product');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
          body: json.encode(nuevoProducto),
        );

        if (response.statusCode == 201) {
          Navigator.of(context).pop(true); // Pop la pantalla y devuelve true
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Error ${response.statusCode}: ${response.reasonPhrase}';
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error: $e';
        });
      }
    }
  }
}
