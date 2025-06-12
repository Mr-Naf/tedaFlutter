import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/bottomnav.dart';
import 'package:my_flutter_app/pages/login.dart';
import 'package:my_flutter_app/services/database.dart';
import 'package:my_flutter_app/services/shared_pref.dart';
import 'package:my_flutter_app/widget/support_widget.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, password, Phone, Addres;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController Addresscontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 54, 80, 167),
            content: Text(
              "Succsesfully Registerd",
              style: TextStyle(
                fontSize: 20.0,
              ),
            )));
        String Id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserImage(
            "https://lshubwales.com/sites/default/files/2024-07/Silhouette%20of%20person_3_1.png");
        await SharedPreferenceHelper().saveUserPhone(phonecontroller.text);
        await SharedPreferenceHelper().saveUserAddress(Addresscontroller.text);
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "id": Id,
          "image":
              "https://lshubwales.com/sites/default/files/2024-07/Silhouette%20of%20person_3_1.png",
          "Phone": phonecontroller.text,
          "Address": Addresscontroller.text
        };
        await databaseMethods().addUserDetails(userInfoMap, Id);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottomnav()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak_Password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 54, 80, 167),
              content: Text(
                "Password is to weak",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )));
        } else if (e.code == 'Email-Already-in-Used') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 54, 80, 167),
              content: Text(
                "Account Already exists",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(top: 80, bottom: 10),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "images/sign.jpg",
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "Sign Up",
                      style: AppWidget.boldTextFeildStyle().copyWith(
                        fontSize: 28,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Name",
                    style: AppWidget.semiBoldTextFeildStyle()
                        .copyWith(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xfff9fafc),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your Name",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Email",
                    style: AppWidget.semiBoldTextFeildStyle()
                        .copyWith(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xfff9fafc),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                      controller: mailcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your Email",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Password",
                    style: AppWidget.semiBoldTextFeildStyle()
                        .copyWith(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xfff9fafc),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your Password",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 25),
//phone
                  Text(
                    "Phone Number",
                    style: AppWidget.semiBoldTextFeildStyle()
                        .copyWith(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xfff9fafc),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        }
                        return null;
                      },
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your Phone Number",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 25),
//address
                  Text(
                    "Address",
                    style: AppWidget.semiBoldTextFeildStyle()
                        .copyWith(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xfff9fafc),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Address';
                        }
                        return null;
                      },
                      controller: Addresscontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your Address",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),

                  SizedBox(height: 35),
                  Center(
                    child: Material(
                      color: Color(0xFFfd6f3e),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              name = namecontroller.text;
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                              Phone = phonecontroller.text;
                              Addres = Addresscontroller.text;
                            });
                            registration();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do You Have an Account? ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
