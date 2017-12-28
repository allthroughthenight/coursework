import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.Queue;

public class NodeList implements Serializable{
	
	private static final long serialVersionUID = 1L;

	// array list use to store the nodes
	private ArrayList<Node> nodes;
	
	// the size of nodes
	private int size;
	
	/**
	 * Constructor for initializing the node list
	 */
	public NodeList() {
		this.nodes = new ArrayList<Node>(20);
		this.size = 0;
	}

	/**
	 * Add a new node to list
	 * @param newNode the new node
	 */
	public void addNode(Node newNode) {
		this.nodes.add(newNode);
		size ++;
	}
	
	/**
	 * remove a node from list and delete it from all node claim it as dependency
	 * @param rmNode the node want to remove
	 * @return true if removed, false otherwise
	 */
	public boolean removeNode(Node rmNode) {
		boolean removed = this.nodes.remove(rmNode);
		for(Node node : nodes) {
			node.getPredecessors().remove(rmNode);
		}
		size --;
		return removed;
	}
	
	/**
	 * reset all the information of node 
	 */
	public void clearInfo() {
		for(Node node : nodes) {
			node.getSuccessor().clear();
			node.setEarliestStartTime(-1);
			node.setEarliestFinishTime(-1);
			node.setLatestStartTime(-1);
			node.setLatestFinishTime(-1);
		}
	}
	
	/**
	 * set up the successor list of each node
	 */
	public void setSuccessor() {
		for(Node node : nodes) {
			for(Node pred : node.getPredecessors()) {
				pred.addSuccessor(node);
			}
		}
	}
	
	/**
	 * forward pass to calculate the earliest start time and earliest finish time
	 */
	public void forwardPass() {
		for(Node node : nodes) {
			if(node.getPredecessors().size() == 0) {
				node.setEarliestStartTime(0);
				node.setEarliestFinishTime(node.getEarliestStartTime()
						+ node.getDuration());
			} else {
				for(Node pred : node.getPredecessors()) {
					if(node.getEarliestStartTime() < pred.getEarliestFinishTime()) {
						node.setEarliestStartTime(pred.getEarliestFinishTime());
					}
				}
				node.setEarliestFinishTime(node.getEarliestStartTime()
						+ node.getDuration());
			}
		}
	}
	
	/**
	 * backward pass to calculate the latest start time and latest finish time
	 */
	public void backwardPass() {
		int max = nodes.get(0).getEarliestFinishTime();
		for(Node node : nodes) {
			if(node.getEarliestFinishTime() > max) {
				max = node.getEarliestFinishTime();
			}
		}
		Collections.reverse(nodes);
		for(Node node : nodes) {
			if(node.getSuccessor().size() == 0) {
				node.setLatestFinishTime(max);
				node.setLatestStartTime(max - node.getDuration());
			} else {
				node.setLatestFinishTime(node.getSuccessor().get(0).getLatestStartTime());
				for(Node suc : node.getSuccessor()) {
					if(node.getLatestFinishTime() > suc.getLatestStartTime()) {
						node.setLatestFinishTime(suc.getLatestStartTime());
					}
				}
				node.setLatestStartTime(node.getLatestFinishTime() - node.getDuration());
			}
		}
		Collections.reverse(nodes);
	}
	
	/**
	 * compute all information of each node
	 */
	public void fillAllInfo() {
		clearInfo();
		setSuccessor();
		forwardPass();
		backwardPass();
		for(Node node : nodes) {
			node.setSlackTime(node.getLatestStartTime() - node.getEarliestStartTime());
		}
	}
	
	/**
	 * Print out the critical path
	 */
	public String criticalPath() {
		StringBuilder path = new StringBuilder("Critical Path:\nStart ->");
		for(Node node : nodes) {
			if((node.getSlackTime()) == 0) {
				path.append(node.getId() + " -> ");
			}
		}
		
		path.append("End");
		
		return path.toString();
	}
	
	/**
	 * topological sort the list so we can use forward and backward pass, etc
	 * @return the topological sorted list
	 */
	public ArrayList<Node> topologicalSort() {
		int[] indegree = new int[size];
		ArrayList<Node> ret = new ArrayList<Node>();
		for(int i = 0; i < size; i++) {
			indegree[i] = nodes.get(i).getPredecessors().size();
		}
		Queue<Node> queue = new LinkedList<Node>();
		for(int i = 0; i < size; i++) {
			if(indegree[i] == 0) {
				queue.offer(nodes.get(i));
				ret.add(nodes.get(i));
			}
		}
		
		while(!queue.isEmpty()) {
			Node pre = queue.poll();
			for(int i = 0; i < size; i++) {
				if(nodes.get(i).getPredecessors().contains(pre)) {
					indegree[i] --;
					if(indegree[i] == 0) {
						queue.offer(nodes.get(i));
						ret.add(nodes.get(i));
					}
				}
			}
		}
		
		return ret;
	}
	
	/**
	 * find the node in list by its name
	 * @param name the name of node 
	 * @return the node we are looking for
	 */
	public Node findNode(String name) {
		for(Node node: nodes) {
			if(node.getId().equals(name)) {
				return node;
			}
		}
		return null;
	}
	
	/**
	 * get the node list
	 * @return the node list
	 */
	public ArrayList<Node> getNodes() {
		return nodes;
	}

	/**
	 * set the node list to the param
	 * @param nodes the new node list
	 */
	public void setNodes(ArrayList<Node> nodes) {
		this.nodes = nodes;
	}
	
	/**
	 * get the size of node list
	 * @return the size of node list
	 */
 	public int getSize() {
		return size;
	}

}
