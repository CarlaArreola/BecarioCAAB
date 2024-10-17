<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, configuration.ConnectionBD" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Más Información</title>

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
            h2 {
                color: #333; /* Color de texto oscuro */
            }
            .container {
                display: flex;
                flex-direction: column; /* Coloca los elementos en columna */
                align-items: center; /* Centra horizontalmente */
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 20px;
                max-width: 600px; /* Ancho máximo para el contenedor */
                margin-left: auto; /* Centro horizontalmente */
                margin-right: auto; /* Centro horizontalmente */
                border: 3px solid #FF7BA9;
            }
            .info {
                font-family: 'Verdana', sans-serif; /* Fuente bonita */
                color: #333; /* Color de texto oscuro */
                margin: 10px 0; /* Espaciado entre párrafos */
                font-size: 16px; /* Tamaño de fuente */
                text-align: left; /* Alineación izquierda para texto */
                display: flex; /* Usa flexbox para alinear imagen y texto */
                align-items: center; /* Centra verticalmente */
            }
            .info img {
                margin-left: 20px; /* Espacio entre texto e imagen */
                width: 100px; /* Ajusta el tamaño de la imagen */
                height: 100px; /* Ajusta el tamaño de la imagen */
                border-radius: 50%; /* Hace la imagen circular */
                object-fit: cover; /* Mantiene la proporción de la imagen */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Sombra para la imagen */
            }
            .button {
                display: inline-block;
                padding: 12px 28px;
                font-size: 18px;
                margin: 12px;
                cursor: pointer;
                background-color: #FF66A1; /* Fondo rosado */
                color: white;
                border: none;
                border-radius: 30px;
                text-decoration: none;
                font-weight: bold;
                transition: background-color 0.3s ease, transform 0.2s;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .button:hover {
                background-color: #FF4D88; /* Tono más oscuro */
                transform: scale(1.05);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }
            .image {
                width: 180px;
                height: 180px;
                border-radius: 50%;
                object-fit: cover;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                transition: transform 0.4s ease, box-shadow 0.4s;
                margin: 20px 0; /* Espaciado vertical */
                border: 4px solid #FF7BA9;
            }
            .image:hover {
                transform: scale(1.1) rotate(8deg);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
            }
            .list {
                list-style-type: none; /* Elimina los puntos de la lista */
                padding: 0; /* Elimina el padding de la lista */
            }
            .list li {
                margin: 8px 0; /* Espaciado entre elementos de la lista */
                font-size: 18px; /* Aumenta el tamaño de fuente */
                font-weight: bold; /* Hace el texto en negrita */
            }
        </style>

    </head>
    <body>
        <h1>Información Completa del Becario</h1>
        <div class="container">
            <%
                String curp = request.getParameter("curp");

                if (curp != null && !curp.isEmpty()) {
                    ConnectionBD conexion = new ConnectionBD();
                    Connection conn = null;
                    PreparedStatement psBecario = null;
                    PreparedStatement psVivienda = null;
                    ResultSet rsBecario = null;
                    ResultSet rsVivienda = null;

                    try {
                        conn = conexion.getConnectionBD();

                        String sqlBecario = "SELECT curp, nombre, apellidoPaterno, apellidoMaterno, genero, fecha_nac, foto FROM becario WHERE curp = ?";
                        psBecario = conn.prepareStatement(sqlBecario);
                        psBecario.setString(1, curp);
                        rsBecario = psBecario.executeQuery();

                        if (rsBecario.next()) {
                            String nombre = rsBecario.getString("nombre");
                            String apellidoPaterno = rsBecario.getString("apellidoPaterno");
                            String apellidoMaterno = rsBecario.getString("apellidoMaterno");
                            String genero = rsBecario.getString("genero");
                            String fechaNac = rsBecario.getString("fecha_nac");
                            String foto = rsBecario.getString("foto"); 

                            out.println("<h2>Datos del Becario</h2>");
                            out.println("<div class='info'>");
                            out.println("<div>");
                            out.println("<p>Nombre: " + nombre + " " + apellidoPaterno + " " + apellidoMaterno + "</p>");
                            out.println("<p>Fecha de Nacimiento: " + fechaNac + "</p>");
                            out.println("<p>CURP: " + curp + "</p>");
                            out.println("<p>Género: " + genero + "</p>");
                            out.println("</div>");
                            // colocamos la imagen a la derecha
                            out.println("<img src='" + (foto != null && !foto.isEmpty() ? request.getContextPath() + "/" + foto : "images/default-avatar.png") + "' alt='Imagen del becario' class='image' />");
                            out.println("</div>");

                            // Consulta para obtener datos de la vivienda
                            String sqlVivienda = "SELECT calle, colonia, numero, cp FROM vivienda WHERE curp = ?";
                            psVivienda = conn.prepareStatement(sqlVivienda);
                            psVivienda.setString(1, curp);
                            rsVivienda = psVivienda.executeQuery();

                            out.println("<h2>Datos de la Vivienda</h2>");
                            if (rsVivienda.next()) {
                                String calle = rsVivienda.getString("calle");
                                String colonia = rsVivienda.getString("colonia");
                                String numero = rsVivienda.getString("numero");
                                String cp = rsVivienda.getString("cp");

                                out.println("<ul class='list'>");
                                out.println("<li>Calle: " + calle + "</li>");
                                out.println("<li>Colonia: " + colonia + "</li>");
                                out.println("<li>Número: " + numero + "</li>");
                                out.println("<li>Código Postal: " + cp + "</li>");
                                out.println("</ul>");
                            } else {
                                out.println("<div class='info'><p>Falta por agregar la vivienda.</p></div>");
                            }
                        } else {
                            out.println("<p>No se encontró información del becario.</p>");
                        }

                    } catch (SQLException e) {
                        out.println("<p>Error al obtener la información: " + e.getMessage() + "</p>");
                    } finally {
                        if (rsBecario != null) {
                            rsBecario.close();
                        }
                        if (psBecario != null) {
                            psBecario.close();
                        }
                        if (rsVivienda != null) {
                            rsVivienda.close();
                        }
                        if (psVivienda != null) {
                            psVivienda.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                } else {
                    out.println("<p>CURP no proporcionada.</p>");
                }
            %>
            <a href="${pageContext.request.contextPath}/jsp/becario.jsp" class="button">Regresar</a>
        </div>
    </body>
</html>
