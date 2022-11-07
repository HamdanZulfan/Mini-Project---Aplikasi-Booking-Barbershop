import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamRekomendasi() {
    CollectionReference data = firestore.collection("rekomendasi");
    return data.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamDaftar() {
    CollectionReference data = firestore.collection("daftarbarbershop");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getByIDRekomendasi(String id) async {
    DocumentReference docRef = firestore.collection("rekomendasi").doc(id);
    return docRef.get();
  }

  Future<DocumentSnapshot<Object?>> getByIDDaftar(String id) {
    DocumentReference docRef = firestore.collection("daftarbarbershop").doc(id);
    return docRef.get();
  }
}
