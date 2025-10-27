// src/models/weight_setting.model.js
import connection from "../config/db.js";

export const WeightSettingModel = {
  async setWeights(weights) {
    const query = `
      INSERT INTO weight_settings
      (subject_id, mid_term_weight, assignment1_weight, quiz_weight, attendance_weight, final_exam_weight)
      VALUES (?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
      mid_term_weight=?, assignment1_weight=?, quiz_weight=?, attendance_weight=?, final_exam_weight=?
    `;
    const params = [
      weights.subject_id,
      weights.mid_term_weight,
      weights.assignment1_weight,
      weights.quiz_weight,
      weights.attendance_weight,
      weights.final_exam_weight,
      weights.mid_term_weight,
      weights.assignment1_weight,
      weights.quiz_weight,
      weights.attendance_weight,
      weights.final_exam_weight,
    ];
    const [result] = await connection.query(query, params);
    return result;
  },

  async getWeightsBySubject(subject_id) {
    const [rows] = await connection.query(
      "SELECT * FROM weight_settings WHERE subject_id = ?",
      [subject_id]
    );
    return rows[0];
  },
};
