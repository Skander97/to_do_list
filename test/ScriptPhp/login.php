<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "todolist_db";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die("Échec de la connexion à la base de données : " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql_check_login = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = $conn->query($sql_check_login);

    if ($result->num_rows == 1) {
        echo "Connexion réussie.";
    } else {
        echo "Identifiants incorrects.";
    }
}

$conn->close();
?>