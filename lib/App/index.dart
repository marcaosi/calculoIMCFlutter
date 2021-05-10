import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _alturaController = TextEditingController();
  var _pesoController = TextEditingController();
  var _isVisibleResult = false;
  var _resultIMC = 0.0;
  var _statusPerson = "";
  var _key = GlobalKey<ScaffoldState>();

  _onTappedBottomNavigation(index) {
    if (index == 0) {
      //clear
      _alturaController.clear();
      _pesoController.clear();
      setState(() {
        _isVisibleResult = false;
      });
    } else if (index == 1) {
      //save

      if (_alturaController.text == "" || _pesoController.text == "") {
        _key.currentState.showSnackBar(
            new SnackBar(content: Text("Informe valores válidos.")));
        return;
      }

      var calculatedWeight = double.parse(_pesoController.text);
      var calculatedHeight = double.parse(_alturaController.text);
      setState(() {
        _resultIMC = calculatedWeight / (calculatedHeight * calculatedHeight);

        if (_resultIMC < 18.5) {
          _statusPerson = "Abaixo do Peso";
        } else if (_resultIMC < 24.9) {
          _statusPerson = "Peso Normal";
        } else if (_resultIMC < 29.9) {
          _statusPerson = "Sobrepeso";
        } else if (_resultIMC < 34.9) {
          _statusPerson = "Obesidade Grau I";
        } else if (_resultIMC < 39.9) {
          _statusPerson = "Obesidade Grau II";
        } else {
          _statusPerson = "Obesidade Grau III ou Mórbida";
        }
        _isVisibleResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Cálculo IMC"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Informe seus dados abaixo"),
                TextField(
                  controller: _alturaController,
                  decoration: InputDecoration(hintText: "Altura"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _pesoController,
                  decoration: InputDecoration(hintText: "Peso"),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            Visibility(
                visible: _isVisibleResult,
                child: Column(
                  children: [
                    Text('Seu IMC é: ${_resultIMC.toStringAsFixed(2)}'),
                    Text('De acordo com a OMS seu status é: $_statusPerson')
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTappedBottomNavigation,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.clear), label: "Limpar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow), label: "Calcular")
        ],
      ),
    );
  }
}
