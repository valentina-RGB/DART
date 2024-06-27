import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final ImagePicker _picker = ImagePicker(); // Instancia del selector de imágenes
  File? _image; // Variable para almacenar la imagen seleccionada

  // Método para tomar una foto
  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path); // Convertir XFile a File
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar Foto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No hay imagen seleccionada.')
                : Image.file(_image!), // Mostrar la imagen seleccionada
            ElevatedButton(
              onPressed: _takePhoto, // Llamar al método para tomar una foto
              child: Text('Tomar Foto'),
            ),
          ],
        ),
      ),
    );
  }
}
