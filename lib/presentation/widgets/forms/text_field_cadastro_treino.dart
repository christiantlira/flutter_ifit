import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercicio.dart';
import 'package:iFit/core/constants/app_colors.dart';

class TextfieldCadastroTreino extends StatelessWidget {
  final Exercicio exercicio;
  final Function(int) onChanged;

  const TextfieldCadastroTreino(
      {super.key, required this.exercicio, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(
        text: exercicio.series == null ? '3' : exercicio.series!.toString(),
      ),
      keyboardType: TextInputType.number,
      onSubmitted: (newValue) => onChanged(int.parse(newValue)),
      decoration: InputDecoration(
        labelText: 'Séries',
        border: OutlineInputBorder(),
      ),
    );
  }
}
