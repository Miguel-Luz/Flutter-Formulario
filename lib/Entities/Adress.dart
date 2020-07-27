

class Adress {

  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String uf;
  String pais;
  bool error;
 
Adress(
   
     this.cep,
     this.rua,
     this.numero,
     this.bairro,
     this.cidade,
     this.uf,
     this.pais,
     {this.error}
  );


Adress.fromMap(Map<String,dynamic> map){
   cep = map['cel'] ?? null;
   rua = map['logradouro'] ?? null ;
   numero = map['numero'] ?? null ;
   bairro = map['bairro'] ?? null;
   cidade = map['localidade'] ?? null;
   uf = map['uf'] ?? null;
   pais = map['pais'] ?? null ;
   error = map['erro'] ?? false ;
  }  
}



