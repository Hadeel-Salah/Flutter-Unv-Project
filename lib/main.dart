import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _auth = FirebaseAuth.instance;
class _HomeScreenState extends State<HomeScreen> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(email);
      debugPrint(password);

      /*
      Continute proccessing the provided information with your own logic
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Log In'),
      ),
      body: Container(
        padding: const EdgeInsets.all(2.0),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Image.asset(
              "assets/img.png",
              width: 80,
              height: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Eamil
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email address';
                              }
                              // Check if the entered email has the right format
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              // Return null if the entered email is valid
                              return null;
                            },
                            onChanged: (value) => email = value,
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          /// Password
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              if (value.trim().length < 8) {
                                return 'Password must be at least 8 characters in length';
                              }
                              // Return null if the entered password is valid
                              return null;
                            },
                            onChanged: (value) => password = value,
                          ),
                          const SizedBox(height: 20),
                          Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                                    if (user != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => SecondScreen(),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const Text('Log In'),
                              )),

                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
                                },
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = "";
  String userName = "";
  String password = "";
  bool showSpinner = false;

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');

      /*
      Continute proccessing the provided information with your own logic
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Sign Up'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Eamil
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                      onChanged: (value) => email = value,
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    /// username
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }
                        // Return null if the entered username is valid
                        return null;
                      },
                      onChanged: (value) => userName = value,
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    /// Password
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        // Return null if the entered password is valid
                        return null;
                      },
                      onChanged: (value) => password = value,
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    /// Confirm Password
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }

                        if (value != password) {
                          return 'Confimation password does not match the entered password';
                        }

                        return null;
                      },
                      onChanged: (value) => password = value,
                    ),
                    const SizedBox(height: 20),
                    Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                              if (newUser != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SecondScreen(),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: const Text('Sign up'),
                        )),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          child: const Text(
                            'Log in',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pop(context, new MaterialPageRoute(builder: (context) => new HomeScreen()));
                          },
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('All Categories'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
            ),
            Divider(
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text('Orders'),
            ),
            Divider(
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
            ),
            Divider(
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category'),
            ),
            Divider(
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(2.0),
        margin: EdgeInsets.symmetric(horizontal: 70 ,vertical: 20),
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SamsungScreen(
                                )));
                      },
                      icon: Image.asset('assets/samsung.jpg', width: 150, height: 150),
                      label: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new IphoneScreen(
                                )));
                      },
                      icon: Image.asset('assets/iphone.png', width: 150, height: 150),
                      label: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                Row(
                  children: <Widget>[
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new OppoScreen(
                                )));
                      },
                      icon: Image.asset('assets/oppo.jpg', width: 150, height: 150),
                      label: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new HuaweiScreen(
                                )));
                      },
                      icon: Image.asset('assets/huawei.png', width: 150, height: 150),
                      label: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new XiaomiScreen(
                                )));
                      },
                      icon: Image.asset('assets/xiaomi.png', width: 150, height: 150),
                      label: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new LenovoScreen(
                                )));
                      },
                      icon: Image.asset('assets/lenovo.png', width: 150, height: 150),
                      label: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}


class SamsungScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Samsung'),
      ),

      body:  Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("Slider 1: samsung a53",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a53.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a53 1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a53 2.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a53 3.jpg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
              Container(
                child: Text("Slider 2: samsung a71",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a71 1.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a71 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a71 3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a71 4.jpg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IphoneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Iphone'),
      ),

      body:  Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("Slider 1: iphone xs",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/iphone 1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/iphone 2.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/iphone 3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/iphone 4.jpg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
              Container(
                child: Text("Slider 2: iphone 13",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/13 1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/13 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/13 3.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/13 4.jpg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OppoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Oppo'),
      ),

      body:  Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("Slider 1: oppo x5 pro",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/oppo 1.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/oppo 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/oppo 3.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/oppo 4.webp', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
              Container(
                child: Text("Slider 2: oppo a3s",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a3s 1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a3s 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a3s 3.webp', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/a3s 4.webp', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HuaweiScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Huawei'),
      ),

      body:  Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("Slider 1: huawei p30 pro",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/huawei 1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/huawei 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/huawei3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/huawei4.jpeg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
              Container(
                child: Text("Slider 2: huawei y9",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/y9 1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/y9 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/y9 3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/y9 4.webp', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class XiaomiScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Xiaomi'),
      ),

      body:  Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("Slider 1: xiaomi redmi note 10 pro",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/xiaomi 1.png', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/xiaomi2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/xiaomi3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/xiaomi4.jpg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
              Container(
                child: Text("Slider 2: xiaomi note 5",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/note 5 1.jpeg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/note 5 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/note 5 3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/note 5 4.jpg', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LenovoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Lenovo'),
      ),

      body:  Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("Slider 1: lenovo legion y700",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/lenovo1.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/lenovo 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/lenovo 3.jpeg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/lenovo 4.webp', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
              Container(
                child: Text("Slider 2: lenovo tab 4",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/tab 4 1.jpeg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/tab 4 2.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/tab 4 3.jpg', width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/tab 4 4.webp', width: 150, height: 150),
                  )
                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}