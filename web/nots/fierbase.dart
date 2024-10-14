import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload Notes to Firestore
  Future<void> uploadNotes(List<Map<String, dynamic>> notes) async {
    String userId = _auth.currentUser!.uid;
    for (var note in notes) {
      await _firestore.collection('users').doc(userId).collection('notes').add(note);
    }
  }

  // Fetch Notes from Firestore
  Future<List<Map<String, dynamic>>> fetchNotes() async {
    String userId = _auth.currentUser!.uid;
    QuerySnapshot snapshot = await _firestore.collection('users').doc(userId).collection('notes').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}