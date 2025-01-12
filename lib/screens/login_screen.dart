import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // 🔹 Tambahkan Firestore
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  // 🔹 Tambahkan Firestore instance

  String _errorMessage = '';  

  Future<void> loginUser() async {
    setState(() {
      _errorMessage = ''; 
    });

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final User? user = userCredential.user;
      print("User logged in: ${user?.uid}"); 

      if (user != null) {
        await saveUserToFirestore(user); // 🔹 Simpan user ke Firestore jika belum ada

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(), 
          ),
        );
      } else {
        print("User is null after login!");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
      } else {
        errorMessage = 'Login failed: ${e.message}';
      }
      setState(() {
        _errorMessage = errorMessage;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unknown error occurred: $e';
      });
    }
  }

  /// 🔹 Fungsi untuk menyimpan user ke Firestore
  Future<void> saveUserToFirestore(User user) async {
    DocumentReference userRef = _firestore.collection('users').doc(user.uid);

    DocumentSnapshot doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'email': user.email,
        'displayName': user.displayName ?? '',
        'profilePic': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User data saved to Firestore");  // Debug
    } else {
      print("User already exists in Firestore"); // Debug jika user sudah ada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
