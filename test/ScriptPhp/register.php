<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "todolist_db";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die("Échec de la connexion à la base de données : " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['register'])) {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql_check_user = "SELECT * FROM users WHERE username='$username' OR email='$email'";
    $result = $conn->query($sql_check_user);

    if ($result->num_rows > 0) {
        echo "L'utilisateur existe déjà.";
    } else {
        $sql_insert_user = "INSERT INTO users (username, email, password) VALUES ('$username', '$email', '$password')";
        if ($conn->query($sql_insert_user) === TRUE) {
            echo "Inscription réussie.";
        } else {
            echo "Erreur lors de l'inscription : " . $conn->error;
        }
    }
}

$conn->close();
?>