import 'package:barbershop/models/barbershop_model.dart';
import 'package:barbershop/screen/auth/widgets/snackbar.dart';
import 'package:barbershop/screen/home/navbar_screen.dart';
import 'package:barbershop/screen/riwayat/riwayat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingProvider extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  DateTime? dueDate;
  TimeOfDay? time;
  BarbershopModel? barbershopModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController namaPemesan = TextEditingController();
  TextEditingController namaBarbershop = TextEditingController();
  TextEditingController noPemesan = TextEditingController();
  TextEditingController pesanPemesan = TextEditingController();
  TextEditingController tanggalPemesan = TextEditingController();
  TextEditingController jamPemesan = TextEditingController();

  void datePicker(context) async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(currentDate.year + 5),
    );

    if (selectDate != null) {
      dueDate = selectDate;
      tanggalPemesan.text = DateFormat('dd-MM-yyyy').format(dueDate!);
    }
    notifyListeners();
  }

  void timePicker(context) async {
    final selectTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectTime != null) {
      time = selectTime;
      jamPemesan.text =
          '${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}';
    }
    notifyListeners();
  }

  void tambahData(context) async {
    CollectionReference booking = firestore.collection("booking");

    booking.add({
      'nama barbershop': namaBarbershop.text,
      'nama pemesan': namaPemesan.text,
      'no pemesan': noPemesan.text,
      'tanggal': tanggalPemesan.text,
      'jam': jamPemesan.text,
      'pesan pemesan': pesanPemesan.text,
    });
    showTextMessage(context, 'Booking anda berhasil');
    namaPemesan.clear();
    noPemesan.clear();
    tanggalPemesan.clear();
    pesanPemesan.clear();
    jamPemesan.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
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
    DocumentReference docRef = firestore.collection("booking").doc(id);
    docRef.update({
      //'nama barbershop': namaBarbershop.text,
      'nama pemesan': namaPemesan.text,
      'no pemesan': noPemesan.text,
      'tanggal': tanggalPemesan.text,
      'jam': jamPemesan.text,
      'pesan pemesan': pesanPemesan.text,
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RiwayatScreen(),
      ),
    );
  }

  void hapusData(String id) {
    DocumentReference docRef = firestore.collection("booking").doc(id);
    docRef.delete();
  }
}
