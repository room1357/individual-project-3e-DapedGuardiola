class Member {
  final String id;
  final String fullName;
  final String email;
  final String username;
  final String? address;
  final bool isActive;
  final String expiredDate;
  final String? phoneNumber;

  Member({
    required this.id,
    required this.fullName,
    required this.email,
    required this.username,
    this.address,
    required this.isActive,
    required this.expiredDate,
    this.phoneNumber,
  });

  static List<Member> registeredMembers = [
    Member(
      id: 'MBR001',
      fullName: 'Budi Santoso',
      email: 'budi.santoso@email.com',
      username: 'budi',
      address: 'Jl. Merpati No. 12, Surabaya',
      isActive: true,
      expiredDate: '2025-12-31',
      phoneNumber: '081234567890',
    ),
    Member(
      id: 'MBR002',
      fullName: 'Andi Wijaya',
      email: 'andi.wijaya@email.com',
      username: 'andi',
      address: 'Jl. Mawar No. 8, Malang',
      isActive: false,
      expiredDate: '2024-11-15',
      phoneNumber: '085612345678',
    ),
    Member(
      id: 'MBR003',
      fullName: 'Siti Nurhaliza',
      email: 'siti.nurhaliza@email.com',
      username: 'siti',
      address: 'Jl. Kenanga No. 23, Gresik',
      isActive: true,
      expiredDate: '2026-03-20',
      phoneNumber: '082134567891',
    ),
    Member(
      id: 'MBR004',
      fullName: 'Dewi Anggraini',
      email: 'dewi.anggraini@email.com',
      username: 'dewi',
      address: 'Jl. Anggrek No. 10, Sidoarjo',
      isActive: false,
      expiredDate: '2024-10-05',
      phoneNumber: '083145678912',
    ),
    Member(
      id: 'MBR005',
      fullName: 'Rizky Pratama',
      email: 'rizky.pratama@email.com',
      username: 'rizky',
      address: 'Jl. Melati No. 15, Mojokerto',
      isActive: true,
      expiredDate: '2025-07-19',
      phoneNumber: '081345678912',
    ),
  ];
}
