package schedulingalgorithms;

import schedulingsimulation.*;
import java.util.*;

public class SchedulingAlgorithmRoundRobin implements SchedulingAlgorithm
{

	Queue<SimulatedProcess> queue = null;

	public SchedulingAlgorithmRoundRobin()
	{
		queue = new LinkedList<SimulatedProcess>();
	}

	public void handleCPUBurstCompletionEvent(SimulatedProcess process)
	{
		if ((queue.size() != 0) && (SchedulingMechanisms.getRunningProcess() == null))
		{
			SchedulingMechanisms.dispatchProcess(queue.poll(), 10);
		}
		return;
	}

	public void handleExpiredTimeSliceEvent(SimulatedProcess process)
	{
		if ((queue.size() != 0) && (SchedulingMechanisms.getRunningProcess() == null))
		{
			SchedulingMechanisms.dispatchProcess(queue.poll(), 10);
		}
		return;
	}

	public void handleProcessReadyEvent(SimulatedProcess process)
	{
		queue.offer(process);
		if ((queue.size() != 0) && (SchedulingMechanisms.getRunningProcess() == null))
		{
			SchedulingMechanisms.dispatchProcess(queue.poll(), 10);
		}
	}
}
