<html>
<head>CALCIATORE: RICERCA PER SQUADRA</head>
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

# echo $_POST['selezione'];

$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$sql = "SELECT * FROM calciatore WHERE squadra = ? ";

$val = $db->prepare($sql);

$val->execute(array($_POST['squadra']));

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