// src/models/user.model.js
import connection from "../config/db.js";

export const UserModel = {
  async createUser(user) {
    const query = `
      INSERT INTO users (user_id, full_name, email, password, role)
      VALUES (?, ?, ?, ?, ?)
    `;
    const [result] = await connection.query(query, [
      user.user_id,
      user.full_name,
      user.email,
      user.password,
      user.role, // e.g., Director, VAD, Teacher, Homeroom Teacher, Parent
    ]);
    return result.insertId;
  },

  async getUserById(user_id) {
    const [rows] = await connection.query(
      "SELECT * FROM users WHERE user_id = ?",
      [user_id]
    );
    return rows[0];
  },

  async getAllUsers() {
    const [rows] = await connection.query("SELECT * FROM users");
    return rows;
  },

  async getUserByEmail(email) {
    const [rows] = await connection.query(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );
    return rows[0];
  },
};
