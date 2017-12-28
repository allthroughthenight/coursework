import java.io.*;

public class PipeThread extends Thread
{
	InputStream inStream;
	OutputStream outStream;

	/**
	 * Redirects given input to given output.
	 *
	 * @param inStream input stream to redirect from
	 * @param outStream output stream to redirect to
	 * @return none
	 **/
	public PipeThread(InputStream inStream, OutputStream outStream)
	{
		this.inStream = inStream;
		this.outStream = outStream;
	}

	/**
	 * Read input until empty
	 * @exception any
	 * @return none
	 **/
	public void run(){
		try
		{
			//read input until empty
			int input = inStream.read();
			while (input != -1)
			{
				outStream.write(input);
				input = inStream.read();
			}
		}
		catch(Exception e)
		{
		}
	}
}
