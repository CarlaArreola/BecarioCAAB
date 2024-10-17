<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ALTA BECARIO</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #FFEFF1; /* Fondo rosado claro */
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh; /* Cambiado a min-height */
            }

            .container {
                background-color: white;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                box-sizing: border-box; /* Asegura que padding y border se incluyan en el ancho total */
                border: 3px solid #FF7BA9;
            }

            h1 {
                text-align: center;
                color: #FF66A1; /* Tono rosado para el título */
                margin-bottom: 20px;
                font-size: 28px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #333;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box; /* Asegura que padding y border se incluyan en el ancho total */
            }

            /* Estilo para los botones de radio */
            .radio-group {
                display: flex;
                align-items: center; /* Alinea verticalmente los elementos al centro */
                margin-bottom: 15px; /* Espacio entre cada grupo de radio buttons */
            }

            input[type="radio"] {
                margin-right: 5px; /* Espacio entre el botón y la etiqueta */
                appearance: none; /* Eliminar estilo por defecto */
                width: 20px; /* Ajusta el tamaño del círculo */
                height: 20px; /* Ajusta el tamaño del círculo */
                border-radius: 50%; /* Hace que el input sea un círculo */
                border: 2px solid #ccc; /* Color del borde por defecto */
                outline: none; /* Quita el contorno */
                position: relative; /* Posicionamiento relativo para el hover */
                cursor: pointer; /* Cambia el cursor al pasar por encima */
            }

            /* Efectos al hacer hover sobre los botones de radio */
            input[type="radio"]:hover {
                border-color: #888; /* Color del borde al pasar el ratón */
            }

            /* Estilos para el botón masculino */
            input[type="radio"]:checked#masculino {
                background-color: #A7C6ED; /* Baby blue */
                border-color: #A7C6ED; /* Baby blue */
            }

            /* Estilos para el botón femenino */
            input[type="radio"]:checked#femenino {
                background-color: #FFB2C1; /* Baby pink */
                border-color: #FFB2C1; /* Baby pink */
            }

            button {
                width: 100%;
                padding: 12px;
                background-color: #7BCB84; /* Verde suave para el botón */
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s;
            }

            button:hover {
                background-color: #5FA96B; /* Verde más oscuro al pasar el ratón */
                transform: scale(1.05);
            }

            @media (max-width: 480px) {
                .container {
                    padding: 20px;
                }

                h1 {
                    font-size: 24px;
                }

                button {
                    font-size: 16px;
                }
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h1>ALTA BECARIO</h1>
            <form action="${pageContext.request.contextPath}/register_becario" method="post">
                <label for="curp">CURP:</label>
                <input type="text" id="curp" name="curp" required>

                <label for="apellidoPaterno">Apellido Paterno:</label>
                <input type="text" id="apellidoPaterno" name="apellidoPaterno" required>

                <label for="apellidoMaterno">Apellido Materno:</label>
                <input type="text" id="apellidoMaterno" name="apellidoMaterno" required>

                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required>

                <div>
                    <label>Género:</label>
                    <div class="radio-group">
                        <input type="radio" id="masculino" name="genero" value="Masculino" required>
                        <label for="masculino">Masculino</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="femenino" name="genero" value="Femenino" required>
                        <label for="femenino">Femenino</label>
                    </div>
                </div>

                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required>

                <button type="submit">Registrar</button>
            </form>
        </div>
    </body>
</html>
