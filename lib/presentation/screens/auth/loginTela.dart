import 'package:flutter/material.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/presentation/widgets/common/logo_icon.dart';
import 'package:iFit/presentation/widgets/common/logo_text.dart';
import 'package:iFit/presentation/widgets/buttons/sign_in_button.dart';
import 'package:iFit/presentation/widgets/tiles/square_tile.dart';
import 'package:iFit/data/services/auth_service.dart';

import '../../widgets/forms/text_field.dart';

class LoginTela extends StatelessWidget {
  const LoginTela({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController senhaController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            MyIcon(size: 70),
            MyLogo(size: 100),
            Text(
              'Bem-vindo de volta, sentimos sua falta',
              style: TextStyle(color: AppColors.lightGray, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: MyTextField(
                      controller: emailController,
                      hintText: "E-mail",
                    ),
                  ),
                  MyTextField(
                    controller: senhaController,
                    isPassword: true,
                    hintText: "Senha",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(color: AppColors.lightGray),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            MySignInButton(
              onTap: () {
                AuthService().SignIn(
                    email: 'teste@gmail.com',
                    password: 'b0l@sete',
                    context: context);
              },
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: AppColors.lightGray,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Ou continue com",
                      style: TextStyle(color: AppColors.lightGray),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: AppColors.lightGray,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //google button
                SquareTile(
                  imgPath: "lib/imgs/google.png",
                  onPressed: () {
                    AuthService().SignInWithGoogle(context: context);
                  },
                ),
                SizedBox(width: 25),
                //face button
                SquareTile(
                  imgPath: "lib/imgs/face.png",
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não é membro?',
                  style: TextStyle(color: AppColors.lightGray),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/registro");
                  },
                  child: Text(
                    'Crie sua conta agora',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
