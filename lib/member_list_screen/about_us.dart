import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF00C6FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Tentang Kami",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🏸 Logo atau Ilustrasi
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Image.asset(
                'assets/images/images.jpeg',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),

            const Text(
              "🏸 Club Badminton SmashZone",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A90E2),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "“Bersatu dalam semangat, berjuang dalam sportivitas.”",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // 🧭 Deskripsi
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text(
                      "Tentang Club",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A90E2),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Club Badminton SmashZone adalah komunitas olahraga yang berfokus pada pengembangan minat dan bakat dalam cabang olahraga bulutangkis. "
                      "Kami hadir untuk menciptakan lingkungan yang positif, sportif, dan mendukung bagi semua anggota — baik pemula maupun profesional.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🎯 Visi & Misi
            _buildSection(
              icon: Icons.remove_red_eye,
              title: "Visi Kami",
              content:
                  "Menjadi komunitas bulutangkis yang solid, inspiratif, dan berprestasi di tingkat regional maupun nasional.",
            ),
            const SizedBox(height: 20),
            _buildSection(
              icon: Icons.flag_circle,
              title: "Misi Kami",
              content:
                  "• Mengembangkan potensi anggota melalui latihan rutin.\n"
                  "• Menanamkan nilai sportivitas dan kerja sama.\n"
                  "• Menyelenggarakan kegiatan sosial dan kompetisi persahabatan.\n"
                  "• Membangun rasa kekeluargaan antar anggota.",
            ),

            const SizedBox(height: 30),

            // 📍 Lokasi & Kontak
            _buildSection(
              icon: Icons.location_on,
              title: "Lokasi Kami",
              content:
                  "Gor SmashZone, Jl. Merdeka No. 45, Bandung, Jawa Barat.",
            ),
            const SizedBox(height: 20),
            _buildSection(
              icon: Icons.contact_mail,
              title: "Hubungi Kami",
              content:
                  "📞 0812-3456-7890\n✉️ smashzone.club@gmail.com\n🌐 instagram.com/smashzone.club",
            ),

            const SizedBox(height: 40),

            // Footer kecil
            const Text(
              "© 2025 SmashZone Badminton Club\nAll rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: const Color(0xFF4A90E2), size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A90E2),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
