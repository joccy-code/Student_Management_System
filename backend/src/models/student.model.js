// src/models/student.model.js
import connection from "../config/db.js";

export const StudentModel = {
  async createStudent(student) {
    const query = `
      INSERT INTO students (student_id, full_name, gender, grade_level, section, homeroom_teacher_id, parent_id)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `;
    const [result] = await connection.query(query, [
      student.student_id,
      student.full_name,
      student.gender,
      student.grade_level,
      student.section,
      student.homeroom_teacher_id,
      student.parent_id,
    ]);
    return result.insertId;
  },

  async getStudentById(student_id) {
    const [rows] = await connection.query(
      "SELECT * FROM students WHERE student_id = ?",
      [student_id]
    );
    return rows[0];
  },

  async getAllStudents() {
    const [rows] = await connection.query("SELECT * FROM students");
    return rows;
  },
};
