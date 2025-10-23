// lib/expense/user.dart
class User {
  final String fullName;
  final String email;
  final String username;
  final String password;

  User({
    required this.fullName,
    required this.email,
    required this.username,
    required this.password,
  });

  // Convert to map (optional for future DB use)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  // Optional: From map (if reading from DB later)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
    );
  }
}

List<User> registeredUsers = [
  User(
    fullName: 'AdminDavid',
    email: 'Admin1@gmail.com',
    password : '123456',
    username: 'Admin1',
  ),
];
