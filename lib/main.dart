import 'package:flutter/material.dart';
import 'screens/youtube_player_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/conversion_screen.dart';
import 'screens/phonebook_screen.dart';
import 'screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // Pastikan FirebaseOptions dikonfigurasi

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
  YoutubePlayerScreen(),
  CalculatorScreen(),
  ConversionScreen(),
  PhoneBookScreen(),
  ChatScreen(), // Tambahkan ChatScreen di sini
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,  // Warna background navbar
        selectedItemColor: Colors.blue,  // Warna item yang terpilih
        unselectedItemColor: Colors.grey,  // Warna item yang tidak terpilih
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'YouTube'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Convert'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Phonebook'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )

    );
  }
}