<?php
if (isset($_GET['usuario'])) {
    // Obtenemos valores0
	$usuario = $_GET['usuario'];
	$passwd = $_GET['passwd'];
	$email = $_GET['email'];
	$nombre = $_GET['nombre'];
	$apellidos = $_GET['apellidos'];

	$querie="INSERT INTO Usuarios (passwd,nombreUsuario,email,nombre,apellidos) Values(AES_ENCRYPT('123','".$passwd."'),'".$usuario."','".$email."','".$nombre."','".$apellidos."')";
	echo $querie;
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
