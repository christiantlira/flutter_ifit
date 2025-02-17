import 'package:flutter/material.dart';

class AppLists {
  static const List<List<MapEntry<String, String>>> exs = [
    [
      MapEntry("Supino inclinado c/ halter", "lib/imgs/exs/img1.jpg"),
      MapEntry("Supino inclinado c/ barra", "lib/imgs/exs/img2.jpg"),
      MapEntry("Supino reto c/ barra", "lib/imgs/exs/img3.jpg"),
      MapEntry("Supino reto c/ halter", "lib/imgs/exs/img4.jpg"),
      MapEntry("Voador", "lib/imgs/exs/img5.jpg"),
      MapEntry("Cross na polia alta", "lib/imgs/exs/img6.jpg")
    ],
    [
      MapEntry("Puxada alta", "lib/imgs/exs/img7.jpg"),
      MapEntry("Remada baixa", "lib/imgs/exs/img8.jpg"),
      MapEntry("Encolhimento p/ trapézio", "lib/imgs/exs/img9.jpg"),
      MapEntry("Puxada alta triângulo", "lib/imgs/exs/img10.jpg"),
      MapEntry("Remada unilateral", "lib/imgs/exs/img11.jpg"),
      MapEntry("Puxada triangulo", "lib/imgs/exs/img12.jpg"),
    ],
  ];

  // Lista de títulos para cada página
  static const List<String> pageTitles = [
    "Peito",
    "Costa",
    "Ombro",
    "Bíceps",
    "Tríceps",
    "Abdômen",
    "Quadriceps",
    "Glúteos",
    "Posterior",
    "Panturrilha"
  ];
}
