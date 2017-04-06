import java.io.*;
import java.util.*;
import java.lang.*;

/**
 * FlipFlop --- print 'flip' or 'flop' using threads
 *
 * @version 1.0
 **/
public class FlipFlop
{
	public static int printCount = 20;

	/**
	 * Start threads to print 'flip' and 'flop'.
	 * @param x sleep time for thread one
	 * @param y sleep time for thread two
	 * @return none
	 **/
	public static void startFlipFlop(int x, int y)
	{

		//make new flip thread
		Thread flip = new Thread()
		{
			//make new run method
			public void run()
			{
				//use flipOut method to print 'flip' to stdout
				try
				{
					flipOut();
				}
				catch (Exception e)
				{
				}
			}
		};

		//sleep flip thread for x amount of time
		try
		{
			flip.sleep(x);
		}
		catch (Exception e)
		{
		}

		//ake new flop thread
		Thread flop = new Thread()
		{
			//make new run method
			public void run()
			{
				//use flopOut method to print 'flop' to stderr
				try
				{
					flopOut();
				}
				catch (Exception e)
				{
				}
			}
		};

		//sleep flip thread for x amount of time
		try
		{
			flop.sleep(y);
		}
		catch (Exception e)
		{
		}

		// run the threads
		flop.start();
		flip.start();
	}

	/**
	 * Print 'flop' to stdout.
	 * @param none
	 * @return none
	 **/
	public static void flopOut() throws InterruptedException
	{
		for (int i = 0; i < printCount; i++)
		{
			System.out.print("flip\n");
		}
	}

	/**
	 * Print 'flip' to stderr.
	 * @param none
	 * @return none
	 **/
	public static void flipOut() throws InterruptedException
	{
		for (int i = 0; i < printCount; i++)
		{
			System.err.print("flop\n");
		}
	}

	/**
	 * Run 'startFlipFlop' to print 'flip' and 'flop'.
	 * @param arg1 time to sleep thread 1
	 * @param arg2 time to sleep thread 2
	 * @return none
	 **/
	public static void main(String [] args)
	{
		//take cli arguments and cast to integers
		int x = Integer.parseInt(args[0]);
		int y = Integer.parseInt(args[1]);

		//call start flip flop with cli arguments
		startFlipFlop(x, y);
	}
}
