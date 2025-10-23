import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/models/member.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  List<Member> members = Member.registeredMembers;
  List<Member> filteredMembers = [];
  String selectedStatus = 'Semua';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMembers = members;
  }

  void _filterMembers() {
    setState(() {
      filteredMembers = members.where((member) {
        bool matchesSearch = searchController.text.isEmpty ||
            member.username
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            member.email
                .toLowerCase()
                .contains(searchController.text.toLowerCase());

        bool matchesStatus = selectedStatus == 'Semua' ||
            (selectedStatus == 'Aktif' && member.isActive) ||
            (selectedStatus == 'Tidak Aktif' && !member.isActive);

        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  Color getStatusColor(bool isActive) {
    return isActive ? Colors.green : Colors.red;
  }

  // 📋 Popup detail member
  void _showMemberDetail(Member member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          member.username,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: const AssetImage('assets/images/defaultImage.jpeg'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status: ${member.isActive ? "Aktif" : "Tidak Aktif"}",
                      style: TextStyle(color: getStatusColor(member.isActive)),
                    ),
                    Text("Expired: ${member.expiredDate}"),
                    Text("No. Anggota: ${member.id}"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            Text("Nama Lengkap : ${member.fullName}"),
            Text("Email : ${member.email}"),
            Text("Alamat : ${member.address ?? "Belum diisi"}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  // ➕ Popup Tambah Member
  void _showAddMemberDialog() {
    final _usernameController = TextEditingController();
    final _fullnameController = TextEditingController();
    final _emailController = TextEditingController();
    final _addressController = TextEditingController();
    bool isActive = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Tambah Member Baru"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInputField(_usernameController, "Username", Icons.person),
              const SizedBox(height: 10),
              _buildInputField(_fullnameController, "Nama Lengkap", Icons.badge),
              const SizedBox(height: 10),
              _buildInputField(_emailController, "Email", Icons.email),
              const SizedBox(height: 10),
              _buildInputField(_addressController, "Alamat", Icons.location_on),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text("Status: "),
                  Switch(
                    value: isActive,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      isActive = value;
                      // harus setState agar UI terupdate
                    },
                  ),
                  Text(isActive ? "Aktif" : "Tidak Aktif"),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text("Simpan"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              if (_usernameController.text.isEmpty ||
                  _fullnameController.text.isEmpty ||
                  _emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Harap isi semua field wajib!")),
                );
                return;
              }

              // Buat member baru
              final newMember = Member(
                id: (members.length + 1).toString(),
                username: _usernameController.text,
                fullName: _fullnameController.text,
                email: _emailController.text,
                address: _addressController.text,
                isActive: isActive,
                expiredDate: "2025-12-31",
              );

              setState(() {
                members.add(newMember);
                _filterMembers();
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Member baru berhasil ditambahkan!")),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Daftar Member',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),

            // 🔍 Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Cari member...',
                    prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (value) => _filterMembers(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🏷️ Filter status
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: ['Semua', 'Aktif', 'Tidak Aktif'].map((status) {
                  final isSelected = selectedStatus == status;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        status,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      selectedColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                      elevation: 2,
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedStatus = status;
                          _filterMembers();
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // 📋 Daftar Member
            Expanded(
              child: filteredMembers.isEmpty
                  ? const Center(child: Text('Tidak ada member ditemukan'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredMembers.length,
                      itemBuilder: (context, index) {
                        final member = filteredMembers[index];
                        return InkWell(
                          onTap: () => _showMemberDetail(member),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.blue.shade50],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/defaultImage.jpeg',
                                      width: 70,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member.username,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: getStatusColor(member.isActive),
                                              size: 12,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              member.isActive ? 'Aktif' : 'Tidak Aktif',
                                              style: TextStyle(
                                                color: getStatusColor(member.isActive),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Expired: ${member.expiredDate}",
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
