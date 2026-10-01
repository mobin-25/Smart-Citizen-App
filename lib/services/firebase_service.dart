import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service class handling Firebase Authentication and Firestore operations.
class FirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Registers a new user using Firebase Authentication (email & password),
  /// and creates a user document in Firestore under `users/{uid}`.
  Future<UserCredential?> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'name': name,
          'role': 'citizen',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Authenticates an existing user with email and password.
  Future<UserCredential?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns the currently authenticated Firebase user, or `null` if none.
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Fetches the profile document (`users/{uid}`) from Firestore for the current user.
  /// Returns `null` if no user is logged in.
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserProfile() async {
    try {
      final user = getCurrentUser();
      if (user == null) {
        return null;
      }
      return await _firestore.collection('users').doc(user.uid).get();
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Creates a complaint document in Firestore under `complaints/{auto-generated-id}`.
  /// Returns the `DocumentReference` of the created complaint, or `null` if no user is logged in.
  Future<DocumentReference<Map<String, dynamic>>?> createComplaint({
    required String title,
    required String category,
    required String description,
    String imageUrl = '',
    double? latitude,
    double? longitude,
    String address = '',
    String department = '',
  }) async {
    try {
      final user = getCurrentUser();
      if (user == null) {
        return null;
      }

      final docRef = _firestore.collection('complaints').doc();
      final complaintData = <String, dynamic>{
        'complaintId': docRef.id,
        'userId': user.uid,
        'title': title,
        'category': category,
        'description': description,
        'imageUrl': imageUrl,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'status': 'Reported',
        'department': department,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await docRef.set(complaintData);
      return docRef;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns a stream of complaint snapshots created by the current user, ordered by `createdAt` descending.
  /// Returns an empty stream if no user is logged in.
  Stream<QuerySnapshot<Map<String, dynamic>>> getMyComplaints() {
    final user = getCurrentUser();
    if (user == null) {
      return Stream<QuerySnapshot<Map<String, dynamic>>>.empty();
    }

    return _firestore
        .collection('complaints')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Fetches a specific complaint document from Firestore by `complaintId`.
  Future<DocumentSnapshot<Map<String, dynamic>>?> getComplaint(
    String complaintId,
  ) async {
    try {
      return await _firestore.collection('complaints').doc(complaintId).get();
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Updates only the `status` and `updatedAt` timestamp of a complaint.
  Future<void> updateComplaintStatus({
    required String complaintId,
    required String status,
  }) async {
    try {
      await _firestore.collection('complaints').doc(complaintId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
