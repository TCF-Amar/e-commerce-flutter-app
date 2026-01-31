import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Column(children: [Text('Profile'), LogoutButton()])),
    );
  }
}
