void main(){

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

  print(categorias["Salpicones"]["Con helado"]);



}