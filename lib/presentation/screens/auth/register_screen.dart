import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iFit/presentation/widgets/app_bars/app_bar.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/data/services/auth_service.dart';

import '../../widgets/forms/text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController senhaController = TextEditingController();

    FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: MyAppBar(
        isBack: true,
        backButtonRoute: '/login',
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Cadastrar Conta",
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    MyTextField(
                      controller: nomeController,
                      label: "Nome",
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: MyTextField(
                        controller: emailController,
                        isEmail: true,
                        label: "E-mail",
                        hintText: "exemplo@email.com",
                      ),
                    ),
                    MyTextField(
                      controller: senhaController,
                      isPassword: true,
                      label: "Senha",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = <String, dynamic>{
                            "nome": nomeController.text,
                            "email": emailController.text,
                            "senha": senhaController.text
                          };
                          await AuthService().SignUp(
                              email: emailController.text,
                              password: senhaController.text,
                              context: context);
                          db
                              .collection("users")
                              .add(user)
                              .then((DocumentReference doc) => (doc.id));
                        }
                      },
                      child: Text("Cadastrar"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
