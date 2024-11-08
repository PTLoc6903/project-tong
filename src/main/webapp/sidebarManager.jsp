<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <title>Perfume Store Manager</title>
        <style>
            .sidebar .side-menu a{
                color: black;
                display: block;
                padding: 10px;
                transition: 0.3s;
                font-size: 18px;
            }
            .side-menu .sub-menu {
                display: none;
                position: absolute;
                background-color: white;
                list-style: none;
                padding: 0;
                margin: 0;
                top: 100%;
                left: 0;
                width: 200px;
                z-index: 1000;
            }
            body {
                margin: 0;
                font-family: 'Poppins', sans-serif;
            }

            aside {
                width: 100%;
                background-color: #333;
                color: #fff;
                text-align: center;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }

            .sidebar {
                width: 100%;
                height: 135px;
                background-color: #FFB6C1;
                padding: 5px 0;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .logo-container {
                display: flex;
                align-items: center;
                margin-left: 30px; /* Adjust as needed for alignment */
            }

            .logo-container img {
                width: 120px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .logo-side {
                color: #ecf0f1;
                font-size: 24px;
                margin-left: 20px; /* Space between logo and menu items */
            }

            .Campus {
                color: #C21010;
                font-weight: bold;
                font-size: 2rem;
                letter-spacing: 2px;
                margin-right: 10px;
            }

            .side-menu {
                display: flex;
                align-items: center;
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .side-menu li {
                margin-right: 20px; /* Spacing between menu items */
                position: relative;
            }

            .side-menu a {
                color: black;
                display: inline-block;
                padding: 10px 20px;
                transition: 0.3s;
                font-size: 18px;
                text-decoration: none;
            }

            .side-menu a:hover {
                background-color: #C21010;
                color: #ecf0f1;
                border-bottom: 4px solid #C21010;
            }


            .side-menu li:hover .sub-menu {
                display: block;
            }

            .sub-menu li {
                display: block;
            }

            .sub-menu a {
                color: white;
                display: block;
                padding: 10px;
                text-align: left;
            }

            .sub-menu a:hover {
                background-color: #C21010;
                color: #ecf0f1;
                border-left: 4px solid #C21010;
            }

            .logout {
                color: #ffffff;
                padding: 10px 20px;
                transition: 0.3s;
                font-size: 18px;
                text-decoration: none;
                display: inline-block;
                margin-right: 20px;
            }

            .side-menu li.active a {
                background-color: black;
                color: white;
                border-bottom: 4px solid black;
            }

            .content {
                padding-top: 145px; /* Adjusted height of the fixed sidebar */
            }
        </style>
    </head>
    <body>
        <aside>
            <div class="sidebar">
                <div class="logo-container">
                    <img src="../img/logo1.jpg" alt="logo Perfume Store">
                    <a href="/analyticsManager" id="logo" style="font-size: 30px;text-decoration: none;">
                        <div class="Campus">Perfume Store</div>
                    </a>
                    <div class="Munchines"  style="font-size: 30px;font-weight:bolder">Manager</div>
                </div>
                <ul class="side-menu">
                    <li id="analyticsManager"><a href="analyticsManager"><i class='bx bx-home-heart'></i> Analysis</a></li>
                    <li id="orderManager"><a href="orderManager"><i class='bx bx-store'></i> Order</a></li>
                    <li id="listMenuManager">
                        <a href="listMenuManager"><i class='bx bx-notepad'></i> Product</a>
                        <ul class="sub-menu">
                            <li><a href="listMenuManager">List Product</a></li>
                            <li><a href="addPerfumeManager">Add Perfume</a></li>
                        </ul>
                    </li>
                    <li id="employeeManager">
                        <a href="employeeManager"><i class='bx bx-group'></i> Employee</a>
                        <ul class="sub-menu">
                            <li ><a href="employeeManager" style="background: white; color: black;">List Employee</a></li>
                            <li ><a href="createAccountManager" style="background: white; color: black;">Create Account</a></li>
                        </ul>
                    </li>
                    <li id="customerManager"><a href="customerManager"><i class='bx bxs-user-badge'></i> Customer</a></li>
                    <li id="logoutManager"><a href="logoutManager" class="logout"><i class='bx bx-exit'></i> Logout</a></li>
                </ul>
            </div>
        </aside>
        <div class="content">
            <!-- Your page content goes here -->
        </div>
        <script>
            // JavaScript to add active class to current link in sidebar
            document.addEventListener("DOMContentLoaded", function () {
                var currentLocation = window.location.href;

                // Loop through each link in the sidebar
                var menuItems = document.querySelectorAll('.side-menu a');
                menuItems.forEach(function (item) {
                    // Check if the link's href matches the current page URL
                    if (item.href === currentLocation) {
                        // Add 'active' class to the parent <li> element
                        item.parentNode.classList.add('active');
                    }
                });
            });
        </script>
    </body>
</html>
