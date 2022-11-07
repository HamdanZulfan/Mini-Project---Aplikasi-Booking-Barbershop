import 'package:barbershop/models/barbershop_model.dart';
import 'package:barbershop/service/home_service.dart';
import 'package:barbershop/screen/detail_barbershop/detail_daftar_screen.dart';
import 'package:barbershop/screen/detail_barbershop/detail_rekomendasi_screen.dart';
import 'package:barbershop/screen/home/widgets/daftar_card.dart';
import 'package:barbershop/screen/home/widgets/rekomendasi_card.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HomeProvider homeProvider =
    //     Provider.of<HomeProvider>(context, listen: false);

    HomeService homeService = HomeService();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Hair Magicians\nIn City Are Here!',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Temukan barbershop pilihanmu !!!',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Rekomendasi',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeService.streamRekomendasi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final dataRekomen =
                                data[index].data() as Map<String, dynamic>;
                            return RekomendasiCard(
                              BarbershopModel(
                                nama: dataRekomen['nama'],
                                kota: dataRekomen['kota'],
                                image1: dataRekomen['image1'],
                              ),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailRekomendasiScreen(
                                      idDoc: data[index].id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Daftar Barbershop',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeService.streamDaftar(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final dataRekomen =
                              data[index].data() as Map<String, dynamic>;
                          return DaftarCard(
                            BarbershopModel(
                              nama: dataRekomen['nama'],
                              kota: dataRekomen['kota'],
                              image1: dataRekomen['image1'],
                            ),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailDaftarScreen(
                                    idDoc: data[index].id,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
