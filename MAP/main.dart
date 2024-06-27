import 'dart:io';
void main(){

/* Realiza mediante funciones un programa que permita sumar, restar, multiplicar y dividir 2 
nuúmero se le debe solicitar al usuario la operación a realizar y los 2 números  */


/* Realizar mediante funciones un programa que permita insertar, modificar, eliminar , consultar los datos
 de una lista, La lista debe ser la de una de sus proyectos. */





print("ACTVIDAD \n");

print("¿Que actividad deseas ver? :)");
String? actididad_N = stdin.readLineSync();

if (actididad_N == "1"){

  print("¿Que operación desea realizar?");
  String? operacion = stdin.readLineSync();

  print("Ingrese el primer número: ");
  int numero1 = int.parse(stdin.readLineSync()!);

  print("Ingrese el segundo número:");
  int numero2 = int.parse(stdin.readLineSync()!);

   
   String calcular (int numero1, int numero2, String? operador){
    int valor= 0;
    if ( operador == "+"){
      valor= numero1 + numero2;

    }else if (operador == "-"){
      valor= numero1 - numero2;

    }else if(operador == "*"){
      valor= numero1 * numero2;
    }else if(operador == "%"){
        valor= numero1 % numero2;
    }else{
      print("El dato no es valido :(");
    }

    return "El valor es ${valor}";
  }

  print(calcular(numero1, numero2, operacion));
  
} else{
   Map productos = {
    1:{
      "Salpicón pequeño": "5500"
    },
    2: {
      "Salpicón mediano": "7000"
    },
    3: {
      "Salpicón grande": "9500"
    },
    4: {
      "Salpicón pequeño sin helado": "4500"
    },
    5: {
      "Salpicón mediano sin helado": "5500"
    },
     6: {
      "Salpicón especial": "12600"
    },
     7: {
      "Salpicón especial con queso": "12000"
    }
  };
   Map categorias = {
  "Salpicones":{
    "Con helado":{
      {
       "Descripción":productos[1],
       "Estado": "Disponible" 
      },
      {
       "Descripción":productos[2],
       "Estado": "Disponible" 
      },
      {
       "Descripción":productos[3],
       "Estado": "Disponible" 
      }
    },
    "Sin helado" : {
       {
       "Descripción":productos[4],
       "Estado": "Disponible" 
      },
      {
       "Descripción":productos[5],
       "Estado": "Disponible" 
      }
    },
     "Especiales" : {
       {
       "Descripción":productos[6],
       "Estado": "Disponible" 
      },
      {
       "Descripción":productos[7],
       "Estado": "Disponible" 
      }
    }
   
   
  } 
 }
 ;
 bool bandera = true;
 while (bandera == true) {

  print("¡BIENVENIDO!");

  print("¿Que deea hacer?");
  print("1. Insertar un dato\n 2. Modificar un dato\n 3. Eliminar un dato\n 4. Consultar un dato");

  bandera=false;
}

}

}