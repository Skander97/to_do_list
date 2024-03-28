<?php
$host = "localhost";
$user = "root";
$password = "";

$conn = new mysqli($host, $user, $password);

if ($conn->connect_error) {
    die("Échec de la connexion à MySQL : " . $conn->connect_error);
}

$database = "todolist_db";
$sql_create_db = "CREATE DATABASE IF NOT EXISTS $database";
if ($conn->query($sql_create_db) === TRUE) {
    echo "Base de données créée avec succès.<br>";
} else {
    echo "Erreur lors de la création de la base de données : " . $conn->error . "<br>";
}

$conn->close();
?>