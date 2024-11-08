<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="css/perfumeDetail.css">
        <title>Perfume Store manager</title>

    </head>

    <body>

        <div class="container-i">
            <!-- Sidebar -->

            <%@include file="sidebarManager.jsp" %>

            <!-- End of Sidebar -->
            <!-- Main Content -->
            <main>
                <%
                    String username = (String) request.getSession().getAttribute("username");
                    if (username == null) {
                        response.sendRedirect("/login");
                    }
                %>
                <div class="header">
                    <div class="name-tittle">
                        Perfume Details
                        <div class="perfume-id">
                            Perfume ID: ${infoPerfume.id}
                        </div>
                    </div>
                    <div class="user-info">
                        <p>Hey, <b><%= request.getSession().getAttribute("username")%></b></p>

                        <small class="text-muted">Admin</small>
                    </div>
                </div>
                <!-- Perfume Detail -->
                <div class="main-perfume-details">
                    <div class="perfume-detail">
                        <div class="perfume-img">
                            <img src="${infoPerfume.img}" alt="">
                        </div>
                        <div class="perfume-edit">
                            <p>${infoPerfume.name}</p>
                            <p><span class="bold-numbers">Sale Price: </span> ${infoPerfume.getRealPrice()}$</p>
                            <button type="submit" onclick="updatePerfume('${infoPerfume.id}')">Update</button>
                            <button type="submit" onclick="confirmDeletePerfume('${infoPerfume.id}')">
                                Delete
                            </button>
                        </div>
                    </div>
                    <div class="perfume-info-detail">
                        <h2>Perfume Information</h2>
                        <hr>
                        <p><span class="bold-numbers">Perfume ID:</span> ${infoPerfume.id}</p>
                        <p><span class="bold-numbers">Perfume Name:</span> ${infoPerfume.name}</p>
                        <p><span class="bold-numbers">Category Name:</span> ${infoPerfume.caterogyName}</p>
                        <p><span class="bold-numbers">Historical Cost: </span> ${infoPerfume.price}$</p>
                        <p><span class="bold-numbers">Sale:</span> ${infoPerfume.sale}%</p>
                        <p><span class="bold-numbers">Description:</span> ${infoPerfume.description}</p>
                        <p><span class="bold-numbers">Status:</span> ${infoPerfume.status}</p>
                        <p><span class="bold-numbers">Total Order:</span> ${infoPerfume.numOrder}</p>
                    </div>
                </div>

                <div class="btn-add-product">
                    <button type="submit" onclick="addPerfume()">
                        Add Perfume
                    </button>
                </div>
                <!-- End Perfume Detail -->
                <!-- List Menu -->

                <div class="list-menu row">
                    <c:forEach var="s" items="${requestScope.suggestList}">
                        <div class="best-seller col-md-3">
                            <a href="perfumeDetailsManager?bid=${s.id}">
                                <img src="${s.img}" alt="">
                                <div class="name-perfume">
                                    <p>
                                        <c:choose>
                                            <c:when test="${fn:length(s.name) > 14}">
                                                ${fn:substring(s.name, 0, 14)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${s.name}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </a>
                            <div class="perfume-info">
                                <hr>
                                <c:choose>
                                    <c:when test="${s.status eq 'Sold Out'}">
                                        <div class="price-section">
                                            <p style="color: #888">Price:</p>
                                            <c:if test="${s.sale ne 0}">
                                                <p class="original-price">${s.price}$</p>
                                            </c:if>
                                            <p  style="color: #888" class="discounted-price">${s.getRealPrice()}$</p>
                                        </div>
                                        <p style="color: #888">Status: ${s.status}</p>
                                        <p style="color: #888">Total Order: ${s.numOrder}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="price-section">
                                            <p>Price:</p>
                                            <c:if test="${s.sale ne 0}">
                                                <p class="original-price">${s.price}$</p>
                                            </c:if>
                                            <p class="discounted-price">${s.getRealPrice()}$</p>
                                        </div>
                                        <p>Status: ${s.status}</p>
                                        <p>Total Order: ${s.numOrder}</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="perfume-btn">
                                <button type="submit" onclick="updatePerfume('${s.id}')">Update</button>
                                <button type="submit" onclick="confirmDeletePerfume('${s.id}')">
                                    Delete
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- End List Menu -->
            </main>
            <!-- End of Main Content -->



        </div>
    </body>
    <script>
        function confirmDeletePerfume(perfumeId) {
            Swal.fire({
                title: 'Are you sure?',
                text: 'Do you really want to delete this perfume?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'No, cancel!',
                reverseButtons: false
            }).then((result) => {
                if (result.isConfirmed) {
                    // Nếu người dùng xác nhận xóa
                    window.location = "deletePerfumeManager?bid=" + perfumeId;
                }
            });
        }
        function updatePerfume(perfumeId) {
            window.location = "updatePerfumeManager?bid=" + perfumeId;
        }
        function addPerfume() {
            window.location = "addPerfumeManager";
        }
    </script>
</html>