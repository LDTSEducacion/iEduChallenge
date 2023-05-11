<?php

    $conn = mysqli_connect("localhost:3306", "dbusereduchalenge", "Al%\$c3RR?3C4%&", "ProyectoEduChalenge" );

    mysqli_set_charset( $conn, 'utf8mb4');	
    $res1 = mysqli_query($conn, "SELECT CONVERT(id_Desafio using utf8) id_Desafio,CONVERT(pregunta using utf8) pregunta, CONVERT(solucion using utf8)solucion from Desafios");
   

    $data = array();

    while ($row = mysqli_fetch_object($res1))
    {
        array_push($data, $row);
    }

    echo json_encode($data, JSON_INVALID_UTF8_SUBSTITUTE);

?>
