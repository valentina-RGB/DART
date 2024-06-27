import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class NewCategorieScreen extends StatefulWidget {
  @override
  _NewCategorieScreenState createState() => _NewCategorieScreenState();
}

class _NewCategorieScreenState extends State<NewCategorieScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Categoría'),
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
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
           TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Registro',
                  ),
                  style: const TextStyle(color: Colors.white), // Estilo para el texto
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _dateController.text =DateFormat('yyyy-MM-dd').format(_selectedDate!);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la fecha de registro';
                    }
                    return null;
                  },
                ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _estadoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Estado'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el estado';
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

      final nuevoCategoria = {
        'description': _descripcionController.text,
        'date': _dateController.text,
        'state': int.parse(_estadoController.text),
      };

      final url = Uri.parse('http://localhost:5170/api/categorie');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
          body: json.encode(nuevoCategoria),
        );

        if (response.statusCode == 201) {
          Navigator.of(context).pop(true); // Pop la pantalla y devuelve true
        } else {
          setState(() {
            print('Response body: ${response.body}');
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
