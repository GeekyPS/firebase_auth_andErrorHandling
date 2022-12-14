import 'splash_sign_up.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routename = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var _passwordvisble = false;
  // ignore: unused_field
  Country? _selectedCountry;
  var code = '+91';
  var _isLoading = false;
  bool _isChecked = false;
  String _email = '', _password = '';
  final auth = FirebaseAuth.instance;
  var _colori = const Color.fromARGB(223, 138, 137, 137);
  String errorMessage = "";
  var _isError = false;

  void function() async {
    try {
      setState(() {
        _isLoading = true;
        _isError = false;
      });
      await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
  

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(SplashSignup.routename);
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message ?? 'Something went Wrong!';
      showError();
    }
  }

  void showError() {
    setState(() {
      _isError = true;
    });
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              title: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          );
        });
  }

  void function2() {
    setState(() {
      _colori = Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    final appbar = AppBar(
      centerTitle: true,
      title: Text(
        'KhataBook',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
      ),
    );
    final availableHeight = mediaquery.size.height -
        appbar.preferredSize.height -
        mediaquery.padding.top;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: appbar,
          body: SizedBox(
            height: availableHeight,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: availableHeight * 0.06,
                        ),
                        Text(
                          'Create Account!',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: mediaquery.size.width * 0.040,
                            ),
                            Text(
                              'Email Address',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: availableHeight * 0.01,
                        ),
                        SizedBox(
                          width: mediaquery.size.width * 0.95,
                          child: TextFormField(
                            validator: validateEmail,
                            onChanged: (value) {
                              _email = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(140, 142, 151, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(224, 224, 224, 224),
                                        width: 1))),
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: mediaquery.size.width * 0.040,
                            ),
                            Text(
                              'Mobile Number',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: availableHeight * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: mediaquery.size.width * 0.025,
                            ),
                            SizedBox(
                              width: mediaquery.size.width * 0.15,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft:
                                                    Radius.circular(8))))),
                                onPressed: () async {
                                  final country = await showCountryPickerDialog(
                                    context,
                                  );
                                  if (country != null) {
                                    setState(() {
                                      _selectedCountry = country;
                                    });
                                  }
                                  if (country != null) {
                                    code = country.callingCode;
                                  }
                                },
                                child: SizedBox(
                                  height: 60.5,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      child: FittedBox(
                                        child: Text(
                                          code,
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromRGBO(
                                                140, 142, 151, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: mediaquery.size.width * 0.80,
                              child: TextFormField(
                                validator: validateNumber,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                cursorColor:
                                    const Color.fromRGBO(140, 142, 151, 1),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    hintText: 'Enter your mobile number',
                                    hintStyle: GoogleFonts.poppins(
                                      color: const Color.fromRGBO(
                                          140, 142, 151, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                224, 224, 224, 224),
                                            width: 1))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: availableHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: mediaquery.size.width * 0.040,
                            ),
                            Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: availableHeight * 0.01,
                        ),
                        SizedBox(
                          width: mediaquery.size.width * 0.95,
                          child: TextFormField(
                            validator: validatePassword,
                            onChanged: (value) => {_password = value},
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_passwordvisble,
                            cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  splashColor:
                                      const Color.fromARGB(224, 224, 224, 224),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  onTap: () {
                                    setState(() {
                                      _passwordvisble = !_passwordvisble;
                                    });
                                  },
                                  child: _passwordvisble
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                ),
                                hintText: 'Enter your password',
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(140, 142, 151, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(224, 224, 224, 224),
                                        width: 1))),
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.01,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                side: BorderSide(color: _colori),
                                value: _isChecked,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                activeColor: Colors.transparent,
                                checkColor:
                                    const Color.fromARGB(223, 138, 137, 137),
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                    if (_isChecked) {
                                      _colori = const Color.fromARGB(
                                          223, 138, 137, 137);
                                    }
                                  });
                                }),
                            Text(
                              'I agree to the terms and conditions',
                              style: GoogleFonts.poppins(
                                color: _colori,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              _isChecked ? function() : function2();
                            }
                          },
                          child: Ink(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(105, 92, 212, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            height: 48,
                            width: mediaquery.size.width * 0.95,
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.011,
                        ),
                        Text(
                          'or continue with',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(140, 142, 151, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.011,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: mediaquery.size.width * 0.04,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: mediaquery.size.width * 0.03),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))))),
                                onPressed: () {},
                                child: SizedBox(
                                  height: availableHeight * 0.07,
                                  width: mediaquery.size.width * 0.32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/apple.png',
                                        height: 24.0,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Apple',
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromRGBO(
                                              140, 142, 151, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                                margin: EdgeInsets.only(
                                    left: mediaquery.size.width * 0.03),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))))),
                                  onPressed: () {},
                                  child: SizedBox(
                                    height: availableHeight * 0.07,
                                    width: mediaquery.size.width * 0.32,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/google.png',
                                          height: 24.0,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Google',
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromRGBO(
                                                140, 142, 151, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: mediaquery.size.width * 0.04,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: availableHeight * 0.10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(140, 142, 151, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                  text: 'Login',
                                  style: GoogleFonts.poppins(
                                    color:
                                        const Color.fromRGBO(105, 92, 212, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Navigator.of(context).pop()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.05,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading && !_isError)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
