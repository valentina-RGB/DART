
import 'dart:io';


// Realiza un programa que permita solicitar el nombre y genero de N personas y luego almacene 
// em una lista  M los generos M y en una lista F los generos F.
void main() {

print("¡BIENVENIDO! \n Este programa almacenara los generos M y F");


final opcion= stdin.readLineSync();

print(opcion);

final todas= new mujeres();
todas.generosFemenino('g','fgdgd');
}


abstract class conteoDeGeneros{

String? genero;
String? nombre;


void generosFemenino (genero, nombre);
void generosMasculino (genero, nombre);

conteoDeGeneros({String? genero , String? nombre}){
this.genero = genero;
this.nombre = nombre;

}

}
class mujeres implements conteoDeGeneros{

  String? genero;
  String? nombre;

      List<String>generoM= [];
      List<String>generoF= [];
   

    generosFemenino(nombre, genero){
      return print("HOLAAA ${genero} y ${nombre}");
    }

    generosMasculino(genero, nombre){

    }

  }