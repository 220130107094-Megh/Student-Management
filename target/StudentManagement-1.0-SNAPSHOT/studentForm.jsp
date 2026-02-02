<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-10">

            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">
                        ${student.id == null ? "Add Student" : "Edit Student"}
                    </h4>
                </div>

                <div class="card-body">

                    <!-- ERROR MESSAGE -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <p id="ageError" class="text-danger fw-bold"></p>

                    <form action="students" method="post" onsubmit="return validateAge();">

                        <!-- HIDDEN ID -->
                        <input type="hidden" name="id" value="${student.id}">

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">First Name *</label>
                                <input type="text" name="firstName" class="form-control"
                                       value="${student.firstName}" maxlength="50" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Last Name</label>
                                <input type="text" name="lastName" class="form-control"
                                       value="${student.lastName}" maxlength="50">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Email *</label>
                                <input type="email" name="email" class="form-control"
                                       value="${student.email}" maxlength="100" required>
                            </div>

                            <c:if test="${not empty emailError}">
                                <div style="color:red;font-size:13px;margin-top:4px;">
                                        ${emailError}
                                </div>
                            </c:if>


                            <div class="col-md-6">
                                <label class="form-label">Gender *</label>
                                <select name="gender" class="form-select" required>
                                    <option value="">Select</option>
                                    <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Date of Birth * (age >= 18)</label>
                                <input type="date" id="dob" name="dob" class="form-control"
                                       value="${student.dob}" max="<%= java.time.LocalDate.now() %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Date of Admission *</label>
                                <input type="date" name="admissionDate" class="form-control"
                                       value="${student.admissionDate}" max="<%= java.time.LocalDate.now() %>" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Class</label>
                                <input type="text" name="className" class="form-control"
                                       value="${student.className}" maxlength="10">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">City</label>
                                <input type="text" name="city" class="form-control"
                                       value="${student.city}" maxlength="50">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">State Code</label>
                                <input type="text" name="stateCode" class="form-control text-uppercase"
                                       value="${student.stateCode}" maxlength="2">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Country</label>
                                <input type="text" name="country" class="form-control"
                                       value="${student.country}" maxlength="50">
                            </div>
                        </div>


                        <div class="d-flex justify-content-between">
                            <a href="students" class="btn btn-secondary">
                                ⬅ Back
                            </a>

                            <button type="submit" class="btn btn-success">
                                💾 Save Student
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    function validateAge() {
        const dob = document.getElementById("dob").value;
        if (!dob) return false;

        const birthDate = new Date(dob);
        const today = new Date();

        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();

        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        if (age < 18) {
            document.getElementById("ageError").innerText =
                "Age must be at least 18 years.";
            return false;
        }

        document.getElementById("ageError").innerText = "";
        return true;
    }
</script>

</body>
</html>
