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
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author carla
 */
@WebServlet(name = "RegistroBecario", urlPatterns = {"/register_becario"})
public class RegistroBecario extends HttpServlet {

    Connection conn;
    PreparedStatement ps;
    Statement statement;
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
            out.println("<title>Servlet RegistroBecario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistroBecario at " + request.getContextPath() + "</h1>");
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
        String curp = request.getParameter("curp");
        String apellidoPaterno = request.getParameter("apellidoPaterno");
        String apellidoMaterno = request.getParameter("apellidoMaterno");
        String nombre = request.getParameter("nombre");
        String genero = request.getParameter("genero");
        String password = request.getParameter("password");
        
        String fechaNac = obtenerFechaNacimientoDesdeCurp(curp);
        
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try {
            ConnectionBD connectionBD = new ConnectionBD();
            conn = connectionBD.getConnectionBD();
            
            String sql = "INSERT INTO becario (curp, apellidoPaterno, apellidoMaterno, nombre, genero, password, fecha_nac) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, curp);
            ps.setString(2, apellidoPaterno);
            ps.setString(3, apellidoMaterno);
            ps.setString(4, nombre);
            ps.setString(5, genero);
            ps.setString(6, hashedPassword);
            ps.setString(7, fechaNac);

            int rowsAffected = ps.executeUpdate();
            
            try (PrintWriter out = response.getWriter()) {
                response.setContentType("text/html;charset=UTF-8");
                if (rowsAffected > 0) {
                    out.println("<h1>Registro exitoso!! :) </h1>");
                } else {
                    out.println("<h1>Error al registrar el becario</h1>");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    private String obtenerFechaNacimientoDesdeCurp(String curp) {
        String anio = curp.substring(4, 6);
        String mes = curp.substring(6, 8);
        String dia = curp.substring(8, 10);

        int yearPrefix = Integer.parseInt(anio) >= 0 && Integer.parseInt(anio) <= 23 ? 2000 : 1900;
        String fechaNac = (yearPrefix + Integer.parseInt(anio)) + "-" + mes + "-" + dia;

        return fechaNac;
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
