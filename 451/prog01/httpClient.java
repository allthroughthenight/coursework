import java.io.*;
import java.net.*;
import java.util.*;
import javax.net.ssl.HttpsURLConnection;

public class httpClient {

	public static void main(String[] args) throws Exception {

		// make new http client
		httpClient http = new httpClient();

		// send http get
		http.sendGet(Integer.parseInt(args[0]));
	}

	public void sendGet(int portNumber) throws Exception {

		// url to access
		String url = "http://127.0.0.1:" + portNumber;

		// make url object and connect to it
		URL obj = new URL(url);
		HttpURLConnection connection = (HttpURLConnection) obj.openConnection();

		// new buffered reader of conenction
		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		// read entire response and close when done
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		//print result
		System.out.println(response.toString());
	}
}
