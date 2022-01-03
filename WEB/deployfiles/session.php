<?php
require '/var/www/html/vendor/autoload.php';
use Aws\DynamoDb\DynamoDbClient;
use Aws\DynamoDb\SessionHandler;

$sdk = new Aws\Sdk([
    'region'   => getenv('REGION'),
    'version'  => 'latest',
    'http'    => [
        'debug' => false
    ]
]);

$dynamodb = $sdk->createDynamoDb();

$sessionHandler = SessionHandler::fromClient($dynamodb, [
    'table_name'       => getenv('DYNAMODB'),
    'session_lifetime' => 3600
]);

$sessionHandler->register();
?>
