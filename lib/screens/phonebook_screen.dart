import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneBookScreen(),
    );
  }
}

class PhoneBookScreen extends StatefulWidget {
  @override
  _PhoneBookScreenState createState() => _PhoneBookScreenState();
}

class _PhoneBookScreenState extends State<PhoneBookScreen> {
  List<Map<String, String>> _contacts = []; // Data kontak akan disimpan di sini

  void _addContact(String name, String phone) {
    setState(() {
      _contacts.add({'name': name, 'phone': phone});
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _editContact(int index, String name, String phone) {
    setState(() {
      _contacts[index] = {'name': name, 'phone': phone};
    });
  }

  void _showAddContactDialog() {
    String name = '';
    String phone = '';
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Tambah Kontak'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nama'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phone = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && phone.isNotEmpty) {
                  _addContact(name, phone);
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactDialog(int index) {
    String name = _contacts[index]['name']!;
    String phone = _contacts[index]['phone']!;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Edit Kontak'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: name),
                decoration: const InputDecoration(labelText: 'Nama'),
                onChanged: (value) => name = value,
              ),
              TextField(
                controller: TextEditingController(text: phone),
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phone = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && phone.isNotEmpty) {
                  _editContact(index, name, phone);
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Telepon'),
        backgroundColor: const Color.fromARGB(255, 5, 26, 43),
        centerTitle: true,
      ),
      body: _contacts.isEmpty
          ? const Center(child: Text('Tidak ada kontak'))
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    title: Text(contact['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(contact['phone']!, style: TextStyle(fontSize: 16, color: Colors.grey)),
                    trailing: Wrap(
                      spacing: 8, // Add spacing between icons
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditContactDialog(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteContact(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactDialog,
        child: const Icon(Icons.add),
        backgroundColor:  const Color.fromARGB(255, 5, 26, 43),
      ),
    );
  }
}
