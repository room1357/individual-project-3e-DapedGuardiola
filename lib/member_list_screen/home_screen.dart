import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pemrograman_mobile/member_list_screen/about_us.dart';
import 'package:pemrograman_mobile/member_list_screen/login_screen.dart';
import 'package:pemrograman_mobile/member_list_screen/profile_screen.dart';
import 'package:pemrograman_mobile/member_list_screen/member_list_screen.dart';
import 'package:pemrograman_mobile/models/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  Color _getStatusColor(bool isActive) => isActive ? Colors.green : Colors.red;

  @override
  Widget build(BuildContext context) {
    final attendanceList = [
      {'name': 'Rizky Pratama', 'status': true},
      {'name': 'Sinta Dewi', 'status': true},
      {'name': 'Ahmad Yusuf', 'status': true},
      {'name': 'Budi Setiawan', 'status': true},
      {'name': 'Dewi Anggraini', 'status': false},
      {'name': 'Intan Pertiwi', 'status': true},
      {'name': 'Fajar Nugroho', 'status': false},
      {'name': 'Laras Fitri', 'status': true},
    ];

    int hadirCount =
        attendanceList.where((e) => e['status'] == true).toList().length;
    int tidakHadirCount = attendanceList.length - hadirCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 1))
            ],
          ),
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF8E2DE2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Halo, ${user.username}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Selamat datang kembali 👋',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title:
                    const Text('Profile', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileScreen(user: user)),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.group, color: Colors.white),
                title: const Text('Daftar Member',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MemberListScreen()),
                  );
                },
              ),
              const Divider(color: Colors.white54),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          // 🌊 Background bergelombang
          CustomPaint(
            painter: _WaveBackgroundPainter(),
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
          ),

          // 📋 Konten utama
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang, ${user.username} 👋",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 1))
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Akses fitur yang kamu butuhkan di bawah ini:",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),

                // 🔹 Dashboard Cards
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(context,
                        title: 'Profil',
                        icon: Icons.person,
                        color: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProfileScreen(user: user)),
                          );
                        }),
                    _buildDashboardCard(context,
                        title: 'Daftar Member',
                        icon: Icons.group,
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MemberListScreen()),
                          );
                        }),
                    _buildDashboardCard(context,
                        title: 'Settings',
                        icon: Icons.settings,
                        color: Colors.purple,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Settings feature coming soon!')),
                          );
                        }),
                    _buildDashboardCard(context,
                        title: 'Help',
                        icon: Icons.help_outline,
                        color: Colors.redAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AboutUsScreen()),
                          );
                        }),
                  ],
                ),

                const SizedBox(height: 30),

                // 🔸 Daftar hadir
                const Text(
                  "📋 Daftar Hadir Hari Ini",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: ListView.builder(
                    itemCount: attendanceList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final attendee = attendanceList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 6,
                          backgroundColor:
                              _getStatusColor(attendee['status'] as bool),
                        ),
                        title: Text(
                          attendee['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          attendee['status'] as bool ? "Hadir" : "Tidak Hadir",
                          style: TextStyle(
                            color: _getStatusColor(attendee['status'] as bool),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // 🥧 Pie Chart Hadir vs Tidak Hadir
                const Text(
                  "📊 Statistik Kehadiran",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: SizedBox(
                    height: 220,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: hadirCount.toDouble(),
                            title: 'Hadir',
                            radius: 60,
                            titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          PieChartSectionData(
                            color: Colors.redAccent,
                            value: tidakHadirCount.toDouble(),
                            title: 'Tidak',
                            radius: 60,
                            titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 📈 Line Chart Jumlah Pengunjung Harian
                const Text(
                  "📈 Jumlah Pengunjung Harian",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: SizedBox(
                    height: 220,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Sen',
                                    'Sel',
                                    'Rab',
                                    'Kam',
                                    'Jum',
                                    'Sab',
                                    'Min'
                                  ];
                                  return Text(days[value.toInt() % 7]);
                                },
                              ),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              color: Colors.blueAccent,
                              barWidth: 4,
                              dotData: FlDotData(show: true),
                              spots: const [
                                FlSpot(0, 5),
                                FlSpot(1, 7),
                                FlSpot(2, 6),
                                FlSpot(3, 9),
                                FlSpot(4, 10),
                                FlSpot(5, 8),
                                FlSpot(6, 7),
                              ],
                            ),
                          ],
                        ),
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
  }

  // 🔹 Widget kartu dashboard
  Widget _buildDashboardCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 28,
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 10),
            Text(title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// 🌊 Custom Painter untuk background bergelombang
class _WaveBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF4A90E2), Color(0xFF8E2DE2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..lineTo(0, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.35,
          size.width, size.height * 0.2)
      ..lineTo(size.width, 0)
      ..close();

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..lineTo(0, size.height * 0.15)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.25,
          size.width, size.height * 0.1)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
