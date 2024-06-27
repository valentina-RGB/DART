

import 'dart:io';

void main(){
//   print("Antes de la petición");


//   getNombre('1020')
//     .then((data) {
//       print (data.toUpperCase());
//     });
//     print("fin del programa");


//   getApis('https://rickandmortyapi.com/api')
//   .then((data){

//   });
  
// }
//   Future<String>getNombre(String documento){
//       return Future.delayed(new Duration(seconds: 3),(){
//     return ' El nombre de la petición';
//   });
  
//   }

//    Future<String>getApis(String documento){
//       return Future.delayed(new Duration(seconds: 3),(){
//     return ' El nombre de la petición';
//   });


// Empleando Future para realizar un programa donde la duración
//Getnombre() getTemperatura()  get 

//Sincronico Un solo proceso se ejecuta en un instante de tiempo.




 preparacionHuevos()
    .then((data) {
     print (data.toUpperCase());    });





// print("¿Cuantos huevos fritos deseeas?");
// int huevos= stdin.readByteSync();

// print("¿Cuantos jugos deseeas?");
// int jugos= stdin.readByteSync();




}

  






Future<String>preparacionHuevos(){
      return Future.delayed(new Duration(seconds: 3),(){
      return '¡Listo! 🥚';
      
      });
      
}




