<?php
declare (strict_types=1);

namespace app\util;

use think\facade\Config;
use think\facade\Log;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

/**
 * 邮件服务
 * Class EmailUtil
 * @package app\util
 * @author  hardphp（2066362155@qq.com）
 */
class EmailUtil
{
    /** 加密
     * @param $email  邮箱
     * @param $code  验证码
     * @throws \think\Exception 
     */
    public static function sendCode($email,$code)
    {
        $config = Config::get("system.email");
        $mail = new PHPMailer(true);

        try {
            //Server settings
            //$mail->SMTPDebug = SMTP::DEBUG_SERVER;  //Enable verbose debug output
            $mail->isSMTP();                         //Send using SMTP
            $mail->Host       = $config['Host'];     //Set the SMTP server to send through
            $mail->SMTPAuth   = true;                 //Enable SMTP authentication
            $mail->Username   = $config['Username'];   //SMTP username 这里填自己的发件邮箱
            $mail->Password   = $config['Password'];      //SMTP password 这里就是上边保存的授权码，不是邮箱密码
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;  //Enable implicit TLS encryption
            $mail->Port       = $config['Port'];    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

            //Recipients
            $mail->setFrom($config['Username'], $config['title']); // '发件人邮箱', '名称'
            $mail->addAddress($email, '');     //Add a recipient '收件人邮箱', '名称'

            //Content
            $mail->isHTML(true);   //Set email format to HTML
            $mail->Subject = $config['Subject']; // 这里是邮件的主题

            $Body = str_replace('@', $code, $config['Body']);
            $mail->Body    = $Body ; //这里是邮件的正文内容 

            $res = $mail->send();
            return $res;
        } catch (Exception $e) {
             //echo "Message could not be sent. Mailer Error【信息发送失败】: {$mail->ErrorInfo}";
            return false;
        }

    }
 

}
