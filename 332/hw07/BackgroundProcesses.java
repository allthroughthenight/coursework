import java.io.IOException;
import java.io.InputStream;

public class BackgroundProcesses
{

	//jobs running
	private int jobNumbers;

	//proccess to run
	private Process proc;

	//proc builder
	private ProcessBuilder procBuilder;

	//input command tokens
	private String commndTokens[];

	//array to track jobs running
	private String jobs[];

	//array of process actually running
	private Process processes[];

	class MyTask implements Runnable
	{
		//definition for run
		public void run()
		{
			//run current given job
			try
			{
				//start proc builder
				proc = procBuilder.start();

				//next job to run
				processes[jobNumbers] = proc;
			}
			catch (IOException e)
			{
				System.err.println("Unknown command " + "'" + commndTokens[0] + "'");
				return;
			}

			//move jobs to end of list based on jobNumbers
			int i = 0;
			String strCommand = "";
			while (i < commndTokens.length && !commndTokens[i].equals("&"))
			{
				strCommand += " " + commndTokens[i];
				i++;
			}

			jobs[jobNumbers] = strCommand;

			//get process streams
			InputStream inStream = proc.getInputStream();
			InputStream errStream = proc.getErrorStream();

			//redirect streams using pipe thread
			PipeThread inputReader = new PipeThread(inStream, System.out);
			PipeThread errReader = new PipeThread(errStream, System.err);

			try
			{
				//get exit value
				int returnValue = proc.waitFor();
			}
			catch (InterruptedException e)
			{
				//empty
			}

			// close streams
			try
			{
				inStream.close();
				errStream.close();
			}
			catch (IOException e)
			{
				System.err.println("IO Error");
			}

			//sleep thread
			try
			{
				Thread.sleep(100);
			}
			catch (InterruptedException e)
			{
				//empty
			}
			//stop running
			proc.destroy();
		}
	}

	//move evertyhing for given process to the background
	public BackgroundProcesses(int jobNumbers, ProcessBuilder procBuilder, String commndTokens[], String jobs[], Process processes[])
	{
		this.jobNumbers = jobNumbers;
		this.procBuilder = procBuilder;
		this.commndTokens = commndTokens;
		this.jobs = jobs;
		this.processes = processes;

		//start in background
		Thread t = new Thread(new MyTask());
		t.start();
	}
}
