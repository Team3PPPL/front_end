import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pppl_apps/components/navbar.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
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
            return AlertDialog(
              title: Column(
                children: [
                  LottieBuilder.network(
                    width: MediaQuery.of(context).size.width / 10,
                    "https://lottie.host/5b55eb2b-b879-4a22-b89f-f06321908aea/U0J6YE0rj1.json",
                    repeat: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Login Failed",
                    style: titleFonts,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
              content: Text(
                "Silahkan Masukkan username dan password dengan Benar",
                style: universalFonts,
                textAlign: TextAlign.center,
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
        ),
        body: Container(
          color: universalColors,
          width: double.infinity,
          child: ListView(
            children: [
              // BASE CONTAINER PENYAMBUT APLIKASI
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // BASE WELCOME MESSAGE
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back, ",
                            style: GoogleFonts.lato(
                                color: componentColors,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rosniah",
                            style: GoogleFonts.lato(
                                color: componentColors,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),

                      // LOGO APLIKASI
                      Image.asset(
                        "assets/logo.png",
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width / 4,
                      )
                    ],
                  ),
                ),
              ),

              // BASE CONTAINER LOGIN FORM
              Container(
                color: Colors.white,
                child: Container(
                  decoration: const BoxDecoration(
                      color: universalColors,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(80))),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Form(
                        key: validateDataForm,
                        child: Column(
                          children: [
                            // NAMA APLIKASI
                            Text(
                              "TANSYITUL FINANSIAL MANAGEMENT",
                              style: GoogleFonts.lato(
                                  color: componentColors,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              color: componentColors,
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // BASE FORM USERNAME
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
                                RegExp emailFormat =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (emailFormat.hasMatch(value)) {
                                  return null;
                                }
                                return 'Harap masukkan e-mail sesuai format';
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // BASE FORM PASSWORD
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
                              height: 70,
                            ),

                            // BUTTON LOGIN
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: componentColors,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 35),
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
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
