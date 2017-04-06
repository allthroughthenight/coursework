/**
 * course: 332
 *
 * assignment: programming assginment 3
 *
 * file: jsh.java
 *
 * description: a shell implementation using process builder
 *
 */

import java.io.*;
import java.util.*;

public class jsh
{
	public static void main(String[] args) throws IOException
	{

		//working directory
		String workingDirectory = (System.getProperty("user.dir"));
		boolean run = true;

		while (run)
		{

			//shell prompt
			System.out.print("jsh> ");

			//user input
			Scanner input = new Scanner(System.in);
			String command = input.nextLine();

			//parse input by spaces and place in array
			String[] splitCommand = command.split(" ");

			//make new process
			ProcessBuilder probuilder = new ProcessBuilder(splitCommand);

			//set home directory
			probuilder.directory(new File (workingDirectory));

			//check if command is to change directory
			if ((new String(splitCommand[0]).equals("cd")))
			{
				//check if diretory exist, else return error
				if ((new File (splitCommand[1])).exists())
				{
					workingDirectory = (splitCommand[1]);
					probuilder.directory(new File (workingDirectory));
				}
				//bs requirement to have a syntax error print out
				//just for 'cd'
				else if (splitCommand.length > 2)
				{
					System.out.println("Invalid syntax");
				}
				else
				{
					System.out.println("Invalid directory " + splitCommand[1]);
				}
			}

			//process to run command
			Process process = null;

			try {
				//execute command
				process = probuilder.inheritIO().start();
				InputStream sstderr = process.getErrorStream();
				InputStream sstdout = process.getInputStream();
				OutputStream sstdin  = process.getOutputStream();

				//collect stderr, stdout, and stdin
				BufferedReader stderr = new BufferedReader(new InputStreamReader(sstderr));
				BufferedReader stdout = new BufferedReader(new InputStreamReader(sstdout));
				BufferedWriter stdin = new BufferedWriter(new OutputStreamWriter(sstdin));

				//sleep for a bit to give prompt time to print
				try {
					Thread.sleep(10);
				} catch(InterruptedException ex) {
					Thread.currentThread().interrupt();
				}
			}
			catch (Exception e) {
				if (new String(splitCommand[0]).equals(""))
				{
					//ignore if there is no command
				}
				else if (new String(splitCommand[0]).equals("cd"))
				{
					//ignore when changing directories
				}
				else
				{
					System.out.println("Unknown command \'" + splitCommand[0] + "\'");
				}
			}
		}
	}
}
