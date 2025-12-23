import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/header.dart';
import '../../viewmodels/profile_viewmodel.dart';

const String defaultProfileImage = 'assets/profile.png';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;

  @override
  void initState() {
    super.initState();
    final vm = context.read<ProfileViewModel>();
    nameCtrl = TextEditingController(text: vm.user?.displayName ?? "");
    emailCtrl = TextEditingController(text: vm.user?.email ?? "");
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: Header(
        title: "Edit Profil",
        startColor: const Color(0xFFFF8383),
        endColor: Colors.white,
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: vm.pickProfileImage,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: vm.profileImage != null
                    ? FileImage(vm.profileImage!)
                    : const AssetImage(defaultProfileImage) as ImageProvider,
              ),
            ),

            const SizedBox(height: 30),

            _input("Nama", nameCtrl),
            const SizedBox(height: 20),
            _input("Email", emailCtrl),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: vm.isLoading
                  ? null
                  : () async {
                      final error = await vm.updateProfile(
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                      );

                      if (error == null && mounted) {
                        Navigator.pop(context);
                      } else if (error != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                      }
                    },
              child: vm.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("SAVE"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(controller: c),
      ],
    );
  }
}
