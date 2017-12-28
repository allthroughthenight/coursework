package schedulingalgorithms;

import schedulingsimulation.*;
import java.util.*;

public class SchedulingAlgorithmNonPreemptiveFCFS implements SchedulingAlgorithm
{

	Queue<SimulatedProcess> queue = null;

	public SchedulingAlgorithmNonPreemptiveFCFS()
	{
		queue = new LinkedList<SimulatedProcess>();
	}

	public void handleCPUBurstCompletionEvent(SimulatedProcess process)
	{
		if (SchedulingMechanisms.getRunningProcess() == null)
		{
			SchedulingMechanisms.dispatchProcess(queue.poll(), -1);
		}
		return;
	}

	public void handleExpiredTimeSliceEvent(SimulatedProcess process)
	{
		if (SchedulingMechanisms.getRunningProcess() == null)
		{
			SchedulingMechanisms.dispatchProcess(queue.poll(), -1);
		}
		return;
	}

	public void handleProcessReadyEvent(SimulatedProcess process)
	{
		if (SchedulingMechanisms.getRunningProcess() == null)
		{
			SchedulingMechanisms.dispatchProcess(queue.poll(), -1);
		}
	}
}
