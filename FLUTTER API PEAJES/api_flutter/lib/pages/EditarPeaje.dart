import 'package:api_flutter/models/Peaje.dart';
import 'package:api_flutter/services/Api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EditarPeaje extends StatefulWidget {
  final Peaje peaje;

  const EditarPeaje({super.key, required this.peaje});

  @override
  State<EditarPeaje> createState() => _EditarPeajeState();
}

class _EditarPeajeState extends State<EditarPeaje> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _fechaRegistroController =
      TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final List<String> _categoriasTarifa = ['I', 'II', 'III', 'IV', 'V'];

  List<String> _nombresPeajes = [];
  String? _selectedNombrePeaje;
  String? _selectedCategoriaTarifa;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _initFields();
    _fetchNombresPeajes();
  }

  void _initFields() {
    _placaController.text = widget.peaje.placa;
    _selectedNombrePeaje = widget.peaje.peaje;
    _selectedCategoriaTarifa = widget.peaje.categoria;
    _fechaRegistroController.text = widget.peaje.fechaRegistro;
    _valorController.text = widget.peaje.valor.toString();
  }

  void _fetchNombresPeajes() async {
    try {
      List<String> nombresPeajes = await fetchNombresPeajes();
      setState(() {
        _nombresPeajes = nombresPeajes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar nombres de peajes: $e')),
      );
    }
  }

  void _fetchValorPeaje() async {
    try {
      String valor = await fetchValorPeaje(
          _selectedNombrePeaje!, _selectedCategoriaTarifa!);
      setState(() {
        _valorController.text = valor;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar el valor del peaje: $e')),
      );
    }
  }

  @override
  void dispose() {
    _placaController.dispose();
    _fechaRegistroController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 46, 79, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 46, 79, 1),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 206, 215, 250)),
        title: const Text(
          'Editar registro de peaje',
          style: TextStyle(
            color: Color.fromARGB(255, 206, 215, 250),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Theme(
            data: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 206, 215, 250),
                ),
              ),
            ),
            child: ListView(
              children: [
                TextFormField(
                  controller: _placaController,
                  decoration: const InputDecoration(
                    labelText: 'Placa',
                  ),
                  style: const TextStyle(color: Colors.white), // Estilo para el texto
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la placa';
                    }
                    if (!RegExp(r'^[A-Z]{3}[0-9]{3}$').hasMatch(value)) {
                      return 'Formato de placa inválido. Debe ingresar 3 letras seguidas de 3 números';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Peaje',
                  ),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromRGBO(26, 46, 79, 1),
                  value: _selectedNombrePeaje,
                  onChanged: (value) {
                    setState(() {
                      _selectedNombrePeaje = value;
                      _fetchValorPeaje();
                    });
                  },
                  items: _nombresPeajes.toSet().toList().map((nombre) {
                    return DropdownMenuItem(
                      value: nombre,
                      child: Text(nombre),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un nombre de peaje';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Categoría de Tarifa',
                  ),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromRGBO(26, 46, 79, 1),
                  value: _selectedCategoriaTarifa,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoriaTarifa = value;
                      _fetchValorPeaje();
                    });
                  },
                  items: _categoriasTarifa.map((categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona una categoría de tarifa';
                    }
                    if (!['I', 'II', 'III', 'IV', 'V'].contains(value)) {
                      return 'Categoría de tarifa inválida';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _fechaRegistroController,
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
                        _fechaRegistroController.text =
                            DateFormat('yyyy-MM-dd').format(_selectedDate!);
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
                TextFormField(
                  controller: _valorController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                  ),
                  style: const TextStyle(color: Colors.white), // Estilo para el texto
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El valor es obligatorio';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Ingrese un valor válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var peajeActualizado = {
                        "idPeaje": widget.peaje.id,
                        "placa": _placaController.text,
                        "peaje": _selectedNombrePeaje!,
                        "descripcion": "DRTRE",
                        "idCategoria": _selectedCategoriaTarifa!,
                        "fechaRegistro": _fechaRegistroController.text,
                        "precio": double.parse(_valorController.text)
                      };

                      try {
                        await actualizarPeaje(widget.peaje.id, peajeActualizado);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('¡Registro del peaje editado con éxito!'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('¡Error al editar el registro del peaje.'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 215, 250),
                  ),
                  child: const Text(
                    'Editar',
                    style: TextStyle(color: Color.fromRGBO(26, 46, 79, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromRGBO(26, 46, 79, 1),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person,
                      color: Color.fromARGB(255, 206, 215, 250), size: 16),
                  SizedBox(width: 8.0),
                  Text(
                    'L',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 215, 250),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone,
                      color: Color.fromARGB(255, 206, 215, 250), size: 16),
                  SizedBox(width: 8.0),
                  Text(
                    '3222500587',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 215, 250),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}