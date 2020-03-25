import 'package:flutter/material.dart';
import 'package:hw_4/src/controllers/auth/auth_controller.dart';
import 'package:hw_4/src/assets/fonts/custom_icons.dart';

Widget authProvidersBar({ AuthController controller, BuildContext context }) {
  final ThemeData currentTheme = Theme.of(context);

  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Padding(
            child: Text('Sign with', style: TextStyle(color: currentTheme.primaryColor)),
            padding: EdgeInsets.all(10),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      Row(
        children: <Widget>[
          Padding(
            child: Container(
              child: MaterialButton(
                onPressed: controller.signInWithGoogle,
                color: Colors.blue,
                textColor: currentTheme.primaryColor,
                child: Icon(
                  CustomIcons.google_1,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
          Padding(
            child: Container(
              child: MaterialButton(
                onPressed: controller.signInWithFacebook,
                color: Color(0xff2851a3),
                textColor: currentTheme.primaryColor,
                child: Icon(
                  CustomIcons.facebook,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ],
  );
}
