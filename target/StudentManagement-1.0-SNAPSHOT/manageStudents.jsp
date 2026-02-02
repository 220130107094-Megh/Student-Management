<%@ page import="java.util.*, model.Student" %>
<%@ page import="java.time.*, java.time.temporal.ChronoUnit" %>

<html>
<head>
    <title>Student Management</title>

        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: #f4f6f9;
                margin: 0;
                padding: 20px;
            }

            /* Top bar */
            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .top-bar h2 {
                margin: 0;
                font-size: 26px;
            }

            /* Add button */
            .add-btn {
                background: #0d6efd;
                color: white;
                padding: 10px 18px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
            }
            .add-btn:hover {
                background: #084298;
            }

            /* Table */
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            #table-container{
               overflow-y: auto;
                max-height:400px;
            }

            #studentTable {
                width: 100%;
                border-collapse: collapse;
            }

            #studentTable thead th {
                position: sticky;
                top: 0;
                background: #7cc8ff;
                z-index: 2;
            }

            th, td {
                border: 1px solid #ccc;   /* creates row + column separators */
                padding: 8px;
                text-align: center;
            }


            th {
                background: #73C2FB;
                padding: 12px;
                text-align: center;
            }

            td {
                padding: 12px;
                text-align: center;
                border-top: 1px solid #ddd;
            }

            /* Row hover */
            tr:hover {
                background: #f8f9fa;
            }

            /* Action buttons */
            .action-btn {
                padding: 6px 14px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 14px;
                margin: 0 3px;
            }

            .edit-btn {
                background: #00A86B;
                color: white;
            }
            .edit-btn:hover {
                background: #146c43;
            }

            .delete-btn {
                background: #dc3545;
                color: white;
            }
            .delete-btn:hover {
                background: #b02a37;
            }
        </style>



</head>

<body>

<div style="text-align: center; margin-bottom: 25px; font-weight: 600; font-size: 40px">Student Table</div>
<div></div>

<div style="
    display:flex; justify-content:flex-end; gap:10px; align-items:center; margin-left:auto;
    margin-bottom: 10px;
">

    <!-- Search box -->
    <div style="display:flex; align-items:center;">

        <input type="text" id="searchInput"
               placeholder="Enter your search term..."
               style="
               padding:8px 12px;
               width:220px;
               border:1px solid #ccc;
               border-right:none;
               border-radius:4px 0 0 4px;
               outline:none;
           ">

        <div onclick="searchTable()" style="
            background:#f28c28;
            border-radius:0;
            cursor:pointer;
            color:white;
        ">
            <button type="button" onclick="searchTable()"
                    style="background-color:#ff8c00; color:white; border:none; padding:8px 14px; border-radius:0; cursor:pointer; font-size:14px;">
                 Search
            </button>
        </div>

    </div>

    <!-- Filter dropdown -->
    <select id="filterType" style="padding:6px 10px; border:1px solid #ccc; border-radius:5px;">
        <option value="">All</option>
        <option value="fname">First Name</option>
        <option value="lname">Last Name</option>
        <option value="email">E-Mail</option>
        <option value="location">Location</option>
        <option value="gender">Gender</option>
    </select>

<%--    <input type="text" id="filterValue"--%>
<%--           placeholder="Enter value..."--%>
<%--           style="padding:6px 10px; border:1px solid #ccc; border-radius:5px;"--%>
<%--           onkeyup="filterTable()">--%>


    <a href="studentForm.jsp"
       style="
       background-color: #0d6efd;
       color: white;
       padding: 10px 16px;
       text-decoration: none;
       border-radius: 6px;
       font-size: 14px;
       font-weight: 500;
       transition: background-color 0.2s;"
       onmouseover="this.style.backgroundColor='#084298'"
       onmouseout="this.style.backgroundColor='#0d6efd'">
        Add Student
    </a>
</div>

<div id="table-container">
<table id="studentTable"
       style="border-collapse: collapse; text-align: center;">

<thead>
    <tr>
        <th style="text-align: center; padding: 10px">First Name</th>
        <th style="text-align: center; padding: 10px">Last Name</th>
        <th style="text-align: center; padding: 10px">Gender</th>
        <th style="text-align: center; padding: 10px">Age</th>
        <th style="text-align: center; padding: 10px">Class</th>
        <th style="text-align: center; padding: 10px">Location</th>
        <th style="text-align: center; padding: 10px">Action</th>
    </tr>
</thead>


<tbody>

    <%
        List<Student> list = (List<Student>) request.getAttribute("students");

        for (Student s : list) {
            String age = "";
            if (s.getDob() != null) {
                LocalDate birth = s.getDob().toLocalDate();
                LocalDate now = LocalDate.now();

                long days = ChronoUnit.DAYS.between(birth, now);
                long years = days / 365;
                long weeks = (days % 365) / 7;
                long remDays = (days % 365) % 7;

                age = years + " years, " + weeks + " weeks, " + remDays + " days";
            }
    %>
    <tr>
        <td style="text-align: center; padding: 10px"><%= s.getFirstName() %></td>
        <td style="text-align: center; padding: 10px"><%= s.getLastName() %></td>
        <td style="display: none;"><%= s.getEmail()%></td>
        <td style="text-align: center; padding: 10px"><%= s.getGender() %></td>
        <td style="text-align: center; padding: 10px"><%= age %></td>
        <td style="text-align: center; padding: 10px"><%= s.getClassName() %></td>
        <td style="text-align: center; padding: 10px">
            <%= s.getCity() %>,
            <%= s.getStateCode() %>,
            <%= s.getCountry() %>
        </td>
        <td style="text-align: center; padding: 10px">
            <a href="students?action=edit&id=<%= s.getId()%>"
               style="
               padding: 6px 12px;
               background-color: #00A86B;
               color: white;
               text-decoration: none;
               border-radius: 5px;
               font-size: 13px;
               margin-right: 6px;
               display: inline-block;"
               onmouseover="this.style.backgroundColor='#0B6623'"
               onmouseout="this.style.backgroundColor='#00A86B'">
                Edit
            </a>

            <a href="students?action=delete&id=<%= s.getId()%>"
               onclick="return confirm('Are you sure you want to delete this student?')"
               style="
               padding: 6px 12px;
               background-color: #dc3545;
               color: white;
               text-decoration: none;
               border-radius: 5px;
               font-size: 13px;
               display: inline-block;"
               onmouseover="this.style.backgroundColor='#a71d2a'"
               onmouseout="this.style.backgroundColor='#dc3545'">
                Delete
            </a>
        </td>

    </tr>
    <% } %>
</tbody>

</table>



    <div id="noResultMsg" style="display:none; color:red; margin-top:25px; font-weight:bold; padding-left: 700px; font-size: 20px">
        No student found
    </div>
</div>

<div id="pagination" style="margin-top:15px; text-align:center;"></div>

</body>
</html>


<script>
    function searchTable() {
        let filterType = document.getElementById("filterType").value;
        let input = document.getElementById("searchInput").value.toLowerCase();
        let table = document.getElementById("studentTable");
        let rows = table.getElementsByTagName("tr");

        let found = false;

        for (let i = 1; i < rows.length; i++) { // skip header row
            let cols = rows[i].getElementsByTagName("td");

            let firstName = cols[0].innerText.toLowerCase();
            let lastName  = cols[1].innerText.toLowerCase();
            let email     = cols[2].innerText.toLowerCase();
            let gender    = cols[3].innerText.toLowerCase();
            let age       = cols[4].innerText.toLowerCase();
            let className = cols[5].innerText.toLowerCase();
            let location  = cols[6].innerText.toLowerCase();

            let match = false;

            if (filterType === "fname") {
                match = firstName.includes(input);
            } else if (filterType === "lname") {
                match = lastName.includes(input);
            } else if (filterType === "location") {
                match = location.includes(input);
            } else if (filterType === "email"){
                match = email.includes(input)
            } else if (filterType === "gender") {
                match = gender.includes(input);
            } else { // ALL
                match =
                    firstName.includes(input) ||
                    lastName.includes(input) ||
                    email.includes(input) ||
                    location.includes(input) ||
                    gender.includes(input);
            }

            if (match) {
                rows[i].style.display = "";
                found = true;
            } else {
                rows[i].style.display = "none";
            }

            // if (
            //     firstName.includes(input) ||
            //     lastName.includes(input) ||
            //     location.includes(input) ||
            //     email.includes(input)
            // ) {
            //     rows[i].style.display = "";
            //     found = true;
            // } else {
            //     rows[i].style.display = "none";
            // }
        }

        // Show or hide "No student found"
        document.getElementById("noResultMsg").style.display = found ? "none" : "block";
    }

        let currentPage = 1;
        let rowsPerPage = 10;

        function paginateTable() {
        let table = document.getElementById("studentTable");
        let rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

        let totalRows = rows.length;
        let totalPages = Math.ceil(totalRows / rowsPerPage);

        for (let i = 0; i < totalRows; i++) {
        rows[i].style.display = "none";
    }

        let start = (currentPage - 1) * rowsPerPage;
        let end = start + rowsPerPage;

        for (let i = start; i < end && i < totalRows; i++) {
        rows[i].style.display = "";
    }

        renderPagination(totalPages);
    }

        function renderPagination(totalPages) {
        let paginationDiv = document.getElementById("pagination");
        paginationDiv.innerHTML = "";

        let prevBtn = document.createElement("button");
        prevBtn.innerText = "Prev";
        prevBtn.onclick = function () {
        if (currentPage > 1) {
        currentPage--;
        paginateTable();
    }
    };
        paginationDiv.appendChild(prevBtn);

        for (let i = 1; i <= totalPages; i++) {
        let btn = document.createElement("button");
        btn.innerText = i;
        btn.style.margin = "0 5px";
        btn.onclick = function () {
        currentPage = i;
        paginateTable();
    };

        if (i === currentPage) {
        btn.style.fontWeight = "bold";
        btn.style.backgroundColor = "#0d6efd";
        btn.style.color = "white";
    }

        paginationDiv.appendChild(btn);
    }

        let nextBtn = document.createElement("button");
        nextBtn.innerText = "Next";
        nextBtn.onclick = function () {
        if (currentPage < totalPages) {
        currentPage++;
        paginateTable();
    }
    };
        paginationDiv.appendChild(nextBtn);
    }

        /* 🔍 Your existing search function must call paginateTable() at end */
        function searchTable() {
        let filterType = document.getElementById("filterType").value;
        let input = document.getElementById("searchInput").value.toLowerCase();

        let table = document.getElementById("studentTable");
        let rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

        let found = false;

        for (let i = 0; i < rows.length; i++) {
        let cols = rows[i].getElementsByTagName("td");

        let firstName = cols[0].innerText.toLowerCase();
        let lastName  = cols[1].innerText.toLowerCase();
        let email     = cols[2].innerText.toLowerCase();
        let gender    = cols[3].innerText.toLowerCase();
        let location  = cols[6].innerText.toLowerCase();

        let match = false;

        if (filterType === "fname") {
        match = firstName.includes(input);
    } else if (filterType === "lname") {
        match = lastName.includes(input);
    } else if (filterType === "location") {
        match = location.includes(input);
    } else if (filterType === "gender") {
        match = gender.includes(input);
    } else {
        match =
        firstName.includes(input) ||
        lastName.includes(input) ||
        email.includes(input) ||
        location.includes(input) ||
        gender.includes(input);
    }

        if (match) {
        rows[i].style.display = "";
        found = true;
    } else {
        rows[i].style.display = "none";
    }
    }

        document.getElementById("noResultMsg").style.display = found ? "none" : "block";

        currentPage = 1; // reset page after search
        paginateTable();
    }

        /* Run pagination when page loads */
        window.onload = function () {
        paginateTable();
    };



</script>


