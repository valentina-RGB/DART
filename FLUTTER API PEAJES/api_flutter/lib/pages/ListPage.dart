//import 'package:api_flutter/pages/ListPage.dart';
import 'package:api_flutter/models/Peaje.dart';
import 'package:api_flutter/pages/EditarPeaje.dart';

//import 'package:api_flutter/pages/ListPage.dart';
//import 'package:api_flutter/pages/LocationPage.dart';
import 'package:api_flutter/pages/RegisterPage.dart';
import 'package:api_flutter/services/Api_services.dart';
import 'package:api_flutter/wibgets/CardListar.dart';
import 'package:api_flutter/wibgets/info.dart';
import 'package:flutter/material.dart';
//import 'EditarPeaje.dart';
//import 'photopage.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Peaje>> _futurePeajes;

  @override
  void initState() {
    super.initState();
    _refreshRegistrosPeajes();
    
  }

  void _refreshRegistrosPeajes() {
    setState(() {
      _futurePeajes = fetchRegistrosPeajes();
    });
  }

  void editar(Peaje peaje) async {
    final route =
        MaterialPageRoute(builder: (context) => EditarPeaje(peaje: peaje,));
    await Navigator.push(context, route);
    _refreshRegistrosPeajes();
  }

  void eliminar(Peaje peaje) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content: const Text("¿Está seguro que desea eliminar este peaje?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Eliminar"),
              onPressed: () async {
                try {
                  await eliminarPeaje(peaje.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Peaje eliminado con éxito.'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                  _refreshRegistrosPeajes(); // Aquí vuelves a cargar la lista después de eliminar
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al eliminar el peaje.'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showPeajeDetailModal(Peaje peaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<double>(
        future: fetchDolarValue(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Registros no encontrados'));
          } else {
            double valorDolar = snapshot.data!;
            return AlertDialog(
              title: Center(child: Text('cccc', style: const TextStyle(color: Colors.white))),
              backgroundColor: const Color.fromRGBO(26, 46, 79, 1),
                // |
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    child: const Text("Cerrar", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          }
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 46, 79, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 46, 79, 1),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 206, 215, 250)),
        title: const Text(
          'Peajes',
          style: TextStyle(
            color: Color.fromARGB(255, 206, 215, 250),
          ),
        ),
      ),
      body: FutureBuilder<List<Peaje>>(
        future: _futurePeajes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Registros no encontrados'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var peaje = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    showPeajeDetailModal(peaje);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: CardListar(
                      colorIcon: const Color.fromARGB(255, 206, 215, 250),
                      placa: peaje.placa,
                      peaje: peaje.peaje,
                      onEditPressed: () {
                        editar(peaje);
                        _refreshRegistrosPeajes();
                      },
                      onDeletePressed: () {
                        eliminar(peaje);
                        _refreshRegistrosPeajes();
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route =
              MaterialPageRoute(builder: (context) => const RegisterPage());
          await Navigator.push(context, route);
          _refreshRegistrosPeajes();
        },
        backgroundColor: const Color.fromARGB(255, 206, 215, 250),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}