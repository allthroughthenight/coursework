import java.io.*;
import java.util.*;
import java.lang.*;

/**
 * ForkFlipFlop --- call 'FlipFlop' using pipethread
 *
 * @version 1.0
 **/
public class ForkFlipFlop {

	/**
	 * ForkFlipFlop --- call 'FlipFlop' using pipethread
	 * @param none
	 * @return none
	 **/
	public static void main(String [] args)
	{
		String x = args[0];
		String y = args[1];

		String path = "";
		String program = "FlipFlop";

		try
		{
			ProcessBuilder forkFlipFlop = new ProcessBuilder("java", "-classpath", path, program, x, y);
			new ProcessBuilder("java", "-classpath", program, x, y).directory(new File(path));

			//start process
			Process process = forkFlipFlop.start();

			//direct stdin and stderr to stdout
			InputStream stdIn = process.getInputStream();
			InputStream stdErr = process.getErrorStream();
			PrintStream outStream = new PrintStream(System.out);

			//use pipethread to print to stdout
			new PipeThread(stdIn, outStream).start();
			new PipeThread(stdErr, outStream).start();

		}
		catch(Exception e)
		{
		}
	}
}
