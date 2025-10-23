class Member {
  final String username;
  final String password;
  final String email;
  final bool isActive;

  Member({
    required this.username,
    required this.password,
    required this.email,
    required this.isActive,
  });

  // 🔹 Data dummy 10 Member
  static List<Member> registeredMembers = [
    Member(username: 'david', password: '12345', email: 'david@mail.com', isActive: true),
    Member(username: 'sarah', password: '12345', email: 'sarah@mail.com', isActive: false),
    Member(username: 'john', password: '12345', email: 'john@mail.com', isActive: true),
    Member(username: 'maria', password: '12345', email: 'maria@mail.com', isActive: true),
    Member(username: 'andi', password: '12345', email: 'andi@mail.com', isActive: false),
    Member(username: 'budi', password: '12345', email: 'budi@mail.com', isActive: true),
    Member(username: 'citra', password: '12345', email: 'citra@mail.com', isActive: false),
    Member(username: 'rudi', password: '12345', email: 'rudi@mail.com', isActive: true),
    Member(username: 'nina', password: '12345', email: 'nina@mail.com', isActive: false),
    Member(username: 'lisa', password: '12345', email: 'lisa@mail.com', isActive: true),
  ];
}
