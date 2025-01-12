// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'chat_screen.dart'; // Pastikan file chat_screen.dart sudah ada

// class UsersScreen extends StatefulWidget {
//   @override
//   _UsersScreenState createState() => _UsersScreenState();
// }

// class _UsersScreenState extends State<UsersScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
//   User? currentUser;

//   @override
//   void initState() {
//     super.initState();
//     currentUser = _auth.currentUser;
//   }

//   /// 🔹 Fungsi untuk memulai chat antara dua pengguna
//  void startChat(String currentUser, String otherUser) async {
//   var chatRef = _firestore.collection('chats');
//   var existingChat = await chatRef.where('users', arrayContains: currentUser).get();

//   String chatId = ''; // Inisialisasi chatId dengan nilai kosong

//   for (var doc in existingChat.docs) {
//     var users = List<String>.from(doc['users']);
//     if (users.contains(otherUser)) {
//       chatId = doc.id;  // Tentukan chatId jika chat sudah ada
//       break;
//     }
//   }

//   // Jika chatId masih kosong (chat belum ada), buat chat baru
//   if (chatId.isEmpty) {
//     var newChat = await chatRef.add({
//       'users': [currentUser, otherUser],
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//     chatId = newChat.id; // Ambil ID chat yang baru dibuat
//   }

//   // Pastikan chatId sudah terisi sebelum navigasi
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ChatScreen(conversationId: chatId), // Pastikan chatId sudah terisi
//     ),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Users")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('users').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

//           var users = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               var userData = users[index];
//               String userId = userData.id;
//               String userEmail = userData['email'];

//               // Jangan tampilkan diri sendiri dalam daftar
//               if (userId == currentUser?.uid) return Container();

//               return ListTile(
//                 leading: Icon(Icons.person, color: Colors.blue),
//                 title: Text(userEmail),
//                 trailing: Icon(Icons.chat, color: Colors.green),
//                 onTap: () => startChat(userId, userEmail),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
