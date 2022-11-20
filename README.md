# Variação do Ativo


## Mobile
1. Implementar uma tela de abertura em linguagem nativa onde o usuário possa escolher entre visualizar a variação do preço ou o gráfico de da variação.
2. Consultar o preço do ativo na API do Yahoo Finance (este é um exemplo da consulta do ativo PETR4 https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA)
3. Implementar uma tela em linguagem nativa ou flutter que apresente a variação do preço do ativo nos últimos 30 pregões e mostre a rentabilidade no período. Você deverá considerar o valor de abertura (*chart.result.indicators.quote.open*)
4. Inclua um gráfico em linguagem nativa ou flutter apresentando o resultado da variação.
5. Disponibilizar seu app junto com seu código aqui no Github

Você pode ainda montar a parte de Backend deste desafio e consumir sua própria API em vez de utilizar a API do Yahoo Finance. Fica a sua escolha. :smirk:

## Importante
### Sobre a API
Os valores estrão estruturados em vetores, desta forma, você precisará casar a data do pregão (*chart.result.timestamp*) com o valor de abertura (*chart.result.indicators.quote.open*) através do indice do vetor.

### Sobre a entrega
:heavy_exclamation_mark: Use sua criatividade para estruturar sua solução. Importante manter uma documentação clara de como deveremos proceder para executar sua aplicação (__crie um arquivo MD e inclua no seu repositório__), sendo assim, importante disponibilizar os scripts de banco de dados e demais recursos utilizados e como utilizá-los. :heavy_exclamation_mark: 

#### ATENÇÃO
:heavy_exclamation_mark: Seu código deverá ser disponibilizado em um repositório no Github
