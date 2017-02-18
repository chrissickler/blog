package blog;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class EmailSender {
    public static boolean sendMail(String from,String password,String message,ArrayList<String> to)
    {
        String host="smtp.gmail.com";
        Properties props=System.getProperties();
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.host",host);
        props.put("mail.smtp.user",from);
        props.put("mail.smtp.password",password);
        props.put("mail.smtp.port",25);
        props.put("mail.smtp.auth","true");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.socketFactory.port", 25);
        
        
        
        Session session=Session.getDefaultInstance(props,null);
        session.setDebug(true);
        MimeMessage mimeMessage=new MimeMessage(session);
        try
        {
            mimeMessage.setFrom(new InternetAddress(from));
            InternetAddress[] toAddress=new InternetAddress[to.size()];
            for(int i=0;i<to.size();i++)
            {
                toAddress[i]=new InternetAddress(to.get(i));
            }
            for(int i=0;i<toAddress.length;i++)
            {
                mimeMessage.addRecipient(RecipientType.TO,toAddress[i]);
            }
            mimeMessage.setSubject("Blog Posts from the last 24 hours");// subject of email
            mimeMessage.setText(message);
            Transport transport=session.getTransport("smtp");
            transport.connect(host,from,password);
            transport.sendMessage(mimeMessage,mimeMessage.getAllRecipients());
            transport.close();
            return true;
        }
        catch(MessagingException me)
        {
            me.printStackTrace();
        }
        return false;
    }
}