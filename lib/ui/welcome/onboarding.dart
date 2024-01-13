import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loafer/core/constant/color_constant.dart';
import 'package:loafer/ui/welcome/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: ColorConstant.purpleGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              "Loafer",
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                color: Colors.deepPurple.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Techlyverse chat app",
              textAlign: TextAlign.center,
              style: TextStyle(
                //color: Colors.white
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/icons/loafer.png",
                width: 200,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By continue i agree to",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 238, 231, 231),
                ),
                child: const Center(
                  child: Text("Continue"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
