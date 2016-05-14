<html>
<head> <link href="style/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="style/css/agency.css" rel="stylesheet">

  <!-- Custom Fonts -->
  <link href="style/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'></head>

<body id="page-top" class="index">
<?php
/* Connect to an ODBC database using driver invocation */
$dsn = 'pgsql:dbname=database;host=192.168.33.23;port=5432';
$user = 'root';
$password = 'asd';

try {
    $db = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}

# echo $_POST['selezione'];

$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$sql = "INSERT INTO squadra (idsquadra, nomesquadra, citta, annofondazione, stadio)
        VALUES (?,?,?,?,?);";

$val = $db->prepare($sql);

$val->execute(array($_POST['idsquadra'], $_POST['nomesquadra'], $_POST['citta'], $_POST['annofondazione'], $_POST['stadio']));

foreach ($val as $row) {
        print $row['idsquadra'] . "\t" ;
        print $row['nomesquadra'] . "\t";
        print $row['citta'] . "\t";
        print $row['annofondazione'] . "\t";
        print $row['stadio'] . "\t";
           }

echo "SQUADRA AGGIUNTA";
$db = null;

?>
</body>
</html>