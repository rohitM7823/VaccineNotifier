/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rohit.servlet;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;




public class Notification {
    private static final String ASID = "ACae79febf168f5a931dcf74856aa80027";
    private static final String AUTH = "fc416d281976278dd245d9e3f94b166e";
    private String targetNumber = "+917003844205";
    public static String sender = "+16196485047";
    
   
    public void sendSMS(int pincode) {
        
        Twilio.init(ASID, AUTH);
        Message message = Message.creator(
                new PhoneNumber(targetNumber),
                new PhoneNumber(sender),
                "Vaccine Available in Your Pincode "+pincode+"\n\nFind Nearest Center - "+
                        "http://localhost:8080/VaccineNotifier/available.jsp").create();
        
    }

  
}
