// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'customer.dart';
// // // import 'contracter.dart';
// // // import 'register.dart';

// // // class LoginPage extends StatefulWidget {
// // //   const LoginPage({super.key});

// // //   @override
// // //   _LoginPageState createState() => _LoginPageState();
// // // }

// // // class _LoginPageState extends State<LoginPage> {
// // //   final _auth = FirebaseAuth.instance;
// // //   final _formKey = GlobalKey<FormState>();
// // //   final TextEditingController emailController = TextEditingController();
// // //   final TextEditingController passwordController = TextEditingController();
// // //   bool _isPasswordVisible = true;
// // //   bool isLoading = false;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: <Widget>[
// // //             _buildLoginForm(context),
// // //             _buildFooter(context),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildLoginForm(BuildContext context) {
// // //     return Container(
// // //       color: Color.fromARGB(255, 192, 239, 240),
// // //       width: MediaQuery.of(context).size.width,
// // //       height: MediaQuery.of(context).size.height * 0.70,
// // //       child: Center(
// // //         child: Container(
// // //           margin: const EdgeInsets.all(12),
// // //           child: Form(
// // //             key: _formKey,
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               crossAxisAlignment: CrossAxisAlignment.center,
// // //               children: [
// // //                 const SizedBox(height: 30),
// // //                 const Text(
// // //                   "Login",
// // //                   style: TextStyle(
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                     fontSize: 40,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 20),
// // //                 _buildEmailField(),
// // //                 const SizedBox(height: 20),
// // //                 _buildPasswordField(),
// // //                 const SizedBox(height: 20),
// // //                 _buildLoginButton(),
// // //                 const SizedBox(height: 10),
// // //                 if (isLoading)
// // //                   const CircularProgressIndicator(
// // //                     color: Colors.white,
// // //                   ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildEmailField() {
// // //     return TextFormField(
// // //       controller: emailController,
// // //       decoration: InputDecoration(
// // //         filled: true,
// // //         fillColor: Colors.white,
// // //         hintText: 'Email',
// // //         contentPadding:
// // //             const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
// // //         focusedBorder: OutlineInputBorder(
// // //           borderSide: const BorderSide(color: Colors.white),
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //         enabledBorder: OutlineInputBorder(
// // //           borderSide: const BorderSide(color: Colors.white),
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //       ),
// // //       validator: (value) {
// // //         if (value!.isEmpty) {
// // //           return "Email cannot be empty";
// // //         }
// // //         if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$")
// // //             .hasMatch(value)) {
// // //           return "Please enter a valid email";
// // //         }
// // //         return null;
// // //       },
// // //       keyboardType: TextInputType.emailAddress,
// // //     );
// // //   }

// // //   Widget _buildPasswordField() {
// // //     return TextFormField(
// // //       controller: passwordController,
// // //       obscureText: _isPasswordVisible,
// // //       decoration: InputDecoration(
// // //         suffixIcon: IconButton(
// // //           icon: Icon(
// // //             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
// // //           ),
// // //           onPressed: () {
// // //             setState(() {
// // //               _isPasswordVisible = !_isPasswordVisible;
// // //             });
// // //           },
// // //         ),
// // //         filled: true,
// // //         fillColor: Colors.white,
// // //         hintText: 'Password',
// // //         contentPadding:
// // //             const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
// // //         focusedBorder: OutlineInputBorder(
// // //           borderSide: const BorderSide(color: Colors.white),
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //         enabledBorder: OutlineInputBorder(
// // //           borderSide: const BorderSide(color: Colors.white),
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //       ),
// // //       validator: (value) {
// // //         if (value!.isEmpty) {
// // //           return "Password cannot be empty";
// // //         }
// // //         if (value.length < 6) {
// // //           return "Password must be at least 6 characters long";
// // //         }
// // //         return null;
// // //       },
// // //     );
// // //   }

// // //   Widget _buildLoginButton() {
// // //     return MaterialButton(
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// // //       elevation: 5.0,
// // //       height: 40,
// // //       onPressed: () {
// // //         setState(() {
// // //           isLoading = true;
// // //         });
// // //         signIn(emailController.text, passwordController.text);
// // //       },
// // //       color: Colors.white,
// // //       child: const Text(
// // //         "Login",
// // //         style: TextStyle(fontSize: 20),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFooter(BuildContext context) {
// // //     return Container(
// // //       color: Colors.white,
// // //       width: MediaQuery.of(context).size.width,
// // //       child: Center(
// // //         child: Column(
// // //           children: [
// // //             const SizedBox(height: 20),
// // //             MaterialButton(
// // //               shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(20.0)),
// // //               elevation: 5.0,
// // //               height: 40,
// // //               onPressed: () {
// // //                 Navigator.pushReplacement(
// // //                   context,
// // //                   MaterialPageRoute(builder: (context) => const Register()),
// // //                 );
// // //               },
// // //               color: Colors.blue[900],
// // //               child: const Text(
// // //                 "Register Now",
// // //                 style: TextStyle(color: Colors.white, fontSize: 20),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 15),
            
// // //             const SizedBox(height: 5),
         
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }



// // //   Future<void> signIn(String email, String password) async {
// // //     if (_formKey.currentState!.validate()) {
// // //       try {
// // //         await _auth.signInWithEmailAndPassword(
// // //           email: email,
// // //           password: password,

// // //         );
// // //         routeUser();
// // //       } on FirebaseAuthException catch (e) {
// // //         setState(() {
// // //           isLoading = false;
// // //         });
// // //         _showError(e);
// // //       }
// // //     }
// // //   }

// // //   void routeUser() async {
// // //     User? user = _auth.currentUser;
// // //     if (user != null) {
// // //       var documentSnapshot = await FirebaseFirestore.instance
// // //           .collection('users')
// // //           .doc(user.uid)
// // //           .get();

// // //       if (documentSnapshot.exists) {
// // //         String role = documentSnapshot.get('role');
// // //         if (role == "Contracter") {
// // //           Navigator.pushReplacement(context,
// // //               MaterialPageRoute(builder: (context) => const Contracter()));
// // //         } else {
// // //           Navigator.pushReplacement(context,
// // //               MaterialPageRoute(builder: (context) => const Customer()));
// // //         }
// // //       }
// // //     }
// // //   }

// // //   void _showError(FirebaseAuthException e) {
// // //     String errorMessage = 'An error occurred';
// // //     if (e.code == 'user-not-found') {
// // //       errorMessage = 'No user found for that email.';
// // //     } else if (e.code == 'wrong-password') {
// // //       errorMessage = 'Wrong password provided.';
// // //     }
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text(errorMessage)),
// // //     );
// // //   }
// // // }


// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'customer.dart';
// // import 'contracter.dart';
// // import 'register.dart';

// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});

// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final _auth = FirebaseAuth.instance;
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   bool _isPasswordVisible = true;
// //   bool isLoading = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: <Widget>[
// //             _buildLoginForm(context),
// //             _buildFooter(context),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLoginForm(BuildContext context) {
// //     return Container(
// //       color: Color.fromARGB(255, 192, 239, 240),
// //       width: MediaQuery.of(context).size.width,
// //       height: MediaQuery.of(context).size.height * 0.70,
// //       child: Center(
// //         child: Container(
// //           margin: const EdgeInsets.all(12),
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 const SizedBox(height: 30),
// //                 const Text(
// //                   "Login",
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                     fontSize: 40,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 _buildEmailField(),
// //                 const SizedBox(height: 20),
// //                 _buildPasswordField(),
// //                 const SizedBox(height: 20),
// //                 _buildLoginButton(),
// //                 const SizedBox(height: 10),
// //                 if (isLoading)
// //                   const CircularProgressIndicator(
// //                     color: Colors.white,
// //                   ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildEmailField() {
// //     return TextFormField(
// //       controller: emailController,
// //       decoration: InputDecoration(
// //         filled: true,
// //         fillColor: Colors.white,
// //         hintText: 'Email',
// //         contentPadding:
// //             const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
// //         focusedBorder: OutlineInputBorder(
// //           borderSide: const BorderSide(color: Colors.white),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderSide: const BorderSide(color: Colors.white),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //       ),
// //       validator: (value) {
// //         if (value!.isEmpty) {
// //           return "Email cannot be empty";
// //         }
// //         if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$")
// //             .hasMatch(value)) {
// //           return "Please enter a valid email";
// //         }
// //         return null;
// //       },
// //       keyboardType: TextInputType.emailAddress,
// //     );
// //   }

// //   Widget _buildPasswordField() {
// //     return TextFormField(
// //       controller: passwordController,
// //       obscureText: _isPasswordVisible,
// //       decoration: InputDecoration(
// //         suffixIcon: IconButton(
// //           icon: Icon(
// //             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
// //           ),
// //           onPressed: () {
// //             setState(() {
// //               _isPasswordVisible = !_isPasswordVisible;
// //             });
// //           },
// //         ),
// //         filled: true,
// //         fillColor: Colors.white,
// //         hintText: 'Password',
// //         contentPadding:
// //             const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
// //         focusedBorder: OutlineInputBorder(
// //           borderSide: const BorderSide(color: Colors.white),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderSide: const BorderSide(color: Colors.white),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //       ),
// //       validator: (value) {
// //         if (value!.isEmpty) {
// //           return "Password cannot be empty";
// //         }
// //         if (value.length < 6) {
// //           return "Password must be at least 6 characters long";
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   Widget _buildLoginButton() {
// //     return MaterialButton(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// //       elevation: 5.0,
// //       height: 40,
// //       onPressed: () {
// //         setState(() {
// //           isLoading = true;
// //         });
// //         signIn(emailController.text, passwordController.text);
// //       },
// //       color: Colors.white,
// //       child: const Text(
// //         "Login",
// //         style: TextStyle(fontSize: 20),
// //       ),
// //     );
// //   }

// //   Widget _buildFooter(BuildContext context) {
// //     return Container(
// //       color: Colors.white,
// //       width: MediaQuery.of(context).size.width,
// //       child: Center(
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 20),
// //             MaterialButton(
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(20.0)),
// //               elevation: 5.0,
// //               height: 40,
// //               onPressed: () {
// //                 Navigator.pushReplacement(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => const Register()),
// //                 );
// //               },
// //               color: Colors.blue[900],
// //               child: const Text(
// //                 "Register Now",
// //                 style: TextStyle(color: Colors.white, fontSize: 20),
// //               ),
// //             ),
// //             const SizedBox(height: 15),
            
// //             const SizedBox(height: 5),
         
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> signIn(String email, String password) async {
// //     if (_formKey.currentState!.validate()) {
// //       try {
// //         await _auth.signInWithEmailAndPassword(
// //           email: email,
// //           password: password,
// //         );
// //         routeUser();
// //       } on FirebaseAuthException catch (e) {
// //         setState(() {
// //           isLoading = false;
// //         });
// //         _showError(e);
// //       }
// //     }
// //   }

// //   void routeUser() async {
// //     User? user = _auth.currentUser;
// //     if (user != null) {
// //       var documentSnapshot = await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(user.uid)
// //           .get();

// //       if (documentSnapshot.exists) {
// //         String role = documentSnapshot.get('role');
// //         // Add more fields: username, age, gender, city, pincode
// //         String username = documentSnapshot.get('username') ?? 'N/A';
// //         String age = documentSnapshot.get('age') ?? 'N/A';
// //         String gender = documentSnapshot.get('gender') ?? 'N/A';
// //         String city = documentSnapshot.get('city') ?? 'N/A';
// //         String pincode = documentSnapshot.get('pincode') ?? 'N/A';

// //         // Navigate based on the role
// //         if (role == "Contracter") {
// //           Navigator.pushReplacement(context,
// //               MaterialPageRoute(builder: (context) => const Contracter()));
// //         } else {
// //           Navigator.pushReplacement(context,
// //               MaterialPageRoute(builder: (context) => const Customer()));
// //         }
// //       }
// //     }
// //   }

// //   void _showError(FirebaseAuthException e) {
// //     String errorMessage = 'An error occurred';
// //     if (e.code == 'user-not-found') {
// //       errorMessage = 'No user found for that email.';
// //     } else if (e.code == 'wrong-password') {
// //       errorMessage = 'Wrong password provided.';
// //     }
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(errorMessage)),
// //     );
// //   }
// // }


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'customer.dart';
// import 'contracter.dart';
// import 'register.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _auth = FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isPasswordVisible = true;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             _buildLoginForm(context),
//             _buildFooter(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoginForm(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 192, 239, 240),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.70,
//       child: Center(
//         child: Container(
//           margin: const EdgeInsets.all(12),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 30),
//                 const Text(
//                   "Login",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildEmailField(),
//                 const SizedBox(height: 20),
//                 _buildPasswordField(),
//                 const SizedBox(height: 20),
//                 _buildLoginButton(),
//                 const SizedBox(height: 10),
//                 if (isLoading)
//                   const CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailField() {
//     return TextFormField(
//       controller: emailController,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: 'Email',
//         contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "Email cannot be empty";
//         }
//         if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$").hasMatch(value)) {
//           return "Please enter a valid email";
//         }
//         return null;
//       },
//       keyboardType: TextInputType.emailAddress,
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: passwordController,
//       obscureText: _isPasswordVisible,
//       decoration: InputDecoration(
//         suffixIcon: IconButton(
//           icon: Icon(
//             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//           ),
//           onPressed: () {
//             setState(() {
//               _isPasswordVisible = !_isPasswordVisible;
//             });
//           },
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         hintText: 'Password',
//         contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "Password cannot be empty";
//         }
//         if (value.length < 6) {
//           return "Password must be at least 6 characters long";
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildLoginButton() {
//     return MaterialButton(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       elevation: 5.0,
//       height: 40,
//       onPressed: () {
//         setState(() {
//           isLoading = true;
//         });
//         signIn(emailController.text, passwordController.text);
//       },
//       color: Colors.white,
//       child: const Text(
//         "Login",
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Widget _buildFooter(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.of(context).size.width,
//       child: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             MaterialButton(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//               elevation: 5.0,
//               height: 40,
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Register()),
//                 );
//               },
//               color: Colors.blue[900],
//               child: const Text(
//                 "Register Now",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> signIn(String email, String password) async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await _auth.signInWithEmailAndPassword(email: email, password: password);
//         routeUser();
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           isLoading = false;
//         });
//         _showError(e);
//       }
//     }
//   }

//   void routeUser() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       var documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

//       if (documentSnapshot.exists) {
//         String role = documentSnapshot.get('role');
//         String username = documentSnapshot.get('username') ?? 'N/A';
//         String age = documentSnapshot.get('age') ?? 'N/A';
//         String gender = documentSnapshot.get('gender') ?? 'N/A';
//         String city = documentSnapshot.get('city') ?? 'N/A';
//         String pincode = documentSnapshot.get('pincode') ?? 'N/A';

//         // Navigate based on the role
//         if (role == "Contracter") {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Contracter()));
//         } else {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Customer()));
//         }
//       }
//     }
//   }

//   void _showError(FirebaseAuthException e) {
//     String errorMessage = 'An error occurred';
//     if (e.code == 'user-not-found') {
//       errorMessage = 'No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       errorMessage = 'Wrong password provided.';
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(errorMessage)),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer.dart';
import 'contracter.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildLoginForm(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 192, 239, 240),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(emailController, "Email", TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 10),
                if (isLoading)
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Register()),
          );
        },
        child: const Text(
          "Don't have an account? Register here!",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, TextInputType inputType) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: inputType,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText cannot be empty";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _isPasswordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Password',
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Password cannot be empty";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters long";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5.0,
      height: 40,
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        login(emailController.text, passwordController.text);
      },
      color: Colors.white,
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = userCredential.user;

        if (user != null) {
          DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          String role = doc['role'];

          if (role == 'Customer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Customer()),
            );
          } else if (role == 'Contracter') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Contracter()),
            );
          } else {
            print("Unknown role");
          }
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
