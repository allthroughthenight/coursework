import java.io.*;

public class PipeThread implements Runnable
{

	public InputStream inStream;
	public OutputStream outStream;

	public void run()
	{
		try
		{
			//set size of byte
			byte[] buffer = new byte[1024];
			int read = 1;

			//while not EOF i.e. CTL+D
			while (read > -1)
			{
				//take input and store in buffer
				read = inStream.read(buffer, 0, buffer.length);
				if (read > -1)
				{
					//output buffer
					outStream.write(buffer, 0, read);
				}
			}
		}
		catch (IOException e)
		{
			//empty
		}
		finally
		{
			try
			{
				//if no stdin, close
				if(inStream != System.in)
				{
					inStream.close();
				}
			}
			catch (Exception e)
			{
				//empty
			}
			try
			{
				//if no stdout, close
				if(outStream != System.out)
				{
					outStream.close();
				}
			}
			catch (Exception e)
			{
				//empty
			}
		}
	}

	//redirect input of proc to output given
	public PipeThread(InputStream inStream, OutputStream outStream)
	{
		this.inStream = inStream;
		this.outStream = outStream;
	}

	public static InputStream pipe(Process[] proc) throws InterruptedException
	{
		//out process
		Process proc1;

		//in process
		Process proc2;

		for (int i = 0; i < proc.length; i++)
		{
			proc1 = proc[i];

			//see if process to pipe to
			if (i + 1 < proc.length)
			{
				//set in process
				proc2 = proc[i+1];

				//start process
				Thread t = new Thread(new PipeThread(proc1.getInputStream(), proc2.getOutputStream()));
				t.start();
			}
		}

		Process wait = proc[proc.length -1];

		//wait
		wait.waitFor();

		//don't return till all output collected and finished then get input
		return wait.getInputStream();
	}
}
