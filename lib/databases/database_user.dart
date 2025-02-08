import 'package:souglink/models/user.dart';
import 'database_helper.dart';

class UserDatabase {
  // Insert a new user
  Future<int> insertUser(User user) async {
    final db = await DatabaseHelper.instance.database; // Corrected to use 'database'
    return await db.insert('users', user.toMap());
  }

  // Get a user by username
  Future<User?> getUserByUsername(String username) async {
    final db = await DatabaseHelper.instance.database; // Corrected to use 'database'
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Validate user login
  Future<User?> validateLogin(String username, String password) async {
    final db = await DatabaseHelper.instance.database; // Corrected to use 'database'
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Get all users (for debugging or admin features)
  Future<List<User>> getAllUsers() async {
    final db = await DatabaseHelper.instance.database; // Corrected to use 'database'
    final result = await db.query('users');
    return result.map((map) => User.fromMap(map)).toList();
  }
}
