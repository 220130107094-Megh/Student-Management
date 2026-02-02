🎓 Student Management System (Java Servlet + JDBC)

A web-based Student Management System built using Java Servlets, JSP, and JDBC.
This application allows users to add, view, update, delete, search, and filter students stored in a MySQL database.

🚀 Features

➕ Add new students

📋 View all students

✏️ Update student details

❌ Delete students

🔍 Search students by fields (First Name, Gender, etc.)

📑 Pagination support

🗂 MVC architecture (Model–View–Controller)

🧪 Database connection testing

🏗 Project Structure

<img width="419" height="648" alt="image" src="https://github.com/user-attachments/assets/0ae1924e-5311-4780-a472-a6fc27fb66b0" />

🛠 Technologies Used

Java (JDK 17+)

Java Servlet API

JSP (Java Server Pages)

JDBC

MySQL Database

Apache Tomcat (v10+)

Maven

🗃 Database Configuration
Database Name
student_db

Table Structure

<img width="396" height="262" alt="image" src="https://github.com/user-attachments/assets/a319c6e0-3e89-41f0-9418-7e2676e006ac" />

⚙️ Setup Instructions

1️⃣ Clone or Extract Project
StudentManagement.zip

2️⃣ Import into IDE

Open IntelliJ IDEA / Eclipse

Import as Maven Project

3️⃣ Configure Database

Update your DB credentials inside StudentDAO.java:

String url = "jdbc:mysql://localhost:3307/student_db";
String username = "root";
String password = "your_password";

4️⃣ Add MySQL Connector

Already included:

mysql-connector-j-8.0.33.jar

5️⃣ Run on Tomcat

Deploy project on Apache Tomcat 10+

Start server

Open browser:

http://localhost:8080/StudentManagement/

🔄 Data Flow (MVC)

JSP (View)
   ↓
StudentServlet (Controller)
   ↓
StudentDAO (Database Layer)
   ↓
MySQL Database

🧪 Testing

Database connection test available in:

src/test/java/DBTest.java

📸 Screens (Pages)

index.jsp → Home Page

manageStudents.jsp → Student List

studentForm.jsp → Add/Edit Student

👨‍💻 Author

Developed by: Megh Patel
Project Type: Academic / Learning Project

