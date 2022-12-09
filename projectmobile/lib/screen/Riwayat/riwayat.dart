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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 24,
            color: blackColor,
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(25),
          child: ListView.builder(
            itemCount: Riwayat.length,
            itemBuilder: (context, index) {
              return _buildExpandableTile(Riwayat[index], context);
            },
          )),
    );
  }

  final List Riwayat = [
    {
      "Nama": "Lusy D",
      "Paket": "Internet Lite",
      "Jam": "12.00",
      "Tanggal": "30-12-2022"
    },
    {
      "Nama": "Lusy",
      "Paket": "Internet Lite",
      "Jam": "12.00",
      "Tanggal": "28-12-2022"
    },
    {
      "Nama": "Lusy D",
      "Paket": "Internet Lite",
      "Jam": "12.00",
      "Tanggal": "27-12-2022"
    },
    {
      "Nama": "Lusy",
      "Paket": "Internet Lite",
      "Jam": "12.00",
      "Tanggal": "14-12-2022"
    }
  ];
}

Widget _buildExpandableTile(item, BuildContext context) {
  return Container(
      height: 80,
      child: Card(
        color: ButtonBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: InkWell(
            onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => DetailRiwayat()));
            },
            child: ListTile(
              title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['Nama'], style: ButtonTextStyle),
                      Text(item['Jam'], style: ButtonTextStyle),
                    ],
                  )),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['Paket'], style: ButtonTextStyle),
                  Text(item['Tanggal'], style: ButtonTextStyle),
                ],
              ),
            )),
      ));
}	
