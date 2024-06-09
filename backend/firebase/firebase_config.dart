import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCU8DTyv7PLxy7-o_jCm1ZrOaLQWV7RZsA",
            authDomain: "finwallet-4c389.firebaseapp.com",
            projectId: "finwallet-4c389",
            storageBucket: "finwallet-4c389.appspot.com",
            messagingSenderId: "718484584494",
            appId: "1:718484584494:web:b21ecae1de3582c6d0c7bf",
            measurementId: "G-K6ZY0YXC5Z"));
  } else {
    await Firebase.initializeApp();
  }
}
