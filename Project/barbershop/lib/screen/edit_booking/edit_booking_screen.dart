import 'package:barbershop/providers/booking_provider.dart';
import 'package:barbershop/service/booking_service.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookingScreen extends StatelessWidget {
  final String idDoc;
  const EditBookingScreen({
    Key? key,
    required this.idDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    BookingService bookingService = BookingService();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: bookingService.getBookingByID(idDoc),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                bookingProvider.namaBarbershop.text = data['nama barbershop'];
                bookingProvider.namaPemesan.text = data['nama pemesan'];
                bookingProvider.noPemesan.text = data['no pemesan'];
                bookingProvider.tanggalPemesan.text = data['tanggal'];
                bookingProvider.jamPemesan.text = data['jam'];
                bookingProvider.pesanPemesan.text = data['pesan pemesan'];
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Booking',
                        style: blackTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Nama Barbershop',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: bookingProvider.namaBarbershop,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Nama Pemesan',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: bookingProvider.namaPemesan,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Masukan Nama',
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'No Telp',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: bookingProvider.noPemesan,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Masukan No Telp',
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Pilih Tanggal Booking',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<BookingProvider>(
                              builder: (_, booking, child) {
                                return TextFormField(
                                  onTap: () {
                                    booking.datePicker(context);
                                  },
                                  controller: booking.tanggalPemesan,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: 'Pilih Tanggal Booking',
                                    hintStyle: greyTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Pilih Jam Booking',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<BookingProvider>(
                              builder: (_, booking, child) {
                                return TextFormField(
                                  onTap: () {
                                    booking.timePicker(context);
                                  },
                                  controller: booking.jamPemesan,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: 'Pilih Jam Booking',
                                    hintStyle: greyTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Silahkan tuliskan yang ingin di treatment',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: bookingProvider.pesanPemesan,
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Contoh : potong rambut',
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              height: 70,
                              width: 400,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          'Apakah anda yakin data yang dimasukan sudah benar ?',
                                          style: blackTextStyle,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            bookingService.updateBooking(
                                                idDoc, context);
                                          },
                                          child: const Text('Ya'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Tidak'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Selanjutnya',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
