import 'package:projectmobile/screen/Riwayat/components/DetailRiwayat.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:flutter/material.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(53),
        child: AppBar(
          centerTitle: true,
          title: Text('Riwayat Pembayaran', style: AppbarStyle),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: ListView.builder(
        itemCount: Riwayat.length,
        itemBuilder: (context, index) {
          return _buildExpandableTile(Riwayat[index], context);
        },
      ),
    );
  }

  final List Riwayat = [
    {"Nama": "Lusy D", "Paket": "Internet Lite", "Tanggal": "30-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "28-12-2022"},
    {"Nama": "Lusy D", "Paket": "Internet Lite", "Tanggal": "27-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
    {"Nama": "Lusy", "Paket": "Internet Lite", "Tanggal": "14-12-2022"},
  ];
}

Widget _buildExpandableTile(item, BuildContext context) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          height: 80,
          child: Card(
            color: ButtonBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailRiwayat()));
                },
                child: ListTile(
                  title: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item['Nama'], style: ButtonTextStyle),
                          Text(item['Tanggal'], style: ButtonTextStyle),
                        ],
                      )),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['Paket'], style: ButtonTextStyle),
                    ],
                  ),
                )),
          )));
}
