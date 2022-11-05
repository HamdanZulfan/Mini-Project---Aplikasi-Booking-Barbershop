import 'package:barbershop/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class KetentuanScreen extends StatelessWidget {
  const KetentuanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'KETENTUAN BOOKING',
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '1. Diharapkan datang 10 menit sebelum jam booking anda',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '2. Diharapkan datang sesuai waktu yang telah di booking',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '3. Pastikan anda membawa handphone untuk bukti telah booking',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
