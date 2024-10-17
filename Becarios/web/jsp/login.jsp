<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Sesión - Becarios</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #FFEFF1;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                box-sizing: border-box;
                text-align: center;
                border: 3px solid #FF7BA9;
            }

            h2 {
                color: #FF66A1;
                margin-bottom: 20px;
                font-size: 28px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #333;
                font-weight: bold;
                text-align: left;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 8px;
                box-sizing: border-box;
                font-size: 16px;
            }

            input[type="submit"] {
                width: 100%;
                padding: 12px;
                background-color: #7BCB84;
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            input[type="submit"]:hover {
                background-color: #5FA96B;
                transform: scale(1.05);
            }

            p {
                color: red;
                margin-top: 15px;
            }

            @media (max-width: 480px) {
                .container {
                    padding: 20px;
                }

                h2 {
                    font-size: 24px;
                }

                input[type="submit"] {
                    font-size: 16px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Inicio de Sesión</h2>
            
            <form action="${pageContext.request.contextPath}/login_becario" method="POST">
                <label for="curp">CURP:</label>
                <input type="text" id="curp" name="curp" placeholder="Ingresa tu CURP" required>

                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" placeholder="Ingresa tu contraseña" required>

                <input type="submit" value="Iniciar Sesión">
            </form>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <p><%= error %></p>
            <%
                }
            %>
        </div>
    </body>
</html>
