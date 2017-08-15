#!/usr/bin/php
<?php
//
// Uso copyToNube.php?
// &xNombreFile=copia18092011.bak
// &xDestino=https://aguasyservicios.s3-website-eu-west-1.amazonaws.com/copias/fast_recovery/aysct
// 
$xDestino='https://aguasyservicios.s3-website-eu-west-1.amazonaws.com/copias/fast_recovery/aysct/backupset/';
// parametros de entrada
echo "\n".$xDestino.=$argv[2].'/'."\n";
echo "\n".$xNombreFile=$argv[1]."\n";
// Instantiate the class
//$s3 = new AmazonS3();
 
// Open a file resource
//$file_resource = fopen($xRuta.$xNombreFile, 'r');
 
// Upload a partial file
/*$response = $s3->create_object($xDestino, $xNombreFile, array(
    'fileUpload' => $file_resource,
    'acl' => AmazonS3::ACL_PUBLIC
));*/
 
// Success?
//var_dump($response->isOK());
//var_dump($argv);
?>
