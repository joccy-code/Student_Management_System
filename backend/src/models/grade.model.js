// src/models/grade.model.js
import connection from "../config/db.js";

export const GradeModel = {
  async createGrade(grade) {
    const query = `
      INSERT INTO grades (student_id, subject_id, final_score, letter_grade)
      VALUES (?, ?, ?, ?)
    `;
    const [result] = await connection.query(query, [
      grade.student_id,
      grade.subject_id,
      grade.final_score,
      grade.letter_grade,
    ]);
    return result.insertId;
  },

  async getGradesByStudent(student_id) {
    const [rows] = await connection.query(
      "SELECT * FROM grades WHERE student_id = ?",
      [student_id]
    );
    return rows;
  },

  async getAllGrades() {
    const [rows] = await connection.query("SELECT * FROM grades");
    return rows;
  },
};
