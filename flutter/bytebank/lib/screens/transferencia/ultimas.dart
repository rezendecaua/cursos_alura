import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _titulo = 'Últimas transferências';
const _textButtonTransferencias = 'Ver todas transferências';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final _ultimasTransferencias =
                transferencias.transferencias.reversed.toList();
            final _quantidade = transferencias.transferencias.length;

            if (_quantidade == 0) {
              return SemTransferenciaCadastrada();
            }

            int tamanho = 2;
            if (_quantidade < 3) {
              tamanho = _quantidade;
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tamanho,
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                return ItemTransferencia(_ultimasTransferencias[indice]);
              },
            );
          },
        ),
        RaisedButton(
          onPressed: () => _abrirListaTransferencias(context),
          child: Text(_textButtonTransferencias),
          color: Colors.green,
        ),
      ],
    );
  }

  void _abrirListaTransferencias(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListaTransferencias();
    }));
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Você ainda não cadastrou nenhuma transferência',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
