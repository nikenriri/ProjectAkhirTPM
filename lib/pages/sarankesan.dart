import 'dart:ui';
import 'package:flutter/material.dart';

class SarankesanPage extends StatefulWidget {
  const SarankesanPage({Key? key}) : super(key : key);

  @override
  State<SarankesanPage> createState() => _SarankesanPageState();
}

class _SarankesanPageState extends State<SarankesanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Saran dan Kesan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Saran',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '1. Untuk tugas yang bersifat kelompok mungkin bisa sesekali pembagian dari dosen.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  '2. Selalu melakukan presensi ulang kepada mahasiswa ketika di dalam kelas',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  '3. Untuk tugas mungkin dapat di upgrade setiap semesternya',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Kesan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '1. Penyampaian materi cukup mudah untuk dicerna, karena pembawaan bapak tidak santai namun tetap serius ',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  '2. Tanya jawab ketika presentasi membantu menambah pemahaman pada materi',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  'Terimakasih banyak pak Bagus atas bimbingan dan ilmunya selama satu semester ini',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Mohon maaf atas segala kesalahan saya selama menjadi murid pak Bagus',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown
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
