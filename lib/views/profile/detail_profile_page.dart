import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/header.dart';
import '../../viewmodels/profile_viewmodel.dart';

class DetailProfilePage extends StatelessWidget {
  const DetailProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: const Header(
        title: "Profil",
        startColor: Color(0xFFFF8383),
        endColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: vm.profileImage != null
                  ? FileImage(vm.profileImage!)
                  : null,
            ),
            const SizedBox(height: 20),
            _info("Nama", vm.user?.displayName ?? "-"),
            _info("Email", vm.user?.email ?? "-"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/edit_profile'),
              child: const Text("EDIT"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          height: 45,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value),
        ),
      ],
    );
  }
}
