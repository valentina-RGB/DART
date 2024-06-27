import 'package:consumodeapis/screens/EditProductoScreen.dart';
import 'package:consumodeapis/screens/NewCategorieScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:consumodeapis/screens/EditInsumosScreen.dart';
import 'package:consumodeapis/screens/NewProductScreen.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'vc' && password == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 196, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 116, 16, 129),
        title:const Text('Login', style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration:const  InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 82, 9, 116),
                ),
                child: const Text('Login', style: TextStyle(color: Colors.white)),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _errorMessage,
                    style:const  TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}



class Insumo {
  final int id;
  final String name;
  final double price;
  final int categorie;

  Insumo({
    required this.id,
    required this.name,
    required this.price,
    required this.categorie,
  });

  factory Insumo.fromJson(Map<String, dynamic> json) {
    return Insumo(
      id: json['idProduct'],
      name: json['name'],
      price: json['price'],
      categorie: json['categoriaId'],
    );
  }
}

class Categories {
  final int id;
  final String descripcion;
  final String fecha;
  final int estado;

  Categories({
    required this.id,
    required this.descripcion,
    required this.fecha,
    required this.estado,
    
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['idCategorie'] ?? 0,
      descripcion: json['description'] ?? 'No hay descripción',
      fecha: (json['date'] as String),
      estado: json['state'] ?? 1,
    );
  }
}



class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 196, 255),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 85, 16, 112),
        title: const Text('Creamy Soft', style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MenuButton(
                text: 'Ver Productos',
                color:Color.fromARGB(255, 120, 27, 148)!,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListarInsumosScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              MenuButton(
                text: 'Ver Categorías',
                color: Color.fromARGB(255, 83, 5, 94)!,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListarCategoriesScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  MenuButton({required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style:const  TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ListarInsumosScreen extends StatefulWidget {
  const ListarInsumosScreen({super.key});

  @override
  _ListarInsumosScreenState createState() => _ListarInsumosScreenState();
}

class _ListarInsumosScreenState extends State<ListarInsumosScreen> {
  List<Insumo> insumos = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('http://localhost:5170/api/product');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          setState(() {
            insumos = jsonData.map((item) => Insumo.fromJson(item)).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'La respuesta de la API no es una lista.';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Error al cargar los insumos: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Excepción al cargar los insumos: $e';
      });
    }
  }

  Future<void> eliminarProducto(int id) async {
    final url = Uri.parse('http://localhost:5170/api/product/$id');
    try {
      final response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 204) {
        setState(() {
          insumos.removeWhere((insumo) => insumo.id == id);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar el insumo: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Excepción al eliminar el insumo: $e')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: const Text('Productos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: cargarProductos,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: insumos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.yellow[200],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(insumos[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PRECIO: ${insumos[index].price}'),
                              Text('CATEGORIA: ${insumos[index].categorie}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProductScreen(insumo: insumos[index]),
                                    ),
                                  ).then((value) {
                                    if (value == true) {
                                      cargarProductos();
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  eliminarProducto(insumos[index].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewProductScreen()),
          ).then((value) {
            if (value == true) {
              cargarProductos();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
class ListarCategoriesScreen extends StatefulWidget {
  @override
  _ListarCategoriesScreenState createState() => _ListarCategoriesScreenState();
}

class _ListarCategoriesScreenState extends State<ListarCategoriesScreen> {
  List<Categories> categories = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    cargarCategoria();
  }

  Future<void>cargarCategoria() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('http://localhost:5170/api/categorie');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          setState(() {
            categories = jsonData.map((item) => Categories.fromJson(item)).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'La respuesta de la API no es una lista.';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Error al cargar las categorías: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Excepción al cargar las categorías: $e';
      });
    }
  }

  Future<void> eliminarCategoria(int id) async {
    final url = Uri.parse('http://localhost:5170/api/categorie/$id');
    try {
      final response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 204) {
        setState(() {
           categories.removeWhere((categories) => categories.id == id);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar el insumo: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Excepción al eliminar el insumo: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 56, 70, 253),
        title: const Text('Categories'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: cargarCategoria,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color.fromARGB(157, 157, 183, 255),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(categories[index].descripcion),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DESCRIPCIÓN: ${categories[index].descripcion}'),
                              Text('FECHA: ${categories[index].fecha}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton(
                              //   icon: Icon(Icons.edit, color: Colors.green),
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => EditProductScreen(insumo: insumos[index]),
                              //       ),
                              //     ).then((value) {
                              //       if (value == true) {
                              //         cargarCategoria();
                              //       }
                              //     });
                              //   },
                              // ),
                              IconButton(
                                icon:const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  eliminarCategoria(categories[index].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color.fromARGB(255, 110, 155, 185),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCategorieScreen()),
          ).then((value) {
            if (value == true) {
              cargarCategoria();
            }
          });
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}
