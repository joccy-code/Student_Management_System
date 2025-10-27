import express from "express";
import dotenv from "dotenv";
import connection from "./config/db.js";

dotenv.config();

const app = express();

// Middleware
app.use(express.json());

// Simple route to test server
app.get("/", (req, res) => {
  res.send("Student Management System API is running...");
});

// Example: check DB connection before starting the server
const startServer = async () => {
  try {
    await connection.connect();
    console.log("✅ Database connected successfully!");

    const PORT = process.env.PORT || 5000;
    app.listen(PORT, () => {
      console.log(`🚀 Server is running on http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error("❌ Failed to connect to the database:", err);
    process.exit(1);
  }
};

startServer();
