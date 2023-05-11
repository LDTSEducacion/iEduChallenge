<?php
if (isset($_GET['id'])) {
    // Obtenemos el valor del parámetro "id"
	$id = $_GET['id'];

    $conn = mysqli_connect("localhost:3306", "dbusereduchalenge", "Al%\$c3RR?3C4%&", "ProyectoEduChalenge" );

    mysqli_set_charset( $conn, 'utf8mb4');	
    $res1 = mysqli_query($conn, "SELECT CONVERT(respuesta using utf8) respuestaUsu, CONVERT(usuario_id using utf8) idUsuario, CONVERT(nombreUsuario using utf8) nombreUsu from Respuestas r join Usuarios u on (r.usuario_id=u.id_usuario) where desafio_id = $id");
   

    $data = array();

    while ($row = mysqli_fetch_object($res1))
    {
        array_push($data, $row);
    }

    echo json_encode($data, JSON_INVALID_UTF8_SUBSTITUTE);
}
?>
