// src/models/teacher.model.js
import connection from "../config/db.js";

export const TeacherModel = {
  async createTeacher(teacher) {
    const query = `
      INSERT INTO teachers (teacher_id, full_name, email, subject_id, section)
      VALUES (?, ?, ?, ?, ?)
    `;
    const [result] = await connection.query(query, [
      teacher.teacher_id,
      teacher.full_name,
      teacher.email,
      teacher.subject_id,
      teacher.section,
    ]);
    return result.insertId;
  },

  async getTeacherById(teacher_id) {
    const [rows] = await connection.query(
      "SELECT * FROM teachers WHERE teacher_id = ?",
      [teacher_id]
    );
    return rows[0];
  },

  async getAllTeachers() {
    const [rows] = await connection.query("SELECT * FROM teachers");
    return rows;
  },
};
