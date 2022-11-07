import 'package:barbershop/providers/booking_provider.dart';
import 'package:barbershop/screen/auth/widgets/snackbar.dart';
import 'package:barbershop/screen/home/navbar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController namaPemesan = TextEditingController();
  TextEditingController namaBarbershop = TextEditingController();
  TextEditingController noPemesan = TextEditingController();
  TextEditingController pesanPemesan = TextEditingController();
  TextEditingController tanggalPemesan = TextEditingController();
  TextEditingController jamPemesan = TextEditingController();

  void tambahData(context) async {
    CollectionReference booking = firestore.collection("booking");
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    booking.add({
      'nama barbershop': bookingProvider.namaBarbershop.text,
      'nama pemesan': bookingProvider.namaPemesan.text,
      'no pemesan': bookingProvider.noPemesan.text,
      'tanggal': bookingProvider.tanggalPemesan.text,
      'jam': bookingProvider.jamPemesan.text,
      'pesan pemesan': bookingProvider.pesanPemesan.text,
    });
    showTextMessage(context, 'Booking anda berhasil');
    bookingProvider.namaPemesan.clear();
    bookingProvider.noPemesan.clear();
    bookingProvider.tanggalPemesan.clear();
    bookingProvider.pesanPemesan.clear();
    bookingProvider.jamPemesan.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );
  }

  Stream<QuerySnapshot<Object?>> streamBooking() {
    CollectionReference data = firestore.collection("booking");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getBookingByID(String id) {
    DocumentReference docRef = firestore.collection("booking").doc(id);
    return docRef.get();
  }

  void updateBooking(String id, context) {
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    DocumentReference docRef = firestore.collection("booking").doc(id);

    docRef.update({
      //'nama barbershop': namaBarbershop.text,
      'nama pemesan': bookingProvider.namaPemesan.text,
      'no pemesan': bookingProvider.noPemesan.text,
      'tanggal': bookingProvider.tanggalPemesan.text,
      'jam': bookingProvider.jamPemesan.text,
      'pesan pemesan': bookingProvider.pesanPemesan.text,
    });
    //showTextMessage(context, 'Booking anda berhasil diubah');
    bookingProvider.namaPemesan.clear();
    bookingProvider.noPemesan.clear();
    bookingProvider.tanggalPemesan.clear();
    bookingProvider.pesanPemesan.clear();
    bookingProvider.jamPemesan.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );
  }

  void hapusData(String id) {
    DocumentReference docRef = firestore.collection("booking").doc(id);
    docRef.delete();
  }
}
