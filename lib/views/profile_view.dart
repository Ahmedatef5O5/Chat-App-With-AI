import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(25),
            Stack(
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 48)),

                Positioned(
                  top: 60,
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email Address'),
                subtitle: Text(user?.email ?? 'No email found'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Display Name'),
                subtitle: Text(user?.displayName ?? 'Not set'),
              ),
            ),
            const Spacer(),

            CustomElevatedButton(
              minimumSize: Size(200, 50),
              maximumSize: Size(200, 50),
              txtBtn: 'Logout',
              bgColor: Colors.red.shade100,
              txtColor: Colors.red,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
