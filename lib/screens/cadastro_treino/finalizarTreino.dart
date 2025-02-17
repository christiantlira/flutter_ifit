import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/appbars/app_bar.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/exercicio_tile.dart';
import 'package:iFit/components/text_field.dart';

class FinalizarCadastroTreino extends StatefulWidget {
  const FinalizarCadastroTreino({super.key});

  @override
  State<FinalizarCadastroTreino> createState() =>
      _FinalizarCadastroTreinoState();
}

class _FinalizarCadastroTreinoState extends State<FinalizarCadastroTreino> {
  late List<Exercicio> lista;
  late Map<String, int>
      seriesPorExercicio; // Armazena a quantidade de séries de cada exercício

  @override
  void initState() {
    super.initState();
    lista = []; // Inicializa vazia até receber os argumentos
    seriesPorExercicio = {};
  }

  void reorderList(int oldIndex, int newIndex) {
    setState(() {
      final tile = lista.removeAt(oldIndex);
      lista.insert(oldIndex > newIndex ? newIndex : newIndex - 1, tile);
    });
  }

  void atualizarSeries(String nomeExercicio, int valor) {
    setState(() {
      seriesPorExercicio[nomeExercicio] = valor;
    });
  }

  void cadastrarTreino() {
    for (var exercicio in lista) {
      int series = seriesPorExercicio[exercicio.nome] ?? 3; // Padrão = 3 séries
      print('Exercício: ${exercicio.nome}, Séries: $series');
    }

    // Aqui você pode enviar esses dados para o Firestore ou salvar no local desejado.
  }

  @override
  Widget build(BuildContext context) {
    lista = ModalRoute.of(context)!.settings.arguments as List<Exercicio>;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nomeController = TextEditingController();

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
                    itemCount: lista.length,
                    onReorder: reorderList,
                    itemBuilder: (context, index) {
                      return Padding(
                        key: ValueKey(lista[index]),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ExercicioTile(
                          exercicio: lista[index],
                          valorAtual:
                              seriesPorExercicio[lista[index].nome] ?? 3,
                          onValorMudou: atualizarSeries,
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
