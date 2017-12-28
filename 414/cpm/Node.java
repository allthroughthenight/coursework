package ics414fa17.CPM;

import java.io.Serializable;
import java.util.ArrayList;

public class Node implements Serializable{

	private static final long serialVersionUID = 1L;

	// the name of activity node
	private String id;

	// the time duration of activity node
	private int duration;

	// the earliest time the activity can start
	private int earliestStartTime;

	// the earliest time the activity can finish
	private int earliestFinishTime;

	// the latest time the activity can start without a delay to project
	private int latestStartTime;

	// the latest time the activity can finish without a delay to project
	private int latestFinishTime;

	// the max time an activity can delay without delaying the whole project
	private int slackTime;

	// The predecessors list that activities must finished before this one
	private ArrayList<Node> predecessors;

	// The successor list that activities must wait for this one to finish
	private ArrayList<Node> successor;

	/**
	 * constructor for creating new activity node
	 *
	 * @param newId: the unique id for identify the node
	 * @param newDur: the time duration of the node
	 */
	public Node(String newId, int newDur) {
		successor = new ArrayList<Node>();
		predecessors = new ArrayList<Node>();

		this.id = newId;
		this.duration = newDur;
		this.earliestStartTime = -1;
		this.earliestFinishTime = -1;
		this.latestStartTime = -1;
		this.latestFinishTime = -1;
	}

	/**
	 * get the slack time of node
	 * @return the slack time of node
	 */
	public int getSlackTime() {
		return slackTime;
	}

	/**
	 * set the slack time to param
	 * @param slackTime the new slack time
	 */
	public void setSlackTime(int slackTime) {
		this.slackTime = slackTime;
	}

	/**
	 * get the id of the node
	 * @return the id of node
	 */
	public String getId() {
		return id;
	}

	/**
	 * set the id of the node to param
	 * @param id the new id
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * get the duration of node
	 * @return the duration of node
	 */
	public int getDuration() {
		return duration;
	}

	/**
	 * set the duration of node to param
	 * @param duration the new duration
	 */
	public void setDuration(int duration) {
		this.duration = duration;
	}

	/**
	 * get the earliestStartTim of node
	 * @return the earliestStartTim of node
	 */
	public int getEarliestStartTime() {
		return earliestStartTime;
	}

	/**
	 * set the earliestStartTim of node to param
	 * @param earliestStartTime the new earliestStartTim
	 */
	public void setEarliestStartTime(int earliestStartTime) {
		this.earliestStartTime = earliestStartTime;
	}

	/**
	 * get the earliestFinishTime of node
	 * @return the earliestFinishTime of node
	 */
	public int getEarliestFinishTime() {
		return earliestFinishTime;
	}

	/**
	 * set the earliestFinishTime of node to param
	 * @param earliestFinishTime the new earliestFinishTime
	 */
	public void setEarliestFinishTime(int earliestFinishTime) {
		this.earliestFinishTime = earliestFinishTime;
	}

	/**
	 * get the latestStartTime of node
	 * @return the latestStartTime of node
	 */
	public int getLatestStartTime() {
		return latestStartTime;
	}

	/**
	 * set the latestStartTime of node to param
	 * @param latestStartTime the new latestStartTime
	 */
	public void setLatestStartTime(int latestStartTime) {
		this.latestStartTime = latestStartTime;
	}

	/**
	 * get the latestFinishTime of node
	 * @return the latestFinishTime of node
	 */
	public int getLatestFinishTime() {
		return latestFinishTime;
	}

	/**
	 * set the latestFinishTime of node to param
	 * @param latestFinishTime the new latestFinishTime
	 */
	public void setLatestFinishTime(int latestFinishTime) {
		this.latestFinishTime = latestFinishTime;
	}

	/**
	 * get the Predecessors list of node
	 * @return the Predecessors list of node
	 */
	public ArrayList<Node> getPredecessors() {
		return predecessors;
	}

	/**
	 * set the Predecessors list of node to param
	 * @param predecessors the new Predecessors list
	 */
	public void setPredecessors(ArrayList<Node> predecessors) {
		this.predecessors = predecessors;
	}

	/**
	 * get the successor list of node
	 * @return the successor list of node
	 */
	public ArrayList<Node> getSuccessor() {
		return successor;
	}

	/**
	 * set the successor list of node to param
	 * @param successor the new successor list
	 */
	public void setSuccessor(ArrayList<Node> successor) {
		this.successor = successor;
	}

	/**
	 *  Add a dependency node to this node's predecessor list
	 * @param newPre the new dependency node
	 */
	public void addPredecessor(Node newPre) {
		this.predecessors.add(newPre);
	}

	/**
	 * remove a dependency node from this node's predecessor list
	 * @param removeNode the dependency node want to remove
	 */
	public void removePredecessor(Node removeNode) {
		this.predecessors.remove(removeNode);
	}

	/**
	 * Add a dependency node to this node's successor list
	 * @param newSuc the new dependency nod
	 */
	public void addSuccessor(Node newSuc) {
		this.successor.add(newSuc);
	}
}