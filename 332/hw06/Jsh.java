import java.io.*;
import java.lang.*;
import java.util.*;

public class Jsh
{

	/**
	 * Run shell process
	 *
	 * @param none
	 * @return non
	 **/
	public static int runProcess()
	{

		//reader for shell input
		BufferedReader shellInput = new BufferedReader(new InputStreamReader(System.in));

		//working directory
		String workingDirectory = (System.getProperty("user.dir"));

		//command string
		String command = "";

		try
		{
			while(true)
			{

				//shell prompt
				System.out.print("jsh> ");

				//read input till new line i.e. enter
				command = shellInput.readLine();

				//remove leading/trailing white spaces
				command = command.trim();

				//split input string into an array
				String[] commandArray = command.split("[ \t\n]+");

				//ignore empty command i.e. just pressing enter
				if (command.equals("\n") || command.equals(""))
				{
					continue;
				}
				//cd block
				else if (commandArray[0].equals("cd"))
				{
					//check path of second argument
					if (new File(commandArray[1]).exists())
					{
						//change working directory
						workingDirectory = (new File(commandArray[1])).toString();
						continue;
					}
					else if (commandArray.length > 2)
					{
						//bad syntax
						System.out.println("Invalid syntax");
						continue;
					}
					else
					{
						//bad directory
						System.out.println("Invalid directory " + commandArray[1]);
						continue;
					}

				}
				ProcessBuilder processBuilder = null;
				Process process = null;

				try
				{
					//change directory to workingDirectory
					processBuilder = new ProcessBuilder(commandArray);
					processBuilder.directory(new File(workingDirectory));

					//start process
					process = processBuilder.start();

					//input streams for stdout and stderr
					InputStream stderrStream = process.getErrorStream();
					InputStream stdoutStream = process.getInputStream();

					//print stream
					PrintStream printSteam = new PrintStream(System.out);

					//pipeThreads for the running process
					PipeThread pipeOne = new PipeThread(stdoutStream, printSteam);
					PipeThread pipeTwo = new PipeThread(stderrStream, printSteam);

					//start the processes using pipeThread
					pipeOne.start();
					pipeTwo.start();

					try
					{
						pipeOne.join();
						pipeTwo.join();
					}
					catch (Exception e)
					{
					}

					//close the streams
					stderrStream.close();
					stdoutStream.close();
				}
				catch (Exception e)
				{

					//error if command is wrong
					System.out.println("Unknown command \'" + commandArray[0] + "\'");
					continue;
				}

				//destroy/clean-up process
				process.destroy();
			}
		}
		catch (Exception e)
		{

			//exit message
			System.out.println("\nBye");
		}
		return 0;
	}

	/**
	 * Run 'runProcess' to run the shell
	 *
	 * @param none
	 * @return none
	 **/
	public static void main(String[]args)
	{
		runProcess();
	}
}
