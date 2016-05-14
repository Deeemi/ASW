<html>
<head>CALCIATORE: RICERCA PER RUOLO</head>
<body>
<?php
/* Connect to an ODBC database using driver invocation */
$dsn = 'pgsql:dbname=database;host=192.168.33.23;port=5432';
$user = 'readonly';
$password = 'readonly';

try {
    $db = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}

$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$sql = "SELECT * FROM calciatore WHERE ruolo = ? ";

$val = $db->prepare($sql);

$val->execute(array($_POST['ruolo']));

foreach ($val as $row) {
        print $row['id'] . "\n";
        print $row['nome'] . "\n";
        print $row['cognome'] . "\n";
        print $row['nascita'] . "\n";
        print $row['nazione'] . "\n";
        print $row['ruolo'] . "\n";
        print $row['squadra'] . "\n";
           }
$db = null;

?>
</body>
</html>