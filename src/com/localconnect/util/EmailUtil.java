package com.localconnect.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    public static void sendEmail(String toEmail, String subject, String otp) {
        // Your email and app password
        final String fromEmail = "secure.go0gle.outlook@gmail.com";
        final String password = "ojtn zskv slme edgn"; // ⚠️ Use App Password, not Gmail password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "LocalConnect"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject(subject);

            // ✅ Professional HTML email template
            String body = "<!DOCTYPE html>" +
                    "<html>" +
                    "<head>" +
                    "  <meta charset='UTF-8'>" +
                    "  <style>" +
                    "    body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }" +
                    "    .container { max-width: 600px; margin: 30px auto; background: #ffffff; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); overflow: hidden; }" +
                    "    .header { background: linear-gradient(90deg, #6a11cb, #2575fc); padding: 20px; text-align: center; color: white; }" +
                    "    .header h2 { margin: 0; font-size: 22px; }" +
                    "    .content { padding: 20px; color: #333333; }" +
                    "    .otp-box { margin: 20px auto; padding: 15px; font-size: 24px; font-weight: bold; text-align: center; border: 2px dashed #2575fc; background: #f0f8ff; border-radius: 5px; width: fit-content; }" +
                    "    .footer { font-size: 12px; color: #888888; text-align: center; padding: 15px; background: #fafafa; border-top: 1px solid #eeeeee; }" +
                    "  </style>" +
                    "</head>" +
                    "<body>" +
                    "  <div class='container'>" +
                    "    <div class='header'>" +
                    "      <h2>LocalConnect Security</h2>" +
                    "    </div>" +
                    "    <div class='content'>" +
                    "      <p>Hello,</p>" +
                    "      <p>We received a request to reset your password. Use the OTP below to proceed:</p>" +
                    "      <div class='otp-box'>" + otp + "</div>" +
                    "      <p>This OTP will expire in <b>5 minutes</b>.</p>" +
                    "      <p>If this wasn’t you, we recommend securing your account immediately.</p>" +
                    "      <p>Thank you,<br><b>LocalConnect Team</b></p>" +
                    "    </div>" +
                    "    <div class='footer'>" +
                    "      <p>You received this email because of a password reset request on LocalConnect.</p>" +
                    "      <p>© 2025 LocalConnect. All rights reserved.</p>" +
                    "    </div>" +
                    "  </div>" +
                    "</body>" +
                    "</html>";

            // ✅ Send HTML instead of plain text
            msg.setContent(body, "text/html; charset=utf-8");

            Transport.send(msg);
            System.out.println("✅ Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
