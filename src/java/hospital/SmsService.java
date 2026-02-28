package hospital;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class SmsService {
    public static void sendSms(String mobile, String message) {
        try {
            String apiKey = "your_msg91_api_key"; // Replace with your actual MSG91 API key
            String senderId = "HOSPIT";           // Approved sender ID
            String route = "4";                   // Transactional route
            String country = "91";                // Country code for India

            String url = "https://api.msg91.com/api/sendhttp.php?" +
                         "mobiles=" + mobile +
                         "&authkey=" + apiKey +
                         "&message=" + URLEncoder.encode(message, "UTF-8") +
                         "&sender=" + senderId +
                         "&route=" + route +
                         "&country=" + country;

            HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
            conn.setRequestMethod("GET");
            conn.getResponseCode(); // Optional: check response
        } catch (Exception e) {
            System.err.println("SMS failed: " + e);
        }
    }
}
