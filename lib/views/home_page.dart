

import 'package:exemplo_formulario1/model/person.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();

  double _imc = 0.0;
  
  // _imageForm() {
  //   return Container(
  //     width: 900,
  //     height: 50,
  //     child: Image.network('https://thathi.com.br/wp-content/uploads/2021/03/20190904_00_balanca_peso_obesidade_emagrecimento.jpg', width: double.infinity,)
  //   );
  // }

  _rowName() {
    return new TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: new InputDecoration(hintText: 'Digite seu nome:'),
      maxLength: 100,// maximo de caracteres
      validator: (value) {
        if(value!.isEmpty) {
          return 'Digite um nome válido';
        }
        return null;
      },
    );
  }

  _rowWeight() {
    return new TextFormField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(hintText: 'Digite seu peso:'),
      maxLength: 10,
      validator: (value) {
        if(value!.length < 2 && value == 0) {
          return 'Digite um peso válido';
        }
        return null;
      },
    );
  }

  _rowHeight() {
    return new TextFormField(
      controller: _heightController,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(hintText: 'Digite sua altura:'),
      maxLength: 10,
      validator: (value) {
        if(value!.length < 2  && value == 0) {
          return 'Digite uma altura válida';
        }
        return null;
      },
    );
  }

  _rowButton(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
         _calculateIMC(context);
         _resetField();
        },
        icon: Icon(Icons.android),
        label: Text('Cadastrar')
    );
  }

  _formUI(BuildContext context) {
    return Column(
      children: [
        // _imageForm(),
        _rowName(),
        _rowWeight(),
        _rowHeight(),
        _rowButton(context),
      ],
    );
  }

  _rowForm(BuildContext context) {
    return  Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always, // Para validar os campos
          child: _formUI(context),
    );
  }

  _checkIMC() {
    return Row(
      children: [
        Text('IMC -> $_imc', style: TextStyle( fontSize: 18.5, color: Colors.blue),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: Column(
          children: [
            _rowForm(context),
            _checkIMC(),
          ],
        )
      )
    );
  }

  _calculateIMC(BuildContext context) {

    // Se todos os campos forem válidados corretamente ele faz
    // esse trecho inteiro

    print('Validou: ${_formKey.currentState!.validate()}');

    if(_formKey.currentState!.validate()) {
      // print('Clicou em cadastrar');
      // print('Seu nome é: ${_nameController.text.toString()}');
      // print('Seu peso é: ${_weightController.text.toString()}');
      // print('Sua altura é: ${_heightController.text.toString()}');
      
      // Convertendo String para double.tryParse
      double? weight = double.tryParse(_weightController.text);
      double? height = double.tryParse(_heightController.text);
      
      final person = Person(_nameController.text, weight!, height!);

      setState(() {
        _imc = person.calculateIMC();
      });
      
      print('Resultado: ${person.toString()}');

      // Escrevendo o resultado na tela com snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resultado: ${person.toString()}'))
      );

    } else {
      print('Campos incorreto');

      // Escrevendo mensagem de erro na tela com snack bar
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Digite os campos corretamente'))
      );
    }
  }

    // Para limpar os campos
    _resetField() => _formKey.currentState!.reset();
}