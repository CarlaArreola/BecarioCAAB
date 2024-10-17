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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author carla
 */
@WebServlet(name = "LoginBecario", urlPatterns = {"/login_becario"})
public class LoginBecario extends HttpServlet {
    
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
            out.println("<title>Servlet LoginBecario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginBecario at " + request.getContextPath() + "</h1>");
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
        if (!verificarSesionYCookie(request)) {
            response.sendRedirect("/becarios/jsp/login.jsp");
        } else {
            request.getRequestDispatcher("/becarios/jsp/usuario.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String curp = request.getParameter("curp");
        String password = request.getParameter("password");

        try {
            ConnectionBD conexion = new ConnectionBD();
            conn = conexion.getConnectionBD();

            String sql = "SELECT password FROM becario WHERE curp = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, curp);
            rs = ps.executeQuery();

            if (rs.next()) {
                String hashPassword = rs.getString("password");
                
                if (BCrypt.checkpw(password, hashPassword)) {
                    Cookie cookie = new Cookie("curp", curp);
                    cookie.setMaxAge(60 * 15); 
                    cookie.setPath("/");
                    response.addCookie(cookie);

                    HttpSession session = request.getSession();
                    session.setAttribute("curp", curp);
                    session.setMaxInactiveInterval(2 * 60); 

                    response.sendRedirect("/becarios/jsp/becario.jsp");
                } else {
                    request.setAttribute("error", "Contraseña incorrecta");
                    request.getRequestDispatcher("/becarios/jsp/error.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Becario no encontrado");
                request.getRequestDispatcher("/becarios/jsp/error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            request.getRequestDispatcher("/becarios/jsp/error.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
        private boolean verificarSesionYCookie(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Cookie[] cookies = request.getCookies();

        if (session == null || cookies == null) {
            return false;
        }

        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("curp")) {
                return true;
            }
        }

        return false;
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
