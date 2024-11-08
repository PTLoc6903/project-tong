<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="css/employeeManagement.css">
        <title>Perfume Store manager</title>

    </head>

    <body>

        <div class="container-i">
            <!-- Sidebar -->
            <%@include file="sidebarManager.jsp" %>

            <!-- End of Sidebar -->
            <!-- Main Content -->
            <main style="background: white;">
                <%
                    String username = (String) request.getSession().getAttribute("username");
                    if (username == null) {
                        response.sendRedirect("/login");
                    }
                %>                
                <div class="header" style="color: black">
                    <div class="logo-tittle">
                   <img src="/img/logo.jpg" style="width: 120px;" alt=""/>
                    </div>

                    <div class="name-tittle">
                        Employee Management
                    </div>

                    <div class="user-info">

                        <p>Hey, <b><%= request.getSession().getAttribute("username") %></b></p>

                        <small class="text-muted">Admin</small>
                    </div>
                </div>
                <!-- Customer Management Table -->
                <div class="btn-create-acc" onclick="createAcc()">

                    <button>
                        Create Account
                    </button>
                </div>
                <div class="customer-table" style="border:2px solid">
                    <div class="search-main">
                        <h2 class="customer-list">Employee List</h2>
                        <select class="select-box" id="filterSelect">
                            <option value="name" selected>Name</option>

                            <option value="phone">Phone</option>
                            <option value="orders">Orders Served</option>
                        </select>
                        <div class="search-container">
                            <input type="text" class="search-box" id="searchInput" placeholder="Search..." style="border:1px solid">
                        </div>
                    </div>
                    <div id="tableContainer">
                        <div class="green">
                        <table>
                            <thead>
                                <tr>

                                    <th data-filter="name" onclick="sortTable(0)" style="background-color: white; color: black;">Name</th>
                                    <th data-filter="phone" onclick="sortTable(1)" style="background-color: white; color: black;">Phone</th>
                                    <th data-filter="orders" onclick="sortTable(2)" style="background-color: white; color: black;">Orders Served</th>

                                    <th data-filter="details" style="background-color: white; color: black;">Details</th>
                                </tr>
                            </thead>
                            <tbody id="itemList">

                                <c:forEach var="m" items="${requestScope.listEmpM}">
                                    <tr>
                                        <td>${m.name}</td>
                                        <td>${m.phone}</td>
                                        <td>${m.order_served}</td>
                                        <td><a class="view" href="employeeDetailManager?bid=${m.phone}">View</a></td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                            </div>
                        <div class="btn-pagination" id="pagination">
                            <button id="prevButton"><i class='bx bx-left-arrow-circle'></i></button>
                            <button id="nextButton"><i class='bx bx-right-arrow-circle'></i></button>
                        </div>
                    </div>
                </div>
                <!-- End of Perfume Management Orders -->
                <!-- Honor Employee -->
<!--                <div class="honor-employee-table">
                    <h2>Honor Employee</h2>
                    <table>
                        <thead>
                            <tr>

                                <th>Name</th>
                                <th>Phone</th>

                                <th>Orders Served</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${requestScope.listEmpH}">
                                <tr>
                                    <td>${h.name}</td>
                                    <td>${h.phone}</td>
                                    <td>${h.order_served}</td>
                                    <td><a class="view" href="MemployeeDetail?bid=${h.phone}">View</a></td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>
                 End of Honor Customer -->
            </main>
            <!-- End of Main Content -->



        </div>

    </body>
    <script src="javascript/employeeManagement.js" type="text/javascript"></script>

    <script>
                                        function createAcc() {
                                            window.location = "createAccountManager";
                                        }
    </script>

</html>