

import 'dart:async';
void main() async {   //Es super importante no olvidar el async

print("Suma:");
final suma= await getsuma();
print(suma);

print("Promedio:");
final promedio= await getpromedio();
print(promedio);

// print("Factorial:");
// final factorial= await getfactorial();
// print(factorial);
// }

// Future<double> getfactorial() async{
//     double factorial = 0;    int i=0;
//     for (i= 1; i <10; i++){
//         factorial*=i;
  
//     }
    
//     return factorial;
}

Future<double> getpromedio() async{  // A esta ascción se le llama future (Ayuda cuando se trabaje con apis su tiempo de respuesta no esta definido)
  return Future.delayed(new Duration(seconds:6),(){ //Ayuda a que el momento de respuesta dure 6 segundos.
    double promedio = 0;
    double resultado=0;
    int i=0;
    
    for (i= 0; i <10; i++){
        promedio+=i;
        resultado=promedio/i;
    }
    return resultado ;    // El retun debe de ir simpre dentro de el fiture.
      });
    
}

Future<double> getsuma() async{
  return Future.delayed(new Duration(seconds: 3),(){
    double suma= 0;
    for (int i=0; i<10; i++){
      suma+=i;
    }return suma;
  });

}