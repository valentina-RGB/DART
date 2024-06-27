import 'dart:io';

main(List cuenta) {
  bool bandera = false;

  cuentas program = new cuentas();

  while (!bandera) {
    print(
        " 1. Registrar Cuenta \n 2. Consignar dinero \n 3. Transferir dinero \n 4. Retirar dinero \n 5. Salir \n 6. Ver detalles");
    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case "1":
        program.creaCuenta();

        break;

      case "2":
        program.consignacion();

        break;

      case "3":
        program.transferencia();
        break;

      case "4":
        program.retiro();

      case "5":
        print("¡BYE!");
        bandera = true;

      case "6":
        program.detalles();
    
    }
  }
}

class cuentas {
  List<cuentas> cuenta = [];

  int saldo = 0;
  String? nombre = "";
  String? id = "0";

  int contador= 100;

  cuentas([this.id, this.nombre, this.saldo = 0]) {}

  void creaCuenta() {
    print("Buscar cuenta:");
    String? buscar = stdin.readLineSync();

    bool validation = false;

    if (cuenta.isEmpty) {
      cuenta.add(cuentas(contador.toString(), "valentina"));
      contador++;
    }
    if (cuenta.isNotEmpty) {
      for (var i = 0; i < cuenta.length; i++) {
        if (cuenta[i].nombre == buscar) {
          validation = true;
        }
      }
      if (!validation) {
        print("La cuenta ${buscar} no existe :/  -> pero fue añadida correctamente :)");
        cuenta.add(cuentas(contador.toString(), buscar));
        contador++;

      } else {
        print("¡ups! ${buscar} ya existe :( ");
      }
    }

    for (int i = 0; i < cuenta.length; i++) {
      print("cuenta:  ${cuenta[i].id} Cliente: ${cuenta[i].nombre}");
    }
  }

  void consignacion() {
    print("¿A que cuenta desea consignar?");
    String? persona = stdin.readLineSync();

    bool validation = false;

    int captura = 0;

    for (var i = 0; i < cuenta.length; i++) {
      if (cuenta[i].nombre == persona || cuenta[i].id== persona) {
        captura = i;
        validation = true;
      }
    }
    if (!validation) {
      print("Esta persona no tiene cuenta :(");
    } else {
      print("Ingrese el valor que desea consignar");

      String? input = stdin.readLineSync();
      int saldo = int.parse(input!);

      if(saldo<=0){
        print("El valor no es correcto");
      }else{
         cuenta[captura].saldo += saldo;
      print("Su consignación de ${saldo} fue enviada con exito :)");
      }

     
    }

  }

  void retiro() {
    print("Número o nombre de la cuenta en la que desea retirar");
    String? persona = stdin.readLineSync();

    bool validation = false;

    int captura = 0;

    for (var i = 0; i < cuenta.length; i++) {
      if (cuenta[i].nombre == persona || cuenta[i].id == persona) {
        captura = i;
        validation = true;
      }
    }
    if (!validation) {
      print("Esta persona no tiene cuenta :(");
    } else {
      print("Ingrese el valor que desea retirar");

      String? input = stdin.readLineSync();
      int saldo = int.parse(input!);

      if (saldo > 0 && saldo <= cuenta[captura].saldo) {
        cuenta[captura].saldo -= saldo;

        for (int i = 0; i < cuenta.length; i++) {
          print(
              "cuenta:  ${cuenta[i].id}  Nombre: ${cuenta[i].nombre} Saldo: ${cuenta[i].saldo}");
        }
      } else {
        print(
            "El dato ingresado no es válido");
      }
    }
  }

  void transferencia() {
    print("Nombre o número de la cuenta a la que desea transferir ...");
    String? persona1 = stdin.readLineSync();

    print("Ingrese su nombre o número cuenta...");
    String? persona2 = stdin.readLineSync();

    bool validation1 = false;
    bool validation2 = false;

    int captura1 = 0;
    int captura2 = 0;

    for (var i = 0; i < cuenta.length; i++) {
      if (cuenta[i].nombre == persona1 || cuenta[i].id == persona1) {
        captura1 = i;
        validation1 = true;
      }
      if (cuenta[i].nombre == persona2 || cuenta[i].id == persona2) {
        captura2 = i;
        validation2 = true;
      }
    }
    if (!validation1 || !validation2) {
      print("Los datos no son correctos");
    } else {
      print("Ingrese saldo");

      String? input = stdin.readLineSync();
      int saldo = int.parse(input!);

      if (saldo > 0 && saldo <= cuenta[captura2].saldo) {
        cuenta[captura1].saldo += saldo;
        cuenta[captura2].saldo -= saldo;

        print("\n *** \n Acabas de transferir a la cuenta ${cuenta[captura1].id}  ${cuenta[captura1].nombre}  ahora tu saldo es de : ${cuenta[captura2].saldo} \n *** \n");
      } else {
        print("No tienes esa cantidad :(");
      }
    }
      
    
  }

  void detalles() {
      

      for (var i = 0; i < cuenta.length; i++) {
      print("\n \n *********DETALLE(${i+1})***********");
      print("\t ID Cuenta: ${cuenta[i].id}");
      print("\t Clienta: ${cuenta[i].nombre}");
      print("\t Saldo disponible: ${cuenta[i].saldo} \n");
       
    

  }
}

}
