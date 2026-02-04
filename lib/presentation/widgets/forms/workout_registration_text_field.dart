import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercise.dart';

class WorkoutRegistrationTextField extends StatelessWidget {
  final Exercise exercise;
  final Function(int) onChanged;

  const WorkoutRegistrationTextField(
      {super.key, required this.exercise, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(
        text: exercise.sets.toString(),
      ),
      keyboardType: TextInputType.number,
      onSubmitted: (newValue) => onChanged(int.parse(newValue)),
      decoration: InputDecoration(
        labelText: 'Sets',
        border: OutlineInputBorder(),
      ),
    );
  }
}
