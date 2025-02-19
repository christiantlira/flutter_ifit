import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/appbars/bottom_app_bar.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/appbars/app_bar.dart';

class HomeTela extends StatelessWidget {
  const HomeTela({super.key});

  Future<List<Exercicio>> fetchExercicios(String treinoId) async {
    CollectionReference exerciciosCollection = FirebaseFirestore.instance
        .collection("treinos")
        .doc(treinoId)
        .collection("exercicios");

    QuerySnapshot exerciciosSnapshot = await exerciciosCollection.get();

    List<Exercicio> exercicios = exerciciosSnapshot.docs.map((doc) {
      return Exercicio.fromFirestore(doc);
    }).toList();

    return exercicios;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(
          backButtonRoute: '/login',
          isBack: true,
        ),
        body: CarouselView.weighted(
          flexWeights: [1, 8, 1],
          controller: CarouselController(initialItem: 1),
          onTap: (int index) {
            Navigator.popAndPushNamed(context, "/cadastrarTreino");
          },
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 80,
                  color: AppColors.lightGray,
                ),
                Text(
                  "Adicione seus treinos",
                  style: TextStyle(
                    color: AppColors.lightGray,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
