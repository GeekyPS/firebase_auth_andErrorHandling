
import 'package:confetti/confetti.dart';

import '../screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';


class SplashSignup extends StatefulWidget {
  const SplashSignup({super.key});

  static const routename = '/splashsign';

  @override
  State<SplashSignup> createState() => _SplashSignupState();
}

class _SplashSignupState extends State<SplashSignup> {
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.play();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          "Congratulations you've signed up for Khatabook ",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 3,
                          style: GoogleFonts.barlow(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          numberOfParticles: 200,
          gravity: 0.2,
          blastDirectionality: BlastDirectionality.explosive,
       
        )
      ],
    );
  }
}
