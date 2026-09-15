import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign Up (ලියාපදිංචි වීම)
  Future<UserCredential?> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Firestore එකේ User Data Save කිරීම
      if (userCredential.user != null) {
        await _db.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': name,
          'email': email,
          'phone': phone,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error: ${e.message}");
      rethrow;
    }
  }

  // Sign In (ඇතුළු වීම)
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign In Error: ${e.message}");
      rethrow;
    }
  }

  // Sign Out (ඉවත් වීම)
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Current User ලබා ගැනීම
  User? get currentUser => _auth.currentUser;

  // Current User ගේ Firestore Data Stream එක ලබා ගැනීම
  Stream<DocumentSnapshot>? getUserDetails() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _db.collection('users').doc(user.uid).snapshots();
    }
    return null;
  }

  // Order එක Firestore හි 'orders' collection එකට save කර Cart එක clear කිරීම
  Future<void> placeOrder({
    required List<Map<String, dynamic>> cartItems,
    required double totalPrice,
  }) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // 1. Orders sub-collection එකට අලුත් order එකක් එකතු කිරීම
      await _db.collection('users').doc(user.uid).collection('orders').add({
        'items': cartItems,
        'totalPrice': totalPrice,
        'status': 'Pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 2. Order එක දැමූ පසු Cart එක Clear කිරීම
      var cartDocs = await _db
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();
      for (var doc in cartDocs.docs) {
        await doc.reference.delete();
      }
    }
  }

  // User ගේ Orders ටික Real-time ලබා ගැනීමට Stream එකක්
  Stream<QuerySnapshot>? getUserOrders() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _db
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .snapshots();
    }
    return null;
  }

  // Item එකක් Wishlist එකට Add / Remove කිරීම (Toggle)
  Future<void> toggleWishlist(Map<String, dynamic> product) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final docRef = _db
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .doc(product['id'].toString());

      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.delete(); // තිබුනොත් අයින් කරනවා
      } else {
        await docRef.set(product); // නැත්නම් add කරනවා
      }
    }
  }

  // User ගේ Wishlist ටික Real-time ලබා ගැනීමට Stream එකක්
  Stream<QuerySnapshot>? getWishlistStream() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _db
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .snapshots();
    }
    return null;
  }
}
