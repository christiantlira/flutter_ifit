import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/classes/treino.dart'; // Certifique-se que Treino.fromFirestore está correto
import 'package:iFit/components/appbars/bottom_app_bar.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/appbars/app_bar.dart';
import 'package:iFit/components/treinos_carrossel.dart';

class HomeTela extends StatefulWidget {
  const HomeTela({super.key});

  @override
  State<HomeTela> createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {
  late Future<List<Treino>> futureTreinos;

  @override
  void initState() {
    super.initState();
    futureTreinos = fetchTreinos();
  }

  Future<List<Treino>> fetchTreinos() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return []; // Se não houver usuário, retorna lista vazia
    }

    try {
      CollectionReference treinosCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("treinos");

      QuerySnapshot treinosSnapshot = await treinosCollection.get();

      List<Treino> treinos = await Future.wait(
        treinosSnapshot.docs.map((doc) async {
          List<Exercicio> exercicios = await Treino.fetchExercicios(doc.id);
          return Treino.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>, exercicios);
        }),
      );
      return treinos;
    } catch (e) {
      print("Erro ao buscar treinos: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(
          backButtonRoute: '/login',
          isBack: true,
        ),
        body: FutureBuilder<List<Treino>>(
          future: futureTreinos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Erro ao carregar treinos: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white)),
              );
            } else {
              List<Treino> treinos = snapshot.data ?? [];
              return MyTreinoCarousel(treinos: treinos);
            }
          },
        ),
        bottomNavigationBar: MyBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryRed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/cadastrarTreino');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
