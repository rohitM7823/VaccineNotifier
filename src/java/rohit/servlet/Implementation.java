package rohit.servlet;

import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import java.net.http.HttpTimeoutException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Rohit
 */

public class Implementation extends HttpServlet {

    private static Map<String, List<Fields>> container;
    protected PrintWriter out;
    private static List<Fields> list;
    public static ArrayList<Fields> fields;
    private static String url, date, pin;
    private Notification notify;

    protected static void parseJson() throws IOException, InterruptedException, IndexOutOfBoundsException, HttpTimeoutException {

        HttpClient con = HttpClient.newHttpClient();
        HttpRequest req = HttpRequest.newBuilder()
                .GET()
                .timeout(Duration.ofSeconds(10))
                .uri(URI.create(url))
                .build();

        HttpResponse<String> res = con.send(req, HttpResponse.BodyHandlers.ofString());

        if (res.statusCode() == 200) {
            JsonMapper mapper = new JsonMapper();
            mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

            container = mapper.readValue(res.body(), new TypeReference<Map<String, List<Fields>>>() {
            });

            list = container.get("sessions");
            container.clear();

        } else {
            res.statusCode();
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, InterruptedException, NullPointerException {
        response.setContentType("text/html;charset=UTF-8;");

        notify = new Notification();
        fields = new ArrayList<>();

        try {

            while (true) {

                if (!list.isEmpty()) {
                    for (int i = 0; i < list.size(); i++) {
                        if (list.get(i).getAvailable_capacity() > 0) {
                            fields.add(list.get(i));
                        }
                    }

                    if (!fields.isEmpty()) {
                        list.clear();
                        notify.sendSMS(fields.get(0).getPincode());
                        response.sendRedirect("available.jsp");
                        break;
                        
                    } 
                    else {
                        list.clear();
                        date = getLocalDate();
                        setUrl(pin, date);
                        Thread.sleep(3000);
                        parseJson();
                    }
                } 
                else {
                    date = Implementation.getLocalDate();
                    setUrl(pin, date);
                    Thread.sleep(3000);
                    parseJson();
                }
            }

        } 
        catch (IOException | InterruptedException | IndexOutOfBoundsException e){
            out.print(e.getLocalizedMessage());
        }
        
            
       

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        out = response.getWriter();

        try {
            pin = request.getParameter("usrPin");

            date = getLocalDate();
            
            setUrl(pin, date);
            
            parseJson();

            processRequest(request, response);

        } catch (InterruptedException | NullPointerException | HttpTimeoutException e) {
            out.print(e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected static String getLocalDate() {
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        LocalDate lc = LocalDate.now();

        return df.format(lc);
    }

    protected static void setUrl(String pin, String date) {
        url = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=";
        url = url.concat(pin).concat("&date=").concat(date);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
