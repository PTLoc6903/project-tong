/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerManager;

import daoManager.CategoryDAO;
import daoManager.PerfumeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;

import modelManager.Perfume;

/**
 *
 * @author Admin
 */
public class AddPerfumeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPerfumeManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPerfumeManager at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PerfumeDAO dao = new PerfumeDAO();
            String perfumeId = dao.getIDForNewPerfume();
            request.setAttribute("perfume_id", perfumeId);
            request.getRequestDispatcher("addPerfumeManager.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println("addPerfume" + ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CategoryDAO categoryDao = new CategoryDAO();
            PerfumeDAO perfumeDao = new PerfumeDAO();
            String perfumeId = request.getParameter("perfume_id");
            String categoryId = categoryDao.getCategoryID(request.getParameter("category_name"));
            String perfumeName = request.getParameter("perfume_name");
            double price = Double.parseDouble(request.getParameter("price"));
            double sale = Double.parseDouble(request.getParameter("sale"));
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String imageSrc = request.getParameter("imageSrc");
            String imageUrl = request.getParameter("imageUrl");
            Perfume perfume;
            if (imageUrl.length() > 0) {
                perfume = new Perfume(perfumeId, categoryId, perfumeName, price, sale, description, status, imageUrl);
            } else {
                perfume = new Perfume(perfumeId, categoryId, perfumeName, price, sale, description, status, imageSrc);
            }
            perfumeDao.add(perfume);
            response.sendRedirect("/perfumeDetailsManager?bid=" + perfumeId);
        } catch (Exception ex) {
            System.out.println("addPerfumePost" + ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
