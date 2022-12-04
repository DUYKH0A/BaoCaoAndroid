import 'package:shopee/layout/screen_layout.dart';
import 'package:shopee/model/product_model.dart';
import 'package:shopee/providers/user_details_provider.dart';
import 'package:shopee/screens/product_screen.dart';
import 'package:shopee/screens/results_screen.dart';
import 'package:shopee/screens/sell_screen.dart';
import 'package:shopee/screens/sign_in_screen.dart';
import 'package:shopee/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:_flutterfire_internals/_flutterfire_internals.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
        apiKey: "AIzaSyApKlUzO2qUHV-fxRZ9nVpNA5ZGZMTgDb4",
        authDomain: "shopee-84c1c.firebaseapp.com",
        projectId: "shopee-84c1c",
        storageBucket: "shopee-84c1c.appspot.com",
        messagingSenderId: "555686692385",
        appId: "1:555686692385:web:b5695f1d33ca7330b58560",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: "Amazon Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
                //return const SellScreen();
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}
