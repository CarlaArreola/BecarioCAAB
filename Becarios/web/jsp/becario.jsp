<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, configuration.ConnectionBD" %>
<%@ page import="javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Información del Becario</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #FFEFF1; /* Fondo rosado claro */
                margin: 0;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #FF66A1; /* Tono rosado */
            }
            .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 20px;
                border: 3px solid #FF7BA9;
            }
            .info {
                flex: 1;
                margin-right: 20px; /* Espacio entre la info y la imagen */
                font-family: 'Verdana', sans-serif; /* Fuente bonita */
                color: #333; /* Color de texto oscuro */
            }
            .info p {
                margin: 10px 0; /* Espaciado entre párrafos */
                font-size: 16px; /* Tamaño de fuente */
            }
            .button {
                display: inline-block;
                padding: 12px 24px;
                font-size: 18px;
                margin: 12px 0;
                cursor: pointer;
                background-color: #FF66A1; /* Fondo rosado */
                color: white;
                border: none;
                border-radius: 25px;
                text-decoration: none;
                font-weight: bold;
                transition: background-color 0.3s ease, transform 0.2s;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .button:hover {
                background-color: #FF4D88; /* Tono más oscuro */
                transform: scale(1.1);
            }
            .image {
                width: 160px; /* Tamaño del avatar */
                height: 160px;
                border-radius: 50%;
                object-fit: cover;
                box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
                border: 4px solid #FF7BA9; /* Borde verde #7BCB84 */
                transition: transform 0.3s ease;
                margin-left: 20px; /* Espacio a la izquierda para separarla del texto */
                margin-right: auto; /* Espacio automático a la derecha para centrar */
                display: block; /* Asegura que los márgenes se apliquen correctamente */
                align-self: center; /* Centra la imagen verticalmente en el contenedor */
            }

            .image:hover {
                transform: scale(1.05) rotate(5deg);
            }
        </style>
    </head>
    <body>
        <h1>Datos Registrados:</h1>
        <%
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");

            if (session == null || session.getAttribute("curp") == null) {
                response.sendRedirect("/becarios/jsp/login.jsp");
            }
            String curp = null;

            if (session != null) {
                curp = (String) session.getAttribute("curp");
            }

            if (curp != null) {
                ConnectionBD conexion = new ConnectionBD();
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    conn = conexion.getConnectionBD();
                    String sql = "SELECT curp, nombre, apellidoPaterno, apellidoMaterno, genero, fecha_nac, foto FROM becario WHERE curp = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, curp);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String nombre = rs.getString("nombre");
                        String apellidoPaterno = rs.getString("apellidoPaterno");
                        String apellidoMaterno = rs.getString("apellidoMaterno");
                        String genero = rs.getString("genero");
                        String fechaNac = rs.getString("fecha_nac");
                        String foto = rs.getString("foto");

                        out.println("<div class='container'>");
                        out.println("<div class='info'>");
                        out.println("<p>Nombre completo: " + nombre + " " + apellidoPaterno + " " + apellidoMaterno + "!</p>");
                        out.println("<p>Fecha de Nacimiento: " + fechaNac + "</p>");
                        out.println("<p>CURP: " + curp + "</p>");
                        out.println("<p>Género: " + genero + "</p>");

                        out.println("<form action='" + request.getContextPath() + "/upload_image_servlet' method='POST' enctype='multipart/form-data'>");
                        out.println("<input type='hidden' name='curp' value='" + curp + "'>");
                        out.println("<input type='file' name='image' accept='image/*'>");
                        out.println("<button type='submit' class='button'>Cargar Imagen</button>");
                        out.println("</form>");
                        out.println("<a href='" + request.getContextPath() + "/jsp/vivienda.jsp?curp=" + curp + "' class='button'>Agregar Vivienda</a>");
                        out.println("</div>");

                        // Aquí se coloca la imagen a la derecha
                        out.println("<img src='" + (foto != null && !foto.isEmpty() ? request.getContextPath() + "/" + foto : "images/default-avatar.png") + "' alt='Imagen del becario' class='image' />");
                        out.println("</div>");
                    } else {
                        out.println("<p>No se encontró información del becario.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Error al obtener la información del becario: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
            } else {
                out.println("<p>No se ha iniciado sesión. Por favor, inicia sesión.</p>");
                response.sendRedirect("login.jsp");
            }
        %>

        <a href="${pageContext.request.contextPath}/jsp/vermas.jsp?curp=<%= curp%>" class="button">Ver Más</a>

    </body>
</html>
