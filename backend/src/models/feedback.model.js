// src/models/attendance.model.js
import connection from "../config/db.js";

export const AttendanceModel = {
  async markAttendance(attendance) {
    const query = `
      INSERT INTO attendance (student_id, date, status)
      VALUES (?, ?, ?)
    `;
    const [result] = await connection.query(query, [
      attendance.student_id,
      attendance.date,
      attendance.status, // e.g., "present" or "absent"
    ]);
    return result.insertId;
  },

  async getAttendanceByStudent(student_id) {
    const [rows] = await connection.query(
      "SELECT * FROM attendance WHERE student_id = ?",
      [student_id]
    );
    return rows;
  },

  async getAllAttendance() {
    const [rows] = await connection.query("SELECT * FROM attendance");
    return rows;
  },
};
