import java.io.*;
import java.util.*;

public class Jsh
{
	//string of raw user input command
	public static String command;

	//File of directory to change to
	public File nextDirectory;

	//current working directory
	public String workingDirectory = System.getProperty("user.dir");

	//user directory
	public String userDir;

	//string array of all jobs
	public String allJobs[] = new String[100];

	//number of jobs running
	public int jobsRunning = 0;

	//proccess array of processes ran with pipe '|'
	public Process proc[];

	//proccess array of background processes
	public Process processes[] = new Process[100];

	//class to take command
	public Jsh(String s)
	{
		command = s;
	}

	//main method
	public static void main(String[] args) throws IOException, InterruptedException
	{
		Jsh pbe = new Jsh(command);

		//input buffer reader
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));

		//initial prompt print
		System.out.print("jsh> ");

		//input loop
		while ((command = input.readLine()) != null)
		{
			//remove leading/trailing command whitespace
			command = command.trim();

			if (command.length() != 0)
			{
				pbe.runProcess();
			}
			System.out.print("jsh> ");
		}

		//exit message
		System.out.println("\nbye");
		input.close();
	}

	public void runProcess() throws IOException, InterruptedException
	{

		//to build process to run
		ProcessBuilder procBuilder = null;

		//end process to run
		Process runningProcess = null;

		//remove leading/trailing input whitespace
		command = command.trim();

		//begin pipe char '|' check
		if (command.contains("|"))
		{
			//can't use cd with pipe
			if(command.contains("cd"))
			{
				System.err.println("Non-valid pipe usage");
				return;
			}

			//split commands at pipe
			String[] commandPipe = command.split("[|]");

			//wrong syntax for pipe
			if(commandPipe.length <= 1 || commandPipe[0].equals(""))
			{
				System.err.println("Non-valid pipe usage");
				return;
			}

			//check pipe usage
			if (commandPipe.length > 1)
			{

				//loop through array of pipe processes array
				proc = new Process[commandPipe.length];
				for (int i = 0; i < commandPipe.length; i++)
				{
					commandPipe[i] = commandPipe[i].trim();

					//must have commands to pipe i.e. not empty
					if(commandPipe[i].equals(""))
					{
						System.err.println("Non-valid pipe usage");
						return;
					}

					//parse command
					String[] commandPipeTokens = commandPipe[i].split("[ \t\n]+");

					//pass commands to proc builder
					procBuilder = new ProcessBuilder(commandPipeTokens);

					//change directory if command done and valid
					nextDirectory = new File(workingDirectory);
					procBuilder.directory(nextDirectory);

					try
					{

						proc[i] = procBuilder.start();
					}
					catch (IOException e)
					{
						System.err.println("Unknown command " + "'" + commandPipeTokens[0] + "'");
						return;
					}

					//catch error stream
					InputStream err = proc[i].getErrorStream();

					//start thread
					Thread t = new Thread(new PipeThread(err, System.out));
					t.start();
				}

				//use pipe thread to direct output of first commend to input of second
				InputStream inStream = PipeThread.pipe(proc);

				//start thread
				Thread t = new Thread(new PipeThread(inStream, System.out));
				t.start();

			}
			return;
		}
		//end pipe char '|' check

		//parse command string into an array
		String[] commandTokens = command.split("[ \t\n]+");

		//process builder with parsed command array
		procBuilder = new ProcessBuilder(commandTokens);

		//sets working dir
		nextDirectory = new File(workingDirectory);
		procBuilder.directory(nextDirectory);

		//begin ampersand char '&' check
		if (commandTokens[commandTokens.length - 1].equals("&"))
		{
			//check that command can't be put in the background
			if (commandTokens[0].equals("fg") || commandTokens[0].equals("jobs") || commandTokens[0].equals("cd"))
			{
				System.err.print("Error: cannot put '" + commandTokens[0] + "' in the background\n");
			}
			else
			{
				//get command to run in the background
				command = command.substring(0, command.length() - 1);

				//parse command
				commandTokens = command.split("[ \t\n]+");

				//pass command to proc builder
				procBuilder = new ProcessBuilder(commandTokens);

				//change dir if done and valid
				nextDirectory = new File(workingDirectory);
				procBuilder.directory(nextDirectory);

				//run process without outputting std1 or stderr
				BackgroundProcesses bp = new BackgroundProcesses(jobsRunning, procBuilder, commandTokens, allJobs, processes);

				//inc jobs running
				jobsRunning++;
			}
		}
		//end ampersand char '&' check

		//begin change directory 'cd' command check
		else if (commandTokens[0].equals("cd"))
		{
			//length syntax error
			if (commandTokens.length > 2)
			{
				System.err.print("Syntax error\n");
			}

			//return to starting dir for 'cd' or 'cd /'
			else if (commandTokens.length == 1 || commandTokens[1].equals("/"))
			{
				workingDirectory = System.getProperty("user.dir");
				nextDirectory = new File(workingDirectory);
				procBuilder.directory(nextDirectory);
				return;
			}

			//up one directory i.e. parent directory
			else if (commandTokens[1].equals(".."))
			{
				nextDirectory = new File(workingDirectory);
				workingDirectory = nextDirectory.getParent();
				procBuilder.directory(nextDirectory);
				return;
			}

			//unable to run cd in the background
			else if (commandTokens[1].equals("&"))
			{
				System.err.print("Error: cannot put '" + commandTokens[0] + "' in the background\n");
				return;
			}

			//change directory if possible
			else
			{
				//directory to change to
				userDir = commandTokens[1];

				//directory to move to changed
				nextDirectory = new File(userDir);

				//if the next directory exists, change
				if (nextDirectory.exists() == true)
				{
					workingDirectory = nextDirectory.getCanonicalPath();
				}

				//if directory doesn't exist, invalid
				else if (nextDirectory.exists() == false)
				{
					System.err.print("Invalid directory " + commandTokens[1] + "\n");
				}
			}
		}
		//end change directory 'cd' command check

		//begin background 'jobs' command check
		else if (commandTokens[0].equals("jobs"))
		{
			//if command valid
			if (commandTokens.length == 1)
			{
				//loop through and print running commnds
				for (int i = 0; i < jobsRunning; i++)
				{
					//if job is still in the array, print it
					if (allJobs[i] != null)
					{
						System.out.print("[" + (i + 1) + "] " + allJobs[i] + "\n");
					}
				}
			}

			//too many arguments
			else if (commandTokens.length > 2)
			{
				System.err.print("Syntax error\nUsage: jobs 'n' where n is the job ID \n");
			}

			//can't run jobs in the background
			else if (commandTokens[1].equals("&"))
			{
				System.err.print("Error: cannot put '" + commandTokens[0] + "' in the background\n");
				return;
			}

			//general syntax error
			else
			{
				System.err.print("Syntax error\n");
			}
		}
		//end background 'jobs' command check

		//begin forground 'fg' command check
		else if (commandTokens[0].equals("fg"))
		{
			try
			{
				//checks for wrong syntax
				if (commandTokens.length < 2 || commandTokens.length > 2)
				{
					System.err.print("Usage: fg 'n' where n is a number\n");
					return;
				}

				//can't run 'fg' in the background
				else if (commandTokens[1].equals("&"))
				{
					System.err.print("Error: cannot put '" + commandTokens[0] + "' in the background\n");
					return;
				}

				//parse job input string as int
				int processNum = Integer.parseInt(commandTokens[1]);

				//valid fg syntax
				if (commandTokens.length == 2)
				{
					//checks for invalid arguments
					if (processNum > jobsRunning || processNum <= 0 || allJobs[processNum - 1] == null)
					{
						System.err.print("No such background command\n");
						return;
					}

					//can't run 'fg' in the background
					else if (commandTokens[1].equals("&"))
					{
						System.err.print("Error: cannot put '" + commandTokens[0] + "' in the background\n");
						return;
					}

					//valid arguments
					else
					{
						try
						{
							//wait and move job to foreground
							processes[processNum - 1].waitFor();

							//remove from jobs array
							allJobs[processNum - 1] = null;
						}
						catch (InterruptedException e)
						{
							e.printStackTrace();
						}
					}
				}
			}

			//general syntax error
			catch (NumberFormatException e)
			{
				System.err.print("Syntax error\n");
			}
		}
		//end forground 'fg' command check

		//check other commands
		else
		{
			//rune process, else unknown
			try
			{
				runningProcess = procBuilder.start();
			}
			catch (IOException e)
			{
				System.err.println("Unknown command '" + commandTokens[0] + "'");
				return;
			}

			//grab output streams
			InputStream inStream = runningProcess.getInputStream();
			InputStream errStream = runningProcess.getErrorStream();

			//start threads
			Thread t = new Thread(new PipeThread(inStream, System.out));
			t.start();
			Thread t2 = new Thread(new PipeThread(errStream, System.out));
			t2.start();


			//wait for the process to terminate
			try
			{
				int returnValue = runningProcess.waitFor();
			}
			catch (InterruptedException e)
			{
			}

			//close streams
			try
			{
				inStream.close();
				errStream.close();
			}
			catch (IOException e)
			{
				System.err.println("IO Error");
			}

			//stop running process
			runningProcess.destroy();
			return;
		}
		//end other commands
	}
}
