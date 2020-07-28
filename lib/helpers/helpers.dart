
import 'dart:math';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:formulario/Entities/Adress.dart';
import 'package:formulario/Entities/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

String getAvatar(String value) {
 if(value == null){
   var randon = new Random().nextInt(1000).toString();
   var hash = md5.convert(utf8.encode(randon));
   return 'https://www.gravatar.com/avatar/$hash?d=robohash';
 }else{
     var hash = md5.convert(utf8.encode(value.toLowerCase()));
     return 'https://www.gravatar.com/avatar/$hash?d=robohash';
 }
}

Future<Adress> getAdressByCep(String value) async{
 try{
    var dio = Dio(BaseOptions(baseUrl:'https://viacep.com.br/ws/$value'));
    var resposta  = await dio.get('/json');
     return Adress.fromMap(resposta.data);
   } on DioError catch(e){
    print('***Não foi possível chegar ao servidor.');
  }catch (e){
    print('***Houve um problema no processamento.'); 
  }finally{

  }
  return Adress.error(true);
}

void showUser(BuildContext parentContext,Usuario user){
 
 showDialog(
      context: parentContext,
      builder: (ctxDialog){
        return AlertDialog(
          title:Text('Dados: ${user.nome}'),
          content:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                  backgroundImage: NetworkImage(getAvatar(user.email)),
                           ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text('Nome:',style: TextStyle(fontWeight: FontWeight.bold ),),
                Text('${user.nome}'),   
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Text('Email:',style: TextStyle(fontWeight: FontWeight.bold ),),
                 Text('${user.email}'),
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Text('Cpf:',style: TextStyle(fontWeight: FontWeight.bold ),),
                 Text('${user.cpf}'), 
               ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Endreço:',style: TextStyle(fontWeight: FontWeight.bold ),),
                  Text('${user.userAdress.rua} ,${user.userAdress.numero},'
                   ' Bairro ${user.userAdress.bairro} ,${user.userAdress.cidade}'
                   ' - ${user.userAdress.uf}\n${user.userAdress.pais}' 
                  ), 
                ],
              ),
            ),
          ],),
          actions:[FlatButton(
                child: Text("OK"),
                 onPressed: () { 
                   Navigator.pop(parentContext);
                 },
                )]
         );
         
      }
    );
}

messageSnackBar(GlobalKey<ScaffoldState> scaffoldCtx, String msg){
 scaffoldCtx.currentState.showSnackBar(
  SnackBar(
   content: Text(msg),
   ),
 );
}

class LowerCaseTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

 
ProgressDialog showProgressDialog(context){
 ProgressDialog pr = new ProgressDialog(context);
    pr.style(
          message: 'Buscando o endereço ...',
          borderRadius: 10.0,
         // backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
        );
       return pr;
      }  