import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pppl_apps/components/navbar.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/services/firebase/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> validateDataForm = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool visibilityButton = true;
  bool isDataCheck = false;

  void visibilityPass() {
    setState(() {
      visibilityButton = !visibilityButton;
    });
  }

  // FUNCTION UNTUK MEMVALIDASI USERNAME DAN PASSWORD
  Future validateSubmitForm() async {
    if (validateDataForm.currentState!.validate()) {
      setState(() {
        isDataCheck = false;
      });
    }
    try {
      await authService.signInWithEmailAndPassword(
          usernameController.text, passController.text);
      Get.off(const NavBar());
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                "Login Failed",
                style: boldComponentFonts,
              ),
              content: Column(
                children: [
                  const Divider(
                    color: Colors.black,
                  ),
                  Text(
                    "Silahkan Masukkan Data E-mail dan Password dengan Benar",
                    style: universalFonts,
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: validateDataForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: universalColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 90,
                              ),

                              // BASE INPUT USERNAME
                              TextFormField(
                                controller: usernameController,
                                keyboardType: TextInputType.emailAddress,
                                style: universalFonts,
                                decoration: InputDecoration(
                                    hintText: 'username',
                                    hintStyle: GoogleFonts.lato(
                                        fontSize: 15, color: Colors.grey),
                                    prefixIcon: const Icon(
                                        CupertinoIcons.person_crop_circle),
                                    prefixIconColor: Colors.grey,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    )),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Harap mengisikan username';
                                  }
                                  RegExp emailFormat = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (emailFormat.hasMatch(value)) {
                                    return null;
                                  }
                                  return 'Harap masukkan e-mail sesuai format';
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              // BASE INPUT PASSWORD
                              TextFormField(
                                controller: passController,
                                obscureText: visibilityButton,
                                style: universalFonts,
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: GoogleFonts.lato(
                                        fontSize: 15, color: Colors.grey),
                                    prefixIcon: const Icon(Icons.lock),
                                    prefixIconColor: Colors.grey,
                                    suffixIcon: GestureDetector(
                                      child: visibilityButton == true
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                      onTap: () {
                                        visibilityPass();
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    )),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Harap mengisikan password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              ),

                              // BUTTON LOGIN
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: componentColors,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 50),
                                    child: Text(
                                      "LOGIN",
                                      style: whiteBoldComponentFonts,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  validateSubmitForm();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AspectRatio(
                    aspectRatio: 16 / 6, child: Image.asset("assets/logo.png"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
