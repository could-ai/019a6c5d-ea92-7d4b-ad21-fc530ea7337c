import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Penilaian Siswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StudentGradingScreen(),
    );
  }
}

class Student {
  final int no;
  final String nama;
  final String kelas;
  final int nilai;

  Student({
    required this.no,
    required this.nama,
    required this.kelas,
    required this.nilai,
  });

  String get predikat {
    if (nilai >= 75) {
      return 'Lulus';
    } else if (nilai >= 60) {
      return 'Remedial';
    } else {
      return 'Tidak Lulus';
    }
  }

  Color get predikatColor {
    if (nilai >= 75) {
      return Colors.green;
    } else if (nilai >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

class StudentGradingScreen extends StatefulWidget {
  const StudentGradingScreen({super.key});

  @override
  State<StudentGradingScreen> createState() => _StudentGradingScreenState();
}

class _StudentGradingScreenState extends State<StudentGradingScreen> {
  final List<Student> dataSiswa = [
    Student(no: 1, nama: "Aliffah Nurul Uzhma", kelas: "XII F", nilai: 85),
    Student(no: 2, nama: "Alya Sabrinah", kelas: "XII F", nilai: 62),
    Student(no: 3, nama: "Amat Apriansya", kelas: "XII F", nilai: 91),
    Student(no: 4, nama: "Aminnudin", kelas: "XII F", nilai: 77),
    Student(no: 5, nama: "Anisah Rahmadani", kelas: "XII F", nilai: 95),
    Student(no: 6, nama: "Azira Nabila", kelas: "XII F", nilai: 54),
    Student(no: 7, nama: "Bayu Putra Ramadhan", kelas: "XII F", nilai: 88),
    Student(no: 8, nama: "Dimaz Ken Antony", kelas: "XII F", nilai: 70),
    Student(no: 9, nama: "Elza Avrillia Agustian", kelas: "XII F", nilai: 68),
    Student(no: 10, nama: "Fadhillah Muslim Kaffah", kelas: "XII F", nilai: 81),
  ];

  int get totalLulus => dataSiswa.where((s) => s.nilai >= 75).length;
  int get totalRemedial => dataSiswa.where((s) => s.nilai >= 60 && s.nilai < 75).length;
  int get totalTidakLulus => dataSiswa.where((s) => s.nilai < 60).length;
  double get rataRata => dataSiswa.map((s) => s.nilai).reduce((a, b) => a + b) / dataSiswa.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistem Penilaian Siswa'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Statistics Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Kelas XII F',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Lulus', totalLulus, Colors.green),
                    _buildStatItem('Remedial', totalRemedial, Colors.orange),
                    _buildStatItem('Tidak Lulus', totalTidakLulus, Colors.red),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Rata-rata Nilai: ${rataRata.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Student List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dataSiswa.length,
              itemBuilder: (context, index) {
                final siswa = dataSiswa[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: siswa.predikatColor.withOpacity(0.2),
                      child: Text(
                        '${siswa.no}',
                        style: TextStyle(
                          color: siswa.predikatColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      siswa.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      siswa.kelas,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: siswa.predikatColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: siswa.predikatColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            siswa.predikat,
                            style: TextStyle(
                              color: siswa.predikatColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Nilai: ${siswa.nilai}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
