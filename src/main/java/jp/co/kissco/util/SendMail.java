package jp.co.kissco.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class SendMail {
	
	//修正だか完了だか区分
	int changeState;
	
	//発送するために基本情報
	int port=465;
	String host = "smtp.kissco.co.jp";
    String sender = "yblee@kissco.co.jp";
    String username = "yblee@kissco.co.jp";
    String password = "y2o0u5n8g";
    String recipient = "";
    
    //完了の場合が基本設定
    String subject = "願書が処理できました。";
    String body = "";		
    String uname = "";									//ユーザの実際名前
    
    //添付ファイルpath
    String fileName = "";
	String pdfFilePath = "";
	
	//完了の場合
	public SendMail(String recipient, int changeState, String uname) {
		super();
		this.recipient = recipient;
		this.changeState = changeState;
		this.uname = uname;
		
		fileName = uname + "_受験票.pdf";
		pdfFilePath = "D:\\" + fileName;
		body = uname + "様\n\n" + "提出した願書を処理しました。\n添付した受験票に受験番号と受験所があります。\n試験を受けるために受験票を持ってください。\n\n" + "よろしくお願いします。"; 
		
		sendMailProcess();
	}
	
	/*　修正の場合、ユーザのメールボタンを直接押すとき　*/
	public SendMail(String recipient, int changeState, String subject, String body) {
		super();
		this.recipient = recipient;
		this.changeState = changeState;
		this.subject = subject;
		this.body = body;
		
		sendMailProcess();
	}
	
	/*　実際にメールを送るPROCSS　*/
	public void sendMailProcess() {
		Properties props = System.getProperties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);

        //ユーザ確認
		Session msession = Session.getInstance (props, new javax.mail. Authenticator() {
			String un = username;
			String pw = password;
			protected PasswordAuthentication getPasswordAuthentication () {
				return new PasswordAuthentication(un,pw);
				}
			});
		
        //msession.setDebug(true); //for debug
        
		Message mimeMessage = new MimeMessage(msession);
        switch(changeState) {
        //修正ボタンクリック
        case 2:
            try {
				mimeMessage.setFrom(new InternetAddress(sender));
				mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
				mimeMessage.setSubject(subject);
				mimeMessage.setText(body);
				Transport.send(mimeMessage);
			} catch (MessagingException e1) {
				e1.printStackTrace();
			}
        	break;
        //完了ボタンクリック
        case 3:
             try {
     			mimeMessage.setFrom(new InternetAddress(sender));
     			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
     			mimeMessage.setSubject(subject);
     			
     			//添付ファイル 
     			BodyPart bodyPart = new MimeBodyPart();
     			
     			//body
     			bodyPart.setText(body);
     			Multipart multipart = new MimeMultipart();
     			multipart.addBodyPart(bodyPart);
     			
     			//添付
     			bodyPart = new MimeBodyPart();
     			DataSource source = new FileDataSource(pdfFilePath);
     	        bodyPart.setDataHandler(new DataHandler(source));
     	        bodyPart.setFileName(MimeUtility.encodeText(fileName, "UTF-8", "B"));			//日本語で出るように
     	        multipart.addBodyPart(bodyPart);
     	       
     	        mimeMessage.setContent(multipart);
     			Transport.send(mimeMessage);													//転送
     		} catch (MessagingException e) {
     			e.printStackTrace();
     		} catch (UnsupportedEncodingException e) {
     			e.printStackTrace();
     		} finally {
     			//名前pdfファイル削除
				File deleteFile = new File(pdfFilePath);
				deleteFile.delete();
     		}
        	break;
        }
	}
	public SendMail(File file,String recipient, String subject, String body) throws Exception{
		super();
		this.recipient = recipient;
		this.changeState = changeState;
		this.subject = subject;
		this.body = body;
		Properties props = System.getProperties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);

        //ユーザ確認
		Session msession = Session.getInstance (props, new javax.mail. Authenticator() {
			String un = username;
			String pw = password;
			protected PasswordAuthentication getPasswordAuthentication () {
				return new PasswordAuthentication(un,pw);
				}
			});
		//msession.setDebug(true); //for debug
        Message mimeMessage = new MimeMessage(msession);
		mimeMessage.setFrom(new InternetAddress(sender));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			mimeMessage.setSubject(subject);
			//添付ファイル 
			BodyPart bodyPart = new MimeBodyPart();
			//body
			bodyPart.setText(body);
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(bodyPart);
			bodyPart = new MimeBodyPart();
 		    FileDataSource fds = new FileDataSource(file);
            bodyPart.setDataHandler(new DataHandler(fds));
 	        bodyPart.setFileName(MimeUtility.encodeText(fds.getName(), "UTF-8", "B"));			//日本語で出るように
 	        multipart.addBodyPart(bodyPart);
 	       mimeMessage.setContent(multipart);
			Transport.send(mimeMessage);
	}
}
