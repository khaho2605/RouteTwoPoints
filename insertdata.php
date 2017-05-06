<?php
    
    mysql_connect("localhost", "myvanvo_user", "Usa6868");
    mysql_select_db("myvanvo_cw");
    mysql_query("SET NAMES 'utf8'");
    
    $userid=$_GET["userid"];
    $transactiontime=$_GET["transactiontime"];
    $source=$_GET["source"];
    $destination=$_GET["destination"];
    
    $qr = "INSERT INTO data1004 VALUES(null,'$transactiontime','$userid','$source','$destination')";
    
    /*$qr = "INSERT INTO data VALUES(null,'$userid','$transaction')";*/
    
    if(mysql_query($qr)){
        echo "Successful";
    }else{
        
        echo "failed";
    }
    mysql_close($conn);
    
?>
