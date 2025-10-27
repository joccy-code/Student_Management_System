import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();

const connection = await mysql.createConnection({
  host: process.env.DB_HOST, 
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
});

try {
  await connection.connect();
  console.log("✅ Connected to the MySQL database.");
} catch (err) {
  console.error("❌ Error connecting to the database:", err);
}

export default connection;
