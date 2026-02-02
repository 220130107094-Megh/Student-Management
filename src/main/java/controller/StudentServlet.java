package controller;

import dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Student;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;

/**
 -> Main Controller for the application.
 -> Mapped to the URL "/students".

 * It handles two types of requests:
   1. GET: To retrieve data (List students, Delete student, Show Edit Form).
   2. POST: To submit data (Add new student, Update existing student).
**/
@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    // ===== SHOW LIST / HANDLE DELETE / LOAD EDIT FORM =====
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 'action' is a query parameter in the URL (e.g., /students?action=delete&id=5)
        String action = request.getParameter("action");

        // DELETE STUDENT
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id").trim());
            StudentDAO.deleteStudent(id);
            response.sendRedirect(request.getContextPath() + "/students");
            return;
        }

        // EDIT STUDENT
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id").trim());
            Student student = StudentDAO.getStudentById(id);
            request.setAttribute("student", student);
            request.getRequestDispatcher("studentForm.jsp").forward(request, response);
            return;
        }

        // LIST STUDENTS
        List<Student> students = StudentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("manageStudents.jsp").forward(request, response);
    }

    // ===== ADD / UPDATE STUDENT =====
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Extract data from the HTML form inputs
        String idStr = request.getParameter("id"); // Will be null or empty if adding a NEW student
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String className = request.getParameter("className");
        String city = request.getParameter("city");
        String stateCode = request.getParameter("stateCode");
        String country = request.getParameter("country");

        // Parse Dates (HTML5 date inputs return YYYY-MM-DD strings)
        Date dob = Date.valueOf(request.getParameter("dob"));
        Date admissionDate = Date.valueOf(request.getParameter("admissionDate"));

        // 2. SERVER-SIDE VALIDATION: CHECK AGE
        LocalDate birthDate = dob.toLocalDate();
        int age = Period.between(birthDate, LocalDate.now()).getYears();

        if (age < 18) {
            // If invalid, send an error message back to the form
            request.setAttribute("error", "Age must be 18 or above");

            // Re-create the student object to keep the user's input in the form
            Student s = new Student();
            if (idStr != null && !idStr.isEmpty()) {
                s.setId(Integer.parseInt(idStr.trim()));
            }
            s.setFirstName(firstName);
            s.setLastName(lastName);
            s.setEmail(email);
            s.setGender(gender);
            s.setDob(dob);
            s.setAdmissionDate(admissionDate);
            s.setClassName(className);
            s.setCity(city);
            s.setStateCode(stateCode);
            s.setCountry(country);

            request.setAttribute("student", s);
            request.getRequestDispatcher("studentForm.jsp").forward(request, response);
            return;
        }

        // 3. SERVER-SIDE VALIDATION: UNIQUE EMAIL CHECK
        Student existingStudent = StudentDAO.getStudentByEmail(email);

        if (existingStudent != null) {
            /** Logic: If an email exists, we must check if it belongs to another user.
             If (idStr == null) -> We are adding a new user, and email exists -> ERROR.
             If (existing.id != idStr) -> We are editing user A, but took user B's email -> ERROR.
             */
            if (idStr == null || idStr.isEmpty()
                    || existingStudent.getId() != Integer.parseInt(idStr.trim())) {

                request.setAttribute("error", "Email already exists");

                // Repeat code to preserve form input - ideally (previously added input)
                Student s = new Student();
                if (idStr != null && !idStr.isEmpty()) {
                    s.setId(Integer.parseInt(idStr.trim()));
                }
                s.setFirstName(firstName);
                s.setLastName(lastName);
                s.setEmail(email);
                s.setGender(gender);
                s.setDob(dob);
                s.setAdmissionDate(admissionDate);
                s.setClassName(className);
                s.setCity(city);
                s.setStateCode(stateCode);
                s.setCountry(country);

                request.setAttribute("student", s);
                request.getRequestDispatcher("studentForm.jsp").forward(request, response);
                return;
            }
        }

        // 4. SAVE STUDENT
        Student s = new Student();
        s.setFirstName(firstName);
        s.setLastName(lastName);
        s.setEmail(email);
        s.setGender(gender);
        s.setDob(dob);
        s.setAdmissionDate(admissionDate);
        s.setClassName(className);
        s.setCity(city);
        s.setStateCode(stateCode != null ? stateCode.toUpperCase() : null);
        s.setCountry(country);

        // 5. SAVE TO DATABASE
        // If ID is missing, it's an INSERT. If ID exists, it's an UPDATE.
        if (idStr == null || idStr.isEmpty()) {
            if (idStr == null || idStr.isEmpty()) {
                StudentDAO.insertStudent(s);
            } else {
                s.setId(Integer.parseInt(idStr.trim()));
                StudentDAO.updateStudent(s);
            }

            // 6. RETURN TO LIST
            response.sendRedirect(request.getContextPath() + "/students");
        }
    }
}
