import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/firebase_options.dart';
import 'package:my_notes/views/login_view.dart';
import 'package:my_notes/views/register_view.dart';
import 'package:my_notes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 16, 149, 111)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/notes/': (context) => const NotesView()
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

//main UI
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                      (route) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Enter your note',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('notes-flutter-course-lll')
                  .add({
                'note': _notesController.text,
                'timestamp': FieldValue.serverTimestamp(),
              });
              setState(() {
                _notesController.clear();
              });
            },
            child: const Text('Save Note'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notes-flutter-course-lll')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds =
                        snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                    return Dismissible(
                      key: Key(ds.id), // Unique key for Dismissible widget
                      onDismissed: (direction) async {
                        // Delete the document from Firestore
                        await FirebaseFirestore.instance
                            .collection('notes-flutter-course-lll')
                            .doc(ds.id)
                            .delete();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.shade100,
                              blurRadius: 5.0,
                              spreadRadius: 5.0,
                              offset: const Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(ds['note']),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//drop down menu
Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Sign out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
