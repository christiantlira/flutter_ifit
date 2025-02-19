import 'package:flutter/material.dart';
import 'package:iFit/components/visual/logo_text.dart';

import '../visual/logo_icon.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBack;
  final String? backButtonRoute;

  const MyAppBar({super.key, this.backButtonRoute, required this.isBack});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Center(
        child: Container(
          height: 60, // Altura da AppBar
          width:
              MediaQuery.of(context).size.width * 0.8, // 70% da largura da tela
          decoration: BoxDecoration(
            color: Colors.black, // Cor da AppBar
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo sempre centralizada
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                MyIcon(size: 33),
                SizedBox(width: 5),
                MyLogo(size: 50),
              ]),

              // Botão de voltar sempre no canto esquerdo
              if (isBack)
                Positioned(
                  left: 5, // Ajuste para alinhar bem no canto
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if (backButtonRoute != null) {
                        Navigator.pushNamed(context, backButtonRoute!);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // Altura preferida da AppBar
}
