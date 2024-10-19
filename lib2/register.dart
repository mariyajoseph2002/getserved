

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'login.dart';

// // class Register extends StatefulWidget {
// //   const Register({super.key});

// //   @override
// //   _RegisterState createState() => _RegisterState();
// // }

// // class _RegisterState extends State<Register> {
// //   final _auth = FirebaseAuth.instance;
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController usernameController = TextEditingController();
// //   final TextEditingController roleController = TextEditingController();
// //   final TextEditingController ageController = TextEditingController();
// //   final TextEditingController genderController = TextEditingController();
// //   final TextEditingController cityController = TextEditingController();
// //   final TextEditingController pincodeController = TextEditingController();
// //   bool _isPasswordVisible = true;
// //   bool isLoading = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: <Widget>[
// //             _buildRegisterForm(context),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildRegisterForm(BuildContext context) {
// //     return Container(
// //       color: Color.fromARGB(255, 192, 239, 240),
// //       width: MediaQuery.of(context).size.width,
// //       height: MediaQuery.of(context).size.height * 0.80,
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
// //                   "Register",
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                     fontSize: 40,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(emailController, "Email", TextInputType.emailAddress),
// //                 const SizedBox(height: 20),
// //                 _buildPasswordField(),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(usernameController, "Username", TextInputType.text),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(roleController, "Role (Customer/Contracter)", TextInputType.text),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(ageController, "Age", TextInputType.number),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(genderController, "Gender", TextInputType.text),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(cityController, "City", TextInputType.text),
// //                 const SizedBox(height: 20),
// //                 _buildTextField(pincodeController, "Pincode", TextInputType.number),
// //                 const SizedBox(height: 20),
// //                 _buildRegisterButton(),
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

// //   Widget _buildTextField(TextEditingController controller, String hintText, TextInputType inputType) {
// //     return TextFormField(
// //       controller: controller,
// //       decoration: InputDecoration(
// //         filled: true,
// //         fillColor: Colors.white,
// //         hintText: hintText,
// //         contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
// //         focusedBorder: OutlineInputBorder(
// //           borderSide: const BorderSide(color: Colors.white),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderSide: const BorderSide(color: Colors.white),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //       ),
// //       keyboardType: inputType,
// //       validator: (value) {
// //         if (value!.isEmpty) {
// //           return "$hintText cannot be empty";
// //         }
// //         return null;
// //       },
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
// //         contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
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

// //   Widget _buildRegisterButton() {
// //     return MaterialButton(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// //       elevation: 5.0,
// //       height: 40,
// //       onPressed: () {
// //         setState(() {
// //           isLoading = true;
// //         });
// //         register(
// //           emailController.text,
// //           passwordController.text,
// //           usernameController.text,
// //           roleController.text,
// //           ageController.text,
// //           genderController.text,
// //           cityController.text,
// //           pincodeController.text,
// //         );
// //       },
// //       color: Colors.white,
// //       child: const Text(
// //         "Register",
// //         style: TextStyle(fontSize: 20),
// //       ),
// //     );
// //   }

// //   Future<void> register(String email, String password, String username, String role, String age, String gender, String city, String pincode) async {
// //     if (_formKey.currentState!.validate()) {
// //       try {
// //         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
// //           email: email,
// //           password: password,
// //         );

// //         User? user = userCredential.user;

// //         if (user != null) {
// //           await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
// //             'email': email,
// //             'username': username,
// //             'role': role,
// //             'age': age,
// //             'gender': gender,
// //             'city': city,
// //             'pincode': pincode,
// //             'created_at': Timestamp.now(),
// //           });

// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => const LoginPage()),
// //           );
// //         }
// //       } catch (e) {
// //         setState(() {
// //           isLoading = false;
// //         });
// //         print("Error: $e");
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Error: $e")),
// //         );
// //       }
// //     } else {
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }
// // }


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'login.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _auth = FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController roleController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
  
//   bool _isPasswordVisible = true;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             _buildRegisterForm(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRegisterForm(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 192, 239, 240),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.80,
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
//                   "Register",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildTextField(emailController, "Email", TextInputType.emailAddress),
//                 const SizedBox(height: 20),
//                 _buildPasswordField(),
//                 const SizedBox(height: 20),
//                 _buildTextField(usernameController, "Username", TextInputType.text),
//                 const SizedBox(height: 20),
//                 _buildTextField(roleController, "Role (Customer/Contracter)", TextInputType.text),
//                 const SizedBox(height: 20),
//                 _buildTextField(ageController, "Age", TextInputType.number),
//                 const SizedBox(height: 20),
//                 _buildTextField(genderController, "Gender", TextInputType.text),
//                 const SizedBox(height: 20),
//                 _buildTextField(cityController, "City", TextInputType.text),
//                 const SizedBox(height: 20),
//                 _buildTextField(pincodeController, "Pincode", TextInputType.number),
//                 const SizedBox(height: 20),
//                 _buildRegisterButton(),
//                 const SizedBox(height: 10),
//                 if (isLoading)
//                   const CircularProgressIndicator(color: Colors.white),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String hintText, TextInputType inputType) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: hintText,
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
//       keyboardType: inputType,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "$hintText cannot be empty";
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: passwordController,
//       obscureText: _isPasswordVisible,
//       decoration: InputDecoration(
//         suffixIcon: IconButton(
//           icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
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

//   Widget _buildRegisterButton() {
//     return MaterialButton(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       elevation: 5.0,
//       height: 40,
//       onPressed: () {
//         setState(() {
//           isLoading = true;
//         });
//         register(
//           emailController.text,
//           passwordController.text,
//           usernameController.text,
//           roleController.text,
//           ageController.text,
//           genderController.text,
//           cityController.text,
//           pincodeController.text,
//         );
//       },
//       color: Colors.white,
//       child: const Text(
//         "Register",
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Future<void> register(String email, String password, String username, String role, String age, String gender, String city, String pincode) async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );

//         User? user = userCredential.user;

//         if (user != null) {
//           await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//             'email': email,
//             'username': username,
//             'role': role,
//             'age': age,
//             'gender': gender,
//             'city': city,
//             'pincode': pincode,
//             'created_at': Timestamp.now(),
//           });

//           // Navigate to login page after successful registration
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const LoginPage()),
//           );
//         }
//       } catch (e) {
//         print("Error during registration: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: $e")),
//         );
//       } finally {
//         setState(() {
//           isLoading = false; // Stop loading regardless of success or failure
//         });
//       }
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  bool _isPasswordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildRegisterForm(context),
            const SizedBox(height: 20),
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerPage()),
                    );
                  },
                  child: const Text('View Customers'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContractorPage()),
                    );
                  },
                  child: const Text('View Contractors'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 192, 239, 240),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.80,
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
                  "Register",
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
                _buildTextField(usernameController, "Username", TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField(roleController, "Role (Customer/Contractor)", TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField(ageController, "Age", TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField(genderController, "Gender", TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField(cityController, "City", TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField(pincodeController, "Pincode", TextInputType.number),
                const SizedBox(height: 20),
                _buildRegisterButton(),
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

  Widget _buildRegisterButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5.0,
      height: 40,
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        register(
          emailController.text,
          passwordController.text,
          usernameController.text,
          roleController.text,
          ageController.text,
          genderController.text,
          cityController.text,
          pincodeController.text,
        );
      },
      color: Colors.white,
      child: const Text(
        "Register",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Future<void> register(String email, String password, String username, String role, String age, String gender, String city, String pincode) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': email,
            'username': username,
            'role': role,
            'age': age,
            'gender': gender,
            'city': city,
            'pincode': pincode,
            'created_at': Timestamp.now(),
          });

          // Navigate to login page after successful registration
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } catch (e) {
        print("Error during registration: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      } finally {
        setState(() {
          isLoading = false; // Stop loading regardless of success or failure
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the customer page
    final List<String> customers = List.generate(20, (index) => 'Customer ${index + 1}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(customers[index]),
            leading: const Icon(Icons.person),
            onTap: () {
              // Handle customer tap
            },
          );
        },
      ),
    );
  }
}

class ContractorPage extends StatelessWidget {
  const ContractorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the contractor page
    final List<String> contractors = List.generate(20, (index) => 'Contractor ${index + 1}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contractors'),
      ),
      body: ListView.builder(
        itemCount: contractors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contractors[index]),
            leading: const Icon(Icons.build),
            onTap: () {
              // Handle contractor tap
            },
          );
        },
      ),
    );
  }
}
