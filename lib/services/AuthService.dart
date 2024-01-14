import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tada/models/userModel.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

 //SignUp user
 Future<dynamic> signUpWithEmailAndPassword({required String email, required String password, required String userName}) async {
   try{

     ///Create user auth
     final result  =  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

     if(result.user != null){
       ///Create 'User' collection in Firestore like Json format to collect user info
       CollectionReference reference = FirebaseFirestore.instance.collection('Users');
       User? user  = FirebaseAuth.instance.currentUser;
       String? uid = user!.uid;
       if(uid != null){
         UserModel userModel = UserModel(userName: userName, email: email, password: password, userUID: uid, profilePhoto: '', onboardingShow: true);
         await reference.doc(uid).set(userModel.toJson());
         return [true];
       }
     }
   } on FirebaseAuthException catch(e){
     return [false, e.message];
   }
 }

 //SignIn user
Future<dynamic> signInWithEmailAndPassword({required String email, required String passwrod}) async {
   try{
     final result  =  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: passwrod);
     if(result.user  != null){
       return [true];
     }
   }on FirebaseAuthException catch(e){
     return [false, e.message];
   }
}

}