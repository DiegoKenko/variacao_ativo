class Ativo {
  String currency = '';
  String symbol = '';
  String text = '';
  String exchangeName = '';
  int firstTradeDate = 0;
  String range = '';
  List<dynamic> timestamp = [];
  List<dynamic> indicatorsLow = [];
  List<dynamic> indicatorsHigh = [];
  List<dynamic> indicatorsOpen = [];
  List<dynamic> indicatorsClose = [];

  Ativo({
    this.currency = '',
    this.symbol = '',
    this.text = '',
    this.exchangeName = '',
    this.firstTradeDate = 0,
    this.range = '',
    this.timestamp = const [],
    this.indicatorsLow = const [],
    this.indicatorsHigh = const [],
    this.indicatorsOpen = const [],
    this.indicatorsClose = const [],
  });

  Ativo.fromJson(Map<String, dynamic> json) {
    currency = json['chart']['result'][0]['meta']['currency'];
    symbol = json['chart']['result'][0]['meta']['symbol'];
    text = json['chart']['result'][0]['meta']['symbol'];
    text = text.replaceAll(RegExp('.SA'), '');
    exchangeName = json['chart']['result'][0]['meta']['exchangeName'];
    firstTradeDate = json['chart']['result'][0]['meta']['firstTradeDate'];
    range = json['chart']['result'][0]['meta']['range'];
    timestamp = json['chart']['result'][0]['timestamp'];
    indicatorsLow = json['chart']['result'][0]['indicators']['quote'][0]['low'];
    indicatorsHigh =
        json['chart']['result'][0]['indicators']['quote'][0]['high'];
    indicatorsOpen =
        json['chart']['result'][0]['indicators']['quote'][0]['open'];
    indicatorsClose =
        json['chart']['result'][0]['indicators']['quote'][0]['close'];
  }
}
