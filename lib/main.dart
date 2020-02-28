import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Color appColor = Colors.teal;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _info = "";

  void _refresh() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _info = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();  
    });
  }

  double _calculate() {
    double weight = weightController.text == null? 1 : double.parse(weightController.text);
    double height = heightController.text == null? 1 :  double.parse(heightController.text) / 100;

    return weight / (height * height);
  }

  String getInfoIMC() {
    double imc = _calculate();
    String imcString = imc.toStringAsPrecision(4);

    if(imc < 18.6) return "Abaixo do peso (${imcString})";
    if(imc >= 18.6 && imc < 24.9) return "Peso ideal (${imcString})";
    if(imc >= 24.9 && imc < 29.9) return "Levemente acima do peso ideal (${imcString})";
    if(imc >= 29.9 && imc < 34.9) return "Obesidade grau I (${imcString})";
    if(imc >= 34.9 && imc < 39.9) return "Obesidade grau II (${imcString})";
    if(imc >= 40) return "Obesidade grau III (${imcString})";

    return "Obesidade grau III (${imcString})";
  } 

  void _setInfo() {
    setState(() {
      _info = getInfoIMC();
    });
  }

  Widget getForm(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:10, bottom:10), 
            child: Icon(Icons.person_pin, size: 120, color: appColor,)
          ),
          Padding(
            padding: EdgeInsets.only(top:10, bottom:10), 
            child: TextFormField(
              controller: weightController,
              validator: (value){
                if(value.isEmpty) return "Insira seu peso!";
                if(double.parse(value) <= 0) return "Insira um peso válido!";
              },
              decoration: InputDecoration(labelText: "Peso (kg)", labelStyle: TextStyle(color: appColor)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(color: appColor, fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:10, bottom:10),
            child: TextFormField(
              controller: heightController,
              validator: (value){
                if(value.isEmpty) return "Insira sua altura!";
                if(double.parse(value) <= 0) return "Insira uma altura válida!";
              },
              decoration: InputDecoration(labelText: "Altura (cm)", labelStyle: TextStyle(color: appColor)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(color: appColor, fontSize: 20),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(top:10, bottom:10),
            child: Container(
              height: 50,
              child: RaisedButton(
                color: appColor,
                child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20),),
                onPressed: () {
                  if(_formKey.currentState.validate()) _setInfo();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:10, bottom:10),
            child: Text(_info, textAlign: TextAlign.center, style: TextStyle(color: appColor, fontSize: 15),)
          ),
        ],
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: appColor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _refresh,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: getForm(),)
    );
  }
}
