<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <link href="css/Gmenu.css" rel="stylesheet" type="text/css"/>
        <title>Perfume Store - Menu</title>
        <style>
            body {
                background-image: url('/img/bgblue (1).jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
                background-attachment: fixed;
            }
            .banner {
                margin-top: 160px;
                position: relative;
                overflow: hidden;
            }
            .banner-slide {
                display: none;
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
            }
            .banner-slide img {
                width: 100%;
                height: auto;
            }
            .container {
                margin-top: 20px;
            }
            .best-seller {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                border: 1px solid #ddd;
                padding: 10px;
                border-radius: 8px;
                height: 100%;
            }
            .best-seller img {
                max-width: 96%;
                max-height: 400px;
                object-fit: cover;
            }
            .name-perfume {
                height: 50px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .perfume-info {
                margin-top: 10px;
            }
            .price-section {
                display: flex;
                justify-content: space-between;
            }
            .perfume-btn {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }
            .perfume-btn button {
                flex: 1;
                margin: 0 5px;
            }
            .tittle img {
                width: 100%;
                max-width: 300px;
                height: auto;
            }
            .search-main {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-container {
                flex: 1;
                margin-right: 10px;
            }
            .filter {
                flex: 1;
                display: flex;
                align-items: center;
            }
            .select-box {
                width: 100%;
                padding: 8px;
                font-size: 16px;
            }
            .search-box {
                margin-top: 20px;
                height: 50px;
                width: 90%;
                padding: 8px;
                font-size: 16px;
            }
        </style>
    </head>

    <body>
        <%@include file="headerGuest.jsp"%>
        <div class="banner">
            <div class="banner-slide">
                <img src="../img/BannerBS.png" alt=""/>
            </div>
            <div class="banner-slide">
                <img src="../img/banner2.png" alt=""/>
            </div>
            <div class="banner-slide">
                <img src="../img/sale.png" alt=""/>
            </div>
        </div>
        <div class="container">
            <main>
                <div class="search-main d-flex align-items-center mb-4">
                    <div class="search-container me-2 flex-grow-1">
                        <input oninput="searchByName(this)" type="text" class="search-box" id="searchInput" placeholder="Search Name...">
                    </div>
                    <div class="filter">
                        <label style="font-weight: 500; font-size: 20px; color: #C21010;">Category filter: </label>
                        <select class="select-box" oninput="searchByCategory(this)" id="select">
                            <option value="" selected>All</option>
                            <c:forEach var="c" items="${requestScope.categories}">
                                <option value="${c.getId()}">${c.getName()}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="row row-cols-1 row-cols-md-4 g-4 list-menu mb-5" id="content">
                    <c:forEach var="perfume" items="${requestScope.perfumes}">
                        <div class="col">
                            <div class="best-seller">
                                <img src="${perfume.getImg()}" alt="">
                                <div class="name-perfume">
                                    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
                                    <c:choose>
                                        <c:when test="${fn:length(perfume.getName()) > 15}">
                                            ${fn:substring(perfume.getName(), 0, 15)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${perfume.getName()}
                                        </c:otherwise>
                                    </c:choose> 
                                </div>
                                <hr>
                                <div class="perfume-info">
                                    <div class="price-section">
                                        <p>Price:</p>
                                        <c:choose>
                                            <c:when test="${perfume.getSale() == 0}">
                                                <p class="discounted-price">${perfume.getRealPrice()}$</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="original-price">${perfume.getPrice()}$</p>
                                                <p class="discounted-price">${perfume.getRealPrice()}$</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <p>Units Sold: (15+)</p>
                                </div>
                                <div class="perfume-btn">
                                    <c:choose>
                                        <c:when test="${perfume.getStatus() eq 'Sold Out'}">
                                            <button style="background-color: grey">Sold Out</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button onclick="addToCart('0')"><ion-icon style="font-size: 22px;" name="cart"></ion-icon></button>
                                                </c:otherwise>
                                            </c:choose>
                                    <button onclick="viewPerfume('${perfume.getId()}')">View</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </main>
        </div>
        <%@include file="footerGuest.jsp"%>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                        $(document).ready(function () {
                                            var currentIndex = 0;
                                            var slides = $(".banner-slide");

                                            function showSlide(index) {
                                                slides.hide();
                                                slides.eq(index).fadeIn();
                                            }

                                            function nextSlide() {
                                                currentIndex = (currentIndex + 1) % slides.length;
                                                showSlide(currentIndex);
                                            }

                                            showSlide(currentIndex);

                                            setInterval(nextSlide, 5000);
                                        });

                                        function viewPerfume(id) {
                                            window.location = "/guest/perfumeDetailGuest?id=" + id;
                                        }

                                        function addToCart(id) {
                                            Swal.fire({
                                                title: '',
                                                text: "You have to login to add to cart",
                                                icon: 'warning',
                                                showCancelButton: true,
                                                confirmButtonColor: '#3085d6',
                                                cancelButtonColor: '#d33',
                                                confirmButtonText: 'Log in now'
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    window.location = "/guest/loginGuest";
                                                }
                                            })
                                        }

                                        function searchByName(param) {
                                            var txtSearch = param.value;
                                            document.getElementById('select').value = "";
                                            $.ajax({
                                                url: "/searchName",
                                                type: "get",
                                                data: {
                                                    txt: txtSearch
                                                },
                                                success: function (data) {
                                                    var row = document.getElementById("content");
                                                    row.innerHTML = data;
                                                },
                                                error: function (xhr) {
                                                    console.log(error);
                                                }
                                            });
                                        }

                                        function searchByCategory(param) {
                                            var txtSearch = param.value;
                                            document.getElementById('searchInput').value = "";
                                            $.ajax({
                                                url: "/searchCategory",
                                                type: "get",
                                                data: {
                                                    txt: txtSearch
                                                },
                                                success: function (data) {
                                                    var row = document.getElementById("content");
                                                    row.innerHTML = data;
                                                },
                                                error: function (xhr) {
                                                    console.log(error);
                                                }
                                            });
                                        }
        </script>
    </body>

</html>
