import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:variacao_ativo/model/model_ativo.dart';
import 'package:http/http.dart' as http;

class AtivoRepositorio extends ChangeNotifier {
  Ativo ativo = Ativo();

  buscarDadosAtivo(String idAtivo) async {
    final response = await http.get(
      // ?interval = intervalor de tempo
      // ?range = alcançe de tempo
      Uri.parse(
        'https://query2.finance.yahoo.com/v8/finance/chart/$idAtivo.SA?interval=1d&range=1mo&',
      ),
    );
    List<Map<String, dynamic>> valores = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ativo = Ativo.fromJson(json);
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Ativo getAtivo() => ativo;

  double getRentabilidade() =>
      roundDouble(ativo.indicatorsOpen.last - ativo.indicatorsOpen.first, 3);

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
