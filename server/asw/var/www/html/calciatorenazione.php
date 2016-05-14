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
$user = 'readonly';
$password = 'readonly';

try {
    $db = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}

# echo $_POST['selezione'];

$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$sql = "SELECT * FROM calciatore WHERE nazione = ? ";

$val = $db->prepare($sql);

$val->execute(array($_POST['nazione']));

foreach ($val as $row) {
        print $row['id'] . "\t" ;
        print $row['nome'] . "\t";
        print $row['cognome'] . "\t";
        print $row['nascita'] . "\t";
        print $row['nazione'] . "\t";
        print $row['ruolo'] . "\t";
        print $row['squadra'] . "\t";
           }
$db = null;

?>
</body>
</html>