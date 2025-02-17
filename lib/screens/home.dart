import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iFit/components/appbars/bottom_app_bar.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/services/auth_service.dart';
import 'package:iFit/components/appbars/app_bar.dart';

class HomeTela extends StatelessWidget {
  const HomeTela({super.key});

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
        body: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, "/cadastrarTreino");
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
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
            ),
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
