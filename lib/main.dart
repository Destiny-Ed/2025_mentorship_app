import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/firebase_options.dart';
import 'package:flutter_first_app/providers/authentication_provider.dart';
import 'package:flutter_first_app/providers/counter_provider.dart';
import 'package:flutter_first_app/views/api_fetch.dart';
import 'package:flutter_first_app/views/counter_screen.dart';
import 'package:flutter_first_app/views/firebase_auth/firebase_login.dart';
import 'package:flutter_first_app/views/note_screen.dart';
import 'package:flutter_first_app/views/scrollable_screen.dart';
import 'package:flutter_first_app/views/splash_screen.dart';
import 'package:flutter_first_app/views/textformfield_example.dart';
import 'package:flutter_first_app/views/user_input_example.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Profile Screen",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final provider = context.read<AuthenticationProvider>();
              await provider.logout();

              if (provider.status && context.mounted) {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => FirebaseLogin()), (_) => false);
              }
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser?.photoURL ?? "assets/user_dummy.png",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "FullName : ${FirebaseAuth.instance.currentUser?.displayName}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Email Address : ${FirebaseAuth.instance.currentUser?.emailVerified}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<CounterProvider>(builder: (context, counterState, _) {
                  return Text(
                    "Recent counter : ${counterState.counter}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    print("submit");
                  },
                  child: Text(
                    "Submit profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserInputExample()));
                  },
                  child: Text(
                    "Next Screen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollableScreen()));
                  },
                  child: Text(
                    "Scrollable Screen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TextformfieldExample()));
                  },
                  child: Text(
                    "Text form field",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CounterScreen()));
                  },
                  child: Text(
                    "Counter App",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ApiFetchScreen()));
                  },
                  child: Text(
                    "Api Fetch",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                  },
                  child: Text(
                    "Note app",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
