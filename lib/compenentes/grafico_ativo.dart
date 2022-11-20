import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:variacao_ativo/model/model_ativo.dart';
import 'package:variacao_ativo/repositorio/repositorio_ativo.dart';

class GraficoAtivo extends StatefulWidget {
  const GraficoAtivo({
    Key? key,
  }) : super(key: key);

  @override
  _GraficoAtivoState createState() => _GraficoAtivoState();
}

class _GraficoAtivoState extends State<GraficoAtivo> {
  List<FlSpot> dadosGrafico = [];
  List<dynamic> dadosUsados = [];
  double maxX = 0;
  double maxY = 0;
  double minY = 0;
  ValueNotifier<bool> loaded = ValueNotifier(false);

  late Map<String, String> loc;

  setDados() async {
    loaded.value = false;
    dadosGrafico = [];

    dadosUsados =
        Provider.of<AtivoRepositorio>(context).getAtivo().indicatorsOpen;

    maxX = dadosUsados.length.toDouble();
    maxY = 0;
    minY = double.infinity;

    for (var item in dadosUsados) {
      maxY = item > maxY ? item : maxY;
      minY = item < minY ? item : minY;
    }
// adciona espaçamento no topo e no fim do gráfico
    maxY = (maxY * 1.15).ceilToDouble();
    minY = (minY * 0.95).floorToDouble();

    for (int i = 0; i < dadosUsados.length; i++) {
      dadosGrafico.add(FlSpot(
        i.toDouble(),
        dadosUsados[i],
      ));
    }
    loaded.value = true;
  }

  @override
  Widget build(BuildContext context) {
    setDados();
    return ValueListenableBuilder(
      valueListenable: loaded,
      builder: (context, bool isLoaded, _) {
        return (isLoaded)
            ? LineChart(
                getChartData(),
              )
            : CircularProgressIndicator();
      },
    );
  }

  LineChartData getChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        verticalInterval: 1,
        horizontalInterval: 15,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 40,
            showTitles: true,
            interval: maxY -
                minY, // sempre mostrar 3 valores à esquerada, 1 acima e 1 abaixo e 1 no meio
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      borderData: FlBorderData(
        show: true,
      ),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      baselineX: 3,
      baselineY: 15,
      lineBarsData: [
        LineChartBarData(
          color: Colors.orange,
          curveSmoothness: 0.5,
          show: true,
          spots: dadosGrafico,
          isCurved: true,
          barWidth: 2,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).canvasColor,
          getTooltipItems: (data) {
            return data.map((item) {
              final date = getDate(item.spotIndex);
              return LineTooltipItem(
                '',
                const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '${item.y.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '\n $date',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }

  getDate(int index) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        Provider.of<AtivoRepositorio>(context, listen: false)
                .getAtivo()
                .timestamp[index] *
            1000);
    return DateFormat('dd/MM/y').format(date);
  }
}
