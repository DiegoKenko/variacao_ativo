import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:variacao_ativo/repositorio/repositorio_ativo.dart';

class ChartButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  const ChartButton({Key? key, this.text = '', this.isSelected = false})
      : super(key: key);

  @override
  State<ChartButton> createState() => _ChartButtonState();
}

class _ChartButtonState extends State<ChartButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          widget.text,
          style: TextStyle(
            color: Theme.of(context).canvasColor,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Provider.of<AtivoRepositorio>(context).ativo.text == widget.text
                  ? Theme.of(context).splashColor
                  : Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
