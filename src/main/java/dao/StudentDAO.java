package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Student;

/**
  Data Access Object (DAO) for Student.
  Handles all JDBC (Database) operations: Insert, Select, Update, Delete.
 */

public class StudentDAO {

    // ===== DATABASE CONFIG =====
    // NOTE: In a real production app, never hardcode credentials here.
    // Use a properties file or environment variables.
    private static final String URL =
            "jdbc:mysql://localhost:3307/sys?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "pmg82004"; // <-- change this

    // ===== HELPER : GET DB CONNECTION =====
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // ===== READ ALL STUDENTS =====
    public static List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students";

        // Try-with-resources ensures Connection, Statement, and ResultSet close automatically
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            // Loop through database rows and convert them into Java 'Student' objects
            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setFirstName(rs.getString("first_name"));
                s.setLastName(rs.getString("last_name"));
                s.setEmail(rs.getString("email"));
                s.setGender(rs.getString("gender"));
                s.setDob(rs.getDate("dob"));
                s.setAdmissionDate(rs.getDate("admission_date"));
                s.setClassName(rs.getString("class_name"));
                s.setCity(rs.getString("city"));
                s.setStateCode(rs.getString("state_code"));
                s.setCountry(rs.getString("country"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===== INSERT STUDENT =====
    public static void insertStudent(Student s) {
        // We use '?' placeholders (PreparedStatement) to prevent SQL Injection attacks
        String sql = """
                INSERT INTO students
                (first_name, last_name, email, dob, gender, admission_date,
                 class_name, city, state_code, country)
                VALUES (?,?,?,?,?,?,?,?,?,?)
                """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getFirstName());
            ps.setString(2, s.getLastName());
            ps.setString(3, s.getEmail());
            ps.setDate(4, s.getDob());
            ps.setString(5, s.getGender());
            ps.setDate(6, s.getAdmissionDate());
            ps.setString(7, s.getClassName());
            ps.setString(8, s.getCity());
            ps.setString(9, s.getStateCode());
            ps.setString(10, s.getCountry());

            ps.executeUpdate(); // Executes the Insert
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== GET STUDENT BY ID (USED FOR EDIT FORM) =====
    public static Student getStudentById(int id) {
        Student s = null;
        String sql = "SELECT * FROM students WHERE id = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new Student();
                s.setId(rs.getInt("id"));
                s.setFirstName(rs.getString("first_name"));
                s.setLastName(rs.getString("last_name"));
                s.setEmail(rs.getString("email"));
                s.setDob(rs.getDate("dob"));
                s.setGender(rs.getString("gender"));
                s.setAdmissionDate(rs.getDate("admission_date"));
                s.setClassName(rs.getString("class_name"));
                s.setCity(rs.getString("city"));
                s.setStateCode(rs.getString("state_code"));
                s.setCountry(rs.getString("country"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    // ===== UPDATE STUDENT =====
    public static void updateStudent(Student s) {
        String sql = """
                UPDATE students SET
                first_name=?, last_name=?, email=?, dob=?, gender=?,
                admission_date=?, class_name=?, city=?, state_code=?, country=?
                WHERE id=?
                """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getFirstName());
            ps.setString(2, s.getLastName());
            ps.setString(3, s.getEmail());
            ps.setDate(4, s.getDob());
            ps.setString(5, s.getGender());
            ps.setDate(6, s.getAdmissionDate());
            ps.setString(7, s.getClassName());
            ps.setString(8, s.getCity());
            ps.setString(9, s.getStateCode());
            ps.setString(10, s.getCountry());
            ps.setInt(11, s.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static boolean emailExists(String email, Integer excludeId) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM students WHERE email = ?";

        if (excludeId != null) {
            sql += " AND id != ?";
        }

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            if (excludeId != null) {
                ps.setInt(2, excludeId);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }


    // ===== DELETE STUDENT =====
    public static void deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== HELPER: FIND BY EMAIL (Used for validation) =====
    public static Student getStudentByEmail(String email) {

        Student student = null;

        String sql = "SELECT * FROM students WHERE email = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student = new Student();
                student.setId(rs.getInt("id"));
                student.setFirstName(rs.getString("first_name"));
                student.setLastName(rs.getString("last_name"));
                student.setEmail(rs.getString("email"));
                student.setGender(rs.getString("gender"));
                student.setDob(rs.getDate("dob"));
                student.setAdmissionDate(rs.getDate("admission_date"));
                student.setClassName(rs.getString("class_name"));
                student.setCity(rs.getString("city"));
                student.setStateCode(rs.getString("state_code"));
                student.setCountry(rs.getString("country"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return student; // null if email not found
    }

}
