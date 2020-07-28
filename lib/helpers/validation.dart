import 'package:email_validator/email_validator.dart';
import 'package:cnpj_cpf_helper/cnpj_cpf_helper.dart';

 validationName(String value){
  value = value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(value.length < 3 || value.length > 30 ){
   return 'O nome deve ser maior que 3 e menor que 11'; 
  }
}

validationMail(String value){
  value = value.trim();
  print(value.length);
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(!EmailValidator.validate(value)){
   return 'Não parece ser um e-mail válido'; 
  }
}

validationCpf(String value){
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(!CnpjCpfBase.isCpfValid(value)){
   return 'Não parece ser um CPF válido'; 
  }
}

validationCep(String value){
  value = value.trim();
  if(value.length == 0){
   return 'Cep vázio - preencha o campo'; 
  }
  if((value.length != 8) || (int.tryParse(value) == null)) {
   return 'O cep está em um formato inválido'; 
  }
}

validationAdress(String value){
  value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(value.length < 3 || value.length > 30 ){
   return 'O endereço deve ser maior que 3 e menor que 11'; 
  }
}

localNumber(String value){
  value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(int.tryParse(value) == null){
   return 'Aqui somente números'; 
  }
}

validationBairro(String value){
  value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(value.length < 3 || value.length > 30 ){
   return 'O bairro deve ser maior que 3 e menor que 11'; 
  }
}

validationCity(String value){
  value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(value.length < 3 || value.length > 30 ){
   return 'A cidade deve ser maior que 3 e menor que 11'; 
  }
}

validationUf(String value){
  value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(value.length > 2 ){
   return 'O nome deve ser maior que 3 e menor que 11'; 
  }
}

validationCountry(String value){
  value.trim();
  if(value.length == 0){
   return 'Este campo é obrigatório'; 
  }
  if(value.toUpperCase() != 'BRASIL'){
   return 'Só aceitamos cadastros do Brasil'; 
  }
} 

