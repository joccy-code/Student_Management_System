// src/models/subject.model.js
import connection from "../config/db.js";

export const SubjectModel = {
  async createSubject(subject) {
    const query = `
      INSERT INTO subjects (subject_id, name)
      VALUES (?, ?)
    `;
    const [result] = await connection.query(query, [
      subject.subject_id,
      subject.name,
    ]);
    return result.insertId;
  },

  async getSubjectById(subject_id) {
    const [rows] = await connection.query(
      "SELECT * FROM subjects WHERE subject_id = ?",
      [subject_id]
    );
    return rows[0];
  },

  async getAllSubjects() {
    const [rows] = await connection.query("SELECT * FROM subjects");
    return rows;
  },
};
