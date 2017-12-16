package member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	protected PasswordAuthentication getPasswordAuthentication() {
		String id = "fudinghost";
		String pass = "fuding12!@";
		return new PasswordAuthentication(id, pass);
	}
}
