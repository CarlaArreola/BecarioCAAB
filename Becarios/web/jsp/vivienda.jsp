<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Vivienda</title>
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
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            border: 3px solid #FF7BA9;
        }

        h1 {
            text-align: center;
            color: #FF66A1;
            margin-bottom: 20px;
            font-size: 26px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
        }

        input[readonly] {
            background-color: #f5f5f5;
            color: #999;
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

        @media (max-width: 480px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 22px;
            }

            input[type="submit"] {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Registrar Vivienda</h1>

        <%
            String curp = request.getParameter("curp");
        %>

        <form action="${pageContext.request.contextPath}/registro_vivienda" method="POST">
            <label for="calle">Calle:</label>
            <input type="text" id="calle" name="calle" required>

            <label for="colonia">Colonia:</label>
            <input type="text" id="colonia" name="colonia" required>

            <label for="numero">Número:</label>
            <input type="text" id="numero" name="numero" required> <!-- Se eliminó maxlength -->

            <label for="cp">Código Postal (CP):</label>
            <input type="text" id="cp" name="cp" maxlength="5" required>

            <input type="submit" value="Registrar Vivienda">
        </form>
    </div>
</body>
</html>
