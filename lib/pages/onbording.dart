//Trendy Elegant Designer Apparel

import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/login.dart';

class onbording extends StatefulWidget {
  const onbording({super.key});

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60.0),

            // Big Image (kept original)
            Expanded(
              flex: 4,
              child: Image.asset(
                "images/adminlogo.png",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 30.0),

            // Onboarding Text
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Explore\nThe Best\nProduct",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),

            Spacer(),

            // Next Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogIn()),
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 18.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
