import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    checkEmailVerification();
  }

  void checkEmailVerification() async {
    await user?.reload();
    if (user?.emailVerified == true) {
      Navigator.of(context).pushReplacementNamed('/notes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text('Verify your email...'),
          TextButton(
            onPressed: () async {
              await user?.sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: checkEmailVerification,
            child: const Text('Check verification'),
          ),
        ],
      ),
    );
  }
}
