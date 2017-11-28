import java.io.*;
import java.util.*;
import java.net.*;
import java.text.*;
import com.sun.net.httpserver.*;

public class httpServer
{
	// main method to start server
	public static void main(String[] args) throws Exception
	{
		// get cli argument for port number
		int portNumber = Integer.parseInt(args[0]);

		// make new http server object
		HttpServer server = HttpServer.create(new InetSocketAddress(portNumber), 0);

		// set 'root' directory for response server
		server.createContext("/", new serverResponse());

		// set server return executor object to null
		server.setExecutor(null);

		// start listening
		server.start();
	}

	static class serverResponse implements HttpHandler
	{
		public void handle(HttpExchange thread) throws IOException
		{
			// make new date time object and set format
			Date dateAndTime = new Date();
			SimpleDateFormat simpleFormat = new SimpleDateFormat ("MM/dd/yyyy hh:mm");

			// convert response into byte format
			byte[] response = ("Current date and time: " + simpleFormat.format(dateAndTime)).getBytes();

			// http response code and legth
			thread.sendResponseHeaders(200, response.length);

			// new output stream of response thread
			OutputStream socketStream = thread.getResponseBody();

			// write response to stocket stream
			socketStream.write(response);

			// close socket stream
			socketStream.close();
		}
	}
}
