<?php
function Ip($type = 0) 
{
            $type = $type ? 1 : 0;
            static $ip =  NULL;
            if ($ip !== NULL) return $ip[$type];
            if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
                $arr = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
                $pos = array_search('unknown',$arr);
                if(false !== $pos) unset($arr[$pos]);
                $ip = trim($arr[0]);
            }elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
                $ip = $_SERVER['HTTP_CLIENT_IP'];
            }elseif (isset($_SERVER['REMOTE_ADDR'])) {
                $ip = $_SERVER['REMOTE_ADDR'];
            }
            $long = sprintf("%u",ip2long($ip));
            $ip = $long ? array($ip, $long) : array('0.0.0.0', 0);
            return $ip[$type];
        }

if(!isset($_POST['submit'])){
	exit('�Ƿ�����!');
}
$username = $_POST['username'];
$password = $_POST['password'];
//ע����Ϣ�ж�
if(!preg_match('/^[\w\x80-\xff]{3,15}$/', $username)){
	exit('�����û��������Ϲ涨��<a href="javascript:history.back(-1);">����</a>');
}
if(strlen($password) < 4){
	exit('�������볤�Ȳ����Ϲ涨��<a href="javascript:history.back(-1);">����</a>');
}

//�������ݿ������ļ�
include('conn.php');
//����û����Ƿ��Ѿ�����
$check_query = mysql_query("select AccountID from tbl_user where AccountID='$username'");
if(mysql_fetch_array($check_query)){
	echo '�����û��� ',$username,' �Ѵ��ڡ�<a href="javascript:history.back(-1);">����</a>';
	exit;
}
//д������
//$password = MD5($password); //��ʹ��MD5��ʽ����
//$regdate = time();
$ip = ip();
$sql = "INSERT INTO tbl_user(AccountID,AccountPassword,EnableFlg,TrialFlg,DownFlg,ExpFlg,SequenceNumber,UseFlg,BadMsg,CdKey)VALUES('$username','$password','1','8','0','0','13','1','0','$username')";
if(mysql_query($sql,$conn)){
	exit('�û�ע��ɹ���');
} else {
	echo '��Ǹ���������ʧ�ܣ�',mysql_error(),'<br />';
	echo '����˴� <a href="javascript:history.back(-1);">����</a> ����';
}
?>
