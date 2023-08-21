<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'school';

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phoneNumber = $_POST['phoneNumber'];

    // Update student record in MySQL database
    $sql = "UPDATE students SET email = '$email', phoneNumber = '$phoneNumber' WHERE name = '$name'";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode(array('success' => true));
    } else {
        echo json_encode(array('success' => false, 'error' => $conn->error));
    }
} else {
    echo json_encode(array('success' => false, 'error' => 'This endpoint only accepts POST requests'));
}

$conn->close();
?>