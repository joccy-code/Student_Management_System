// src/models/assessment.model.js
import connection from "../config/db.js";

export const AssessmentModel = {
  async createAssessment(assessment) {
    const query = `
      INSERT INTO assessments
      (assessment_id, student_id, subject_id, mid_term, assignment1, quiz, attendance, final_exam)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;
    const [result] = await connection.query(query, [
      assessment.assessment_id,
      assessment.student_id,
      assessment.subject_id,
      assessment.mid_term,
      assessment.assignment1,
      assessment.quiz,
      assessment.attendance,
      assessment.final_exam,
    ]);
    return result.insertId;
  },

  async getAssessmentsByStudent(student_id) {
    const [rows] = await connection.query(
      "SELECT * FROM assessments WHERE student_id = ?",
      [student_id]
    );
    return rows;
  },

  async getAllAssessments() {
    const [rows] = await connection.query("SELECT * FROM assessments");
    return rows;
  },
};
