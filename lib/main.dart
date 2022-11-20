import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:variacao_ativo/compenentes/chart_button.dart';
import 'package:variacao_ativo/compenentes/grafico_ativo.dart';
import 'package:variacao_ativo/repositorio/repositorio_ativo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: const Color.fromARGB(255, 2, 140, 182),
        splashColor: Colors.amber[400],
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget grafico;
  final List<String> listaAtivos = [
    'PETR4',
    'VALE3',
    'ITUB4',
    'BBDC4',
    'ELET6',
    'ABEV3',
    'BBAS3',
  ];
  int selected = 9999;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider<AtivoRepositorio>(
            create: (context) => AtivoRepositorio(),
            builder: (context, widget) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        'ATIVOS',
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    width: double.infinity,
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      color: Theme.of(context).canvasColor,
                      width: double.infinity,
                      height: 60,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: listaAtivos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTapDown: (x) {
                                  selected = index;
                                  Provider.of<AtivoRepositorio>(context,
                                          listen: false)
                                      .buscarDadosAtivo(listaAtivos[index]);
                                },
                                onTap: () {
                                  selected = index;
                                  Provider.of<AtivoRepositorio>(context,
                                          listen: false)
                                      .buscarDadosAtivo(listaAtivos[index]);
                                },
                                onTapUp: (x) {
                                  selected = index;
                                  Provider.of<AtivoRepositorio>(context,
                                          listen: false)
                                      .buscarDadosAtivo(listaAtivos[index]);
                                },
                                child: ChartButton(
                                  text: listaAtivos[index],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  if (Provider.of<AtivoRepositorio>(context, listen: true)
                      .ativo
                      .indicatorsOpen
                      .isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      height: 30,
                      child: Center(
                        child: Text(
                          '${DateFormat('dd/MM/yyyy').format(
                                DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month - 1,
                                  DateTime.now().day,
                                ),
                              ).toString().substring(0, 10)} até ${DateFormat('dd/MM/yyyy').format(
                                DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                              ).toString().substring(0, 10)}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).canvasColor,
                            wordSpacing: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (Provider.of<AtivoRepositorio>(context, listen: true)
                      .ativo
                      .indicatorsOpen
                      .isNotEmpty)
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 400,
                      child: GraficoAtivo(),
                    ),
                  if (Provider.of<AtivoRepositorio>(context, listen: true)
                      .ativo
                      .indicatorsOpen
                      .isNotEmpty)
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Rentabilidade no período: ${Provider.of<AtivoRepositorio>(context).getRentabilidade()}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).canvasColor,
                            wordSpacing: 4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).canvasColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
