<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio - Sistema Becario</title>
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
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 320px;
        border: 3px solid #FF7BA9;
    }

    h1 {
        margin-bottom: 20px;
        color: #FF66A1;
        font-size: 24px;
    }

    a {
        display: block;
        margin: 12px 0;
        padding: 12px 24px;
        text-decoration: none;
        color: white;
        background-color: #7BCB84;
        border-radius: 8px;
        transition: background-color 0.3s ease, transform 0.2s;
        font-weight: bold;
    }

    a:hover {
        background-color: #5FA96B;
        transform: scale(1.05);
    }
</style>

    </head>
    <body>
        <div class="container">
            <h1>Sistema Becario</h1>
            <a href="${pageContext.request.contextPath}/jsp/registro.jsp">Registrar Becario</a>
            <a href="${pageContext.request.contextPath}/jsp/login.jsp">Login Becario</a>
        </div>
    </body>
</html>
