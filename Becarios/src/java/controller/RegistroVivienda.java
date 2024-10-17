/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author carla
 */
@WebServlet(name = "RegistroVivienda", urlPatterns = {"/registro_vivienda"})
public class RegistroVivienda extends HttpServlet {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

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
            out.println("<title>Servlet RegistroVivienda</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistroVivienda at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String calle = request.getParameter("calle");
        String colonia = request.getParameter("colonia");
        String numero = request.getParameter("numero");
        String cp = request.getParameter("cp");
        String curp = request.getParameter("curp");

        try {
            ConnectionBD connectionBD = new ConnectionBD();
            conn = connectionBD.getConnectionBD();

            String sql = "INSERT INTO vivienda (calle, colonia, numero, cp, curp) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            ps.setString(1, calle);
            ps.setString(2, colonia);
            ps.setString(3, numero);
            ps.setString(4, cp);
            ps.setString(5, curp);

            int rowsAffected = ps.executeUpdate();

            try ( PrintWriter out = response.getWriter()) {
                response.setContentType("text/html;charset=UTF-8");
                if (rowsAffected > 0) {
                    out.println("<h1>Registro de vivienda exitoso</h1>");
                    response.sendRedirect("/becarios/jsp/becario.jsp");
                } else {
                    out.println("<h1>Error al registrar la vivienda</h1>");
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos");
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
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
