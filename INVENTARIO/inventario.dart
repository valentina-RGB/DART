import 'dart:io';

main() {
  /* Crea un programa POO llamado (inventario) que permita incrementar
  y decrementar el stock de un producto.
  
  1. Si se compra el producto se incrementa el stock 
  2. Si se vende el producto se decrementa el stock.
  No se permite comprar o vender cantidades inferiores a cero
  3. No se puede vender una cantidad superior al stock.
  
  4. El stock nunca podrá ser inferior a 5. Es decir si hay 5 productos
  y se van a vender 6 no se prodrá realizar la venta,
  
  Los atributos son : nombre, stock , precioCompra , PrecioVenta */
  print("\n*************INVENTARIO*****************");

  bool bandera = false;

  while (!bandera) {
    print("\t ¿QUE DESEEA HACER? \n");

    print(
        "\t \t***MENÚ**** \n\n 1. Comprar productos \n 2. Vender productos \n 3. Ver detalles \n 4. Salir");

    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case "1":
        
    }

    bandera = true;
  }
}

class inventario {
  int stock = 0;

  String nombreProducto = "";

  int precio = 0;

  int precioVenta = 0;

  int precioCompra = 0;

  inventario(this.nombreProducto, this.stock, this.precio) {}


  void crearVenta(int dato){

    if(dato< stock && stock > 5 ){
      stock-=dato;
    }else{

      print("El valor que ingresaste no es correcto");
    }
    

  }

  void crearCompra(int dato){
     if(dato< stock && stock > 5 ){
      stock+=dato;
    }else{

      print("El valor que ingresaste no es correcto");
    }

  }


  void tostrings() {
    print("****DETALLES****");
    print(" Nombre: ${nombreProducto} \n precio: ${precio} , \n Stock: ${stock}");
  }
}


