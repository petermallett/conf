#!/usr/bin/php
<?php
/**
 * generates a random password, uses base64: 0-9a-zA-Z/+
 * @param int [optional] $length length of password, default 24 (144 Bit)
 * @return string password
 */
function generatePassword($length = 24) {
  if(function_exists('openssl_random_pseudo_bytes')) {
    $password = base64_encode(openssl_random_pseudo_bytes($length, $strong));
    if($strong == TRUE)
      return substr($password, 0, $length); //base64 is about 33% longer, so we need to truncate the result
  }

  //fallback to mt_rand if php < 5.3 or no openssl available
  $characters = '0123456789';
  $characters .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz/+'; 
  $charactersLength = strlen($characters)-1;
  $password = '';

  //select some random characters
  for ($i = 0; $i < $length; $i++) {
    $password .= $characters[mt_rand(0, $charactersLength)];
  }

  return $password;
}

$length = 24;
if (isset($argv[1])) {
  $length = $argv[1];
}

echo generatePassword($length) . "\n";

