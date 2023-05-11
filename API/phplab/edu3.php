<?php
if (isset($_GET['usuario'])) {
    // Obtenemos valores0
	$usuario = $_GET['usuario'];
	$passwd = $_GET['passwd'];

	$querie="SELECT CONVERT(id_usuario using utf8) usuarioId from Usuarios WHERE nombreUsuario = \"".$usuario."\" AND passwd = AES_ENCRYPT('123','".$passwd."')";
	
    $conn = mysqli_connect("localhost:3306", "dbusereduchalenge", "Al%\$c3RR?3C4%&", "ProyectoEduChalenge" );

    mysqli_set_charset( $conn, 'utf8mb4');	
    $res1 = mysqli_query($conn, $querie);
   

    $data = array();

    while ($row = mysqli_fetch_object($res1))
    {
        array_push($data, $row);
    }

    echo json_encode($data, JSON_INVALID_UTF8_SUBSTITUTE);
}
?>
