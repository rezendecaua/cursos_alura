import 'package:bytebank/screens/dashboard/saldo.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:bytebank/screens/transferencia/ultimas.dart';
import 'package:flutter/material.dart';

const _textButtonDeposito = 'Receber depósito';
const _textButtonNovaTransferencia = 'Nova transferência';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () => _abrirFormularioDeposito(context),
                child: Text(_textButtonDeposito),
                color: Colors.green,
              ),
              RaisedButton(
                onPressed: () => _abrirFormularioNovaTransferencia(context),
                child: Text(_textButtonNovaTransferencia),
                color: Colors.green,
              )
            ],
          ),
          UltimasTransferencias(),
        ],
      ),
    );
  }

  void _abrirFormularioDeposito(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FormularioDeposito();
    }));
  }

  void _abrirFormularioNovaTransferencia(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FormularioTransferencia();
    }));
  }
}
