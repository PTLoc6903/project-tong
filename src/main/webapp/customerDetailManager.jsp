<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="css/customerDetail.css">
        <title>Perfume Store Manager</title>
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

                <div class="header" style="height: 150px; background: white; padding: 0 10px">
                    <div class="logo-tittle">
                        <img src="/img/logo.jpg" style="width: 120px;" alt=""/>
                    </div>

                    <div class="name-tittle" style="color: black; font-size: 20px; font-weight: 600">
                        Customer Details
                        <div class="order-id">
                            Phone: ${phoneCus}
                        </div>
                    </div>

                    <div class="user-info" style="color:  black ;font-weight:800">
                        <p>Hey, <b><%= username%></b></p>
                        <small class="text-muted">Admin</small>
                    </div>
                </div>

                <!-- Customer Details Information -->
                <ul class="customer-details-info" style="margin-top: -20px">
                    <li style="background: white">
                        <h2 style="font-size:35px ">Customer Information</h2>
                        <hr>
                        <p style="font-size:20px ">Name: ${infoCus.name}</p>
                        <p style="font-size:20px ">Phone: ${infoCus.phone}</p>
                        <p style="font-size:20px ">Email: ${infoCus.email}</p>
                        <p style="font-size:20px ">Address: ${infoCus.address}</p>
                        <p style="font-size:20px ">Birthday: ${birthday}</p>
                        <p style="font-size:20px ">Number of successful orders: ${infoCus.numberOrder}</p>
                        <p style="font-size:20px ">Total spending: ${infoCus.totalSpending}$</p>
                        <p style="font-size:20px ">Rejected orders: ${infoCus.cancel_count}</p>
                        <p style="font-size:20px ">Account Creation Date: ${dateCreate}</p>
                        <p style="font-size:20px ">Account Status: ${infoCus.cus_status}</p>
                    </li>
                    <li style="background: white;">
                        <h2>Order History</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Status</th>
                                    <th>Date Order</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="h" items="${requestScope.historyOrder}">
                                    <tr>
                                        <td><a href="orderDetailsManager?bid=${h.getOrd_id()}">${h.getOrd_id()}</a></td>
                                            <c:choose>
                                                <c:when test="${h.getOrd_status() eq 'Cancelled' || h.getOrd_status() eq 'Rejected'}">
                                                <td style="color: #C21010;">${h.getOrd_status()}</td>
                                            </c:when>
                                            <c:when test="${h.getOrd_status() eq 'Waiting' || h.getOrd_status() eq 'Preparing'}">
                                                <td style="color: #0397d1;">${h.getOrd_status()}</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td style="color: #1ec708;">${h.getOrd_status()}</td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>${h.getOrd_date()}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="btn-pagination" id="pagination" style="display: flex;justify-content: center;margin-top: 25px; gap:1.5rem; height: 50px; ">
                            <button id="prevButton" onclick="prevPage()">Previous</button>
                            <button id="nextButton" onclick="nextPage()">Next</button>
                        </div>
                    </li>
                </ul>

                <!-- Buttons -->
                <!-- Buttons -->
                <div class="btn-detail" style="gap:1.5rem;">
                    <div class="btn-delete-cus" >
                        <c:choose>
                            <c:when test="${statusAcc ne 'Deleted'}">
                                <button type="submit" onclick="deleteCus('${phoneCus}')" class="btn-delete" style="border-radius: 25px; border: solid 1px red; margin-bottom: 20px;background: red">
                                    Delete
                                </button>
                            </c:when>
                        </c:choose>
                    </div>
                    <div class="btn-back-cus">
                        <button onclick="window.location.href = '/analyticsManager'" class="btn-back" style="border-radius: 25px; border: solid 1px blue; margin-bottom: 20px;background: blue; margin-right: 20px">Back</button>
                    </div>
                </div>

            </main>
            <!-- End of Main Content -->
        </div>
    </body>
    <style>
        th, td{
            padding: 10px;
        }
        .customer-details-info li {
            border-radius:  25px;
            border: 1px solid;
        }
        .customer-details-info li{
            margin: 7px;
        }
        li::marker {
            content: none;
        }
    </style>
    <script>
        let currentPage = 1;
        const itemsPerPage = 5; // Change this to the number of orders you want to display per page

        function showPage(page) {
            const rows = document.querySelectorAll("tbody tr");
            const totalRows = rows.length;
            const totalPages = Math.ceil(totalRows / itemsPerPage);

            // Hide all rows
            rows.forEach((row, index) => {
                if (index >= (page - 1) * itemsPerPage && index < page * itemsPerPage) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            // Disable buttons if at the beginning or end
            document.getElementById('prevButton').disabled = page === 1;
            document.getElementById('nextButton').disabled = page === totalPages;
        }

        function prevPage() {
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage);
            }
        }

        function nextPage() {
            const totalRows = document.querySelectorAll("tbody tr").length;
            const totalPages = Math.ceil(totalRows / itemsPerPage);
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        }

        // Initial call to display the first page
        showPage(currentPage);

        function deleteCus(phone) {
            Swal.fire({
                title: 'Are you sure?',
                text: 'Do you really want to delete this customer?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'No, cancel!',
                reverseButtons: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location = "deleteCustomerManager?bid=" + phone;
                }
            });
        }

        function blockCus(phone, status) {
            const action = status === "Available" ? "Mblock" : "Munblock";
            Swal.fire({
                title: "Are you sure you want to " + action + " this customer?",
                text: "This will " + action + " the customer's account.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: "Yes, " + action + " it!",
                cancelButtonText: 'No, cancel',
                reverseButtons: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location = "blockCustomerManager?bid=" + phone + "&st=" + status;
                }
            });
        }
    </script>

</html>
