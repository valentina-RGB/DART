

main(){
  
  personas persona= new personas("Valentina", "Córdoba",6 );
  persona.age=3;
}



class personas{

  String name;
  String lastname;
  int age;
  personas(this.name, this.lastname, [this.age = 0]){
   print("name: ${name},  Lastname: ${lastname}, age: ${age.toString()}");
  }
}