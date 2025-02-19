import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/appbars/app_bar.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/exercicio_tile.dart';
import 'package:iFit/components/series_slider.dart';
import 'package:iFit/components/text_field.dart';

class FinalizarCadastroTreino extends StatefulWidget {
  const FinalizarCadastroTreino({super.key});

  @override
  State<FinalizarCadastroTreino> createState() =>
      _FinalizarCadastroTreinoState();
}

class _FinalizarCadastroTreinoState extends State<FinalizarCadastroTreino> {
  late List<Exercicio> exercicios;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  bool _isInitialized = false; // Flag para evitar múltiplas inicializações

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      exercicios =
          ModalRoute.of(context)!.settings.arguments as List<Exercicio>;
      _isInitialized = true; // Marca como inicializado
    }
  }

  void reorderList(int oldIndex, int newIndex) {
    setState(() {
      final Exercicio movedItem = exercicios.removeAt(oldIndex);
      exercicios.insert(
          newIndex > oldIndex ? newIndex - 1 : newIndex, movedItem);
    });
  }

  void updateSeries(int index, int newValue) {
    setState(() {
      exercicios[index].series = newValue;
    });
  }

  void cadastrarTreino() async {
    final user = FirebaseAuth.instance.currentUser; // Obtém usuário logado
    if (user == null) return; // Se não estiver logado, não faz nada

    String treinoNome =
        nomeController.text; // Você pode pegar isso do TextField

    try {
      // Cria o documento do treino
      DocumentReference treinoRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("treinos")
          .doc(treinoNome);

      await treinoRef.set({
        "nome": treinoNome,
        "imgPath": exercicios.first.imgPath,
      });

      // Adiciona os exercícios individualmente
      for (var exercicio in exercicios) {
        await treinoRef.collection("exercicios").add({
          "nome": exercicio.nome,
          "series": exercicio.series,
          "imgPath": exercicio.imgPath,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Treino cadastrado com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar treino: $e")),
      );
    }
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(isBack: true, backButtonRoute: '/cadastrarTreino'),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: MyTextField(
                  controller: nomeController,
                  label: 'Nome do Treino',
                  hintText: "'Treino A' ou 'Treino de Peito'",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Segure e arraste para trocar a ordem',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ReorderableListView.builder(
                    itemCount: exercicios.length,
                    onReorder: reorderList,
                    itemBuilder: (context, index) {
                      return Padding(
                        key: ValueKey(exercicios[index]),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ExercicioTile(
                          exercicio: exercicios[index],
                          slider: MySlider(
                            exercicio: exercicios[index],
                            onChanged: (newValue) =>
                                updateSeries(index, newValue),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: cadastrarTreino,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.circular(100)),
                    alignment: Alignment.center,
                    child: Text(
                      'Cadastrar Treino',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
