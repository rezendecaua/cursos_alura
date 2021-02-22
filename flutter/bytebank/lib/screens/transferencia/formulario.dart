import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              _controladorCampoNumeroConta,
              _rotuloCampoNumeroConta,
              _dicaCampoNumeroConta,
            ),
            Editor(
              _controladorCampoValor,
              _rotuloCampoValor,
              _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_textBotaoConfirmar),
              onPressed: () => _criaTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);

    if (_validaTransferencia(context, numeroConta, valor)) {
      final novaTransferencia = Transferencia(valor, numeroConta);

      _atualizaEstado(context, novaTransferencia);

      Navigator.pop(context);
    }
  }

  bool _validaTransferencia(
    BuildContext context,
    int numeroConta,
    double valor,
  ) {
    final _camposPreenchidos = numeroConta != null && valor != null;
    final _saldoSuficiente =
        valor <= Provider.of<Saldo>(context, listen: false).valor;

    return _camposPreenchidos && _saldoSuficiente;
  }

  void _atualizaEstado(BuildContext context, Transferencia novaTransferencia) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);

    Provider.of<Saldo>(context, listen: false).subtrai(novaTransferencia.valor);
  }
}
