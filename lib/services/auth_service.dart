import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models//user.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthService {
  Future<UserCredential?> login(String email, String password) async {
    final userCredentials = await _firebase.signInWithEmailAndPassword(
        email: email, password: password);
    print("reching here");
    print(userCredentials);
    return userCredentials;
  }

  void signup(String email, String password, File? selectedImage) async {
    final DatabaseReference dbref = FirebaseDatabase.instance.ref();

    final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${userCredentials.user!.uid}.jpg');
    await storageRef.putFile(selectedImage!);
    final imageUrl = await storageRef.getDownloadURL();

    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    UdharUser userDetails = UdharUser(
        uid: currentUser,
        email: email,
        phone: "",
        udharScore: 0,
        credit: 0,
        debit: 0,
        imageURL: imageUrl);

    // Convert user object to JSON
    Map<String, dynamic> userData = userDetails.toJson();

    // Write user details to the database
    await dbref.child('users').child(currentUser).set(userData);
    //  firebase.database().ref('users/' + user.uid).set(user).catch(error => {
    //     console.log(error.message)
    // });

    print('User details stored successfully');
  }
}
