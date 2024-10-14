
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static AuthService authService = AuthService();


  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createAccount(String email , String password)async{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential.user!.email);
  }
}