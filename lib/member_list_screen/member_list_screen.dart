import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/models/user.dart';
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

  // 🔍 Filter berdasarkan status dan pencarian
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

  // 🟢🔴 Warna status
  Color getStatusColor(bool isActive) {
    return isActive ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Member'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Cari member...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _filterMembers(),
            ),
          ),

          // 🏷️ Filter status
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['Semua', 'Aktif', 'Tidak Aktif'].map((status) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(status),
                    selected: selectedStatus == status,
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
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.blue.shade100,
                                child: Text(
                                  member.username[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: getStatusColor(member.isActive),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            member.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Text(
                            member.email,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.message,
                                color: Colors.blueAccent),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Pesan dikirim ke ${member.username}'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
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
}
