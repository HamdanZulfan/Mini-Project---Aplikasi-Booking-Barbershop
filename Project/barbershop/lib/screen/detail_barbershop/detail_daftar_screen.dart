import 'package:barbershop/service/home_service.dart';
import 'package:barbershop/screen/booking/booking_daftar_screen.dart';

import 'package:barbershop/utils/constants/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDaftarScreen extends StatelessWidget {
  final String idDoc;
  const DetailDaftarScreen({Key? key, required this.idDoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    launchUrl(String url) async {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        throw (url);
      }
    }

    HomeService homeService = HomeService();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: homeService.getByIDDaftar(idDoc),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var datas = snapshot.data!;
                final data = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      data['image1'],
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama'],
                            style: blackTextStyle.copyWith(
                              fontSize: 22,
                              fontWeight: medium,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data['kota'],
                            style: greyTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Informasi',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data['informasi'],
                            style: greyTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Photo',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            height: 150,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    18,
                                  ),
                                  child: Image.network(
                                    data['image1'],
                                    width: 170,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    18,
                                  ),
                                  child: Image.network(
                                    data['image2'],
                                    width: 170,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    18,
                                  ),
                                  child: Image.network(
                                    data['image3'],
                                    width: 170,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Lokasi',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['lokasi'],
                                style: greyTextStyle,
                              ),
                              InkWell(
                                onTap: () {
                                  launchUrl(data['mapurl']);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/map1.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Kontak',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['kontak'],
                                style: greyTextStyle,
                              ),
                              InkWell(
                                onTap: () {
                                  launchUrl(data['kontakphone']);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/phone-call.png',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDaftarScreen(
                                      idDoc: datas.id,
                                    ),
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
                                'Booking',
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
