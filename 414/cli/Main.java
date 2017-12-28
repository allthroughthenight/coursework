import java.util.ArrayList;
import java.util.Scanner;

public class Main {
	
	public static NodeList list = new NodeList();
	
	public static void main(String[] args) {
		
		// populate list with some nodes for testing
		Node n1 = new Node("A", 5);
		Node n2 = new Node("B", 6);
		n2.addPredecessor(n1);
		Node n3 = new Node("C", 3);
		n3.addPredecessor(n1);
		Node n4 = new Node("D", 4);
		n4.addPredecessor(n2);
		Node n5 = new Node("E", 2);
		n5.addPredecessor(n2);
		n5.addPredecessor(n3);
		Node n6 = new Node("F", 1);
		n6.addPredecessor(n4);
		n6.addPredecessor(n5);

		list.addNode(n1);
		list.addNode(n2);
		list.addNode(n3);
		list.addNode(n4);
		list.addNode(n5);
		list.addNode(n6);
		list.setNodes(list.topologicalSort());
		list.fillAllInfo();
		
		
		MainWindow menu = new MainWindow();
		menu.drawGUI();
		String menuInput = "0";
		
		Scanner reader = new Scanner(System.in);
		System.out.println("AoN Team Pitaya v1.1 copyright 2017");
		
		while(true) {
			
			System.out.println
			(
					"+-----------------------+\n" +
					"| Main Menu             |\n" +
					"| 1) Add Node           |\n" +
					"| 2) Remove Node        |\n" +
					"| 3) Change Node        |\n" +
					"| 4) Print All Nodes    |\n" +
					"| 5) Critical Path      |\n" +
					"| 6) Topological Order  |\n" +
					"| 7) Clear Screen       |\n" +
					"| 8) Exit               |\n" +
					"+-----------------------+"
			);
			
			System.out.print("Please enter a number: ");
			menuInput = reader.nextLine();
			
			switch(menuInput) {
				case "1": // add node
					boolean input = false;
					String name;
					int duration = 0;
					
					// ask for name of activity
					do {
						System.out.print("What is the name of your activity? ");
						name = reader.nextLine();
						if(list.findNode(name) != null) {
							System.out.println("The activity with the same name is already exist.");
							System.out.println("Try again.");
						}
					} while(list.findNode(name) != null);
					
					// ask for duration of activity
					do {
						try {
							System.out.print("How long is the activity? ");
							duration = Integer.parseInt(reader.nextLine());
							input = false;
						} catch(NumberFormatException e) {
							input = true;
						}
						
						if(duration <= 0) {
							input = true;
							System.out.println("Please enter a valid number(>0)");
						}
					} while(input);
					
					Node add = new Node(name, duration);
					
					// ask for the dependency of activity
					while(true) {
						System.out.println("Please enter the name of activity that must");
						System.out.println("be finished before this one(One at a time) or");
						System.out.println("enter EXIT to end inputing dependencies");
						String prename = reader.nextLine();
						
						if(prename.equals("EXIT")) {
							break;
						} else {
							if(list.findNode(prename) == null) {
								System.out.println("Activity Not Found");
								System.out.println("Please enter one that is in list");
							} else {
								Node pre = list.findNode(prename);
								add.addPredecessor(pre);
							}
						}
					}
					
					list.addNode(add);
					
					list.setNodes(list.topologicalSort());
					list.fillAllInfo();
					break;
					
				case "2": // remove node
					
					boolean ask = true;
					do {
						// ask the name of node want to remove
						System.out.println("Please the name of activity that you want to remove: ");
						String removeName = reader.nextLine();
						
						// if not in list, re-enter
						if(list.findNode(removeName) == null) {
							System.out.println("Activity Not Found");
							System.out.println("Please enter one that is in list");
						} 
						// if found, then remove it from list
						else {
							
							Node remove = list.findNode(removeName);
							list.removeNode(remove);
							
							list.setNodes(list.topologicalSort());
							list.fillAllInfo();
							
							ask = false;
						}
					} while(ask);
					
					break;
					
				case "3": // change node
					
					boolean ask2 = true;
					String newName;
					do {
						// ask for name of activity want to edit
						System.out.println("Please the name of activity that you want to edit: ");
						String removeName = reader.nextLine();
						if(list.findNode(removeName) == null) {
							System.out.println("Activity Not Found");
							System.out.println("Please enter one that is in list");
						} else {
							Node edit = list.findNode(removeName);
							
							// ask for new name
							do {
								System.out.print("Please enter the new name of your activity: ");
								newName = reader.nextLine();
								if(list.findNode(newName) != null) {
									System.out.println("The activity with the same name is already exist.");
									System.out.println("Try again.");
								}
							} while(list.findNode(newName) != null);
							
							//System.out.println("Please enter the new name of your activity: ");
							//edit.setId(reader.nextLine());
							edit.setId(newName);
							
							// ask for new duration
							int newDuration = 0;
							boolean timeInput = true;
							do {
								try {
									System.out.print("New duration of the activity? ");
									newDuration = Integer.parseInt(reader.nextLine());
									timeInput = false;
								} catch(NumberFormatException e) {
									timeInput = true;
								}
								
								if(newDuration <= 0) {
									timeInput = true;
									System.out.println("Please enter a valid number(>0)");
								}
							} while(timeInput);
							
							edit.setDuration(newDuration);
							
							// ask to add dependency
							while(true) {
								System.out.println("\nAdd dependency\n");
								System.out.println("Please enter the name of activity that must");
								System.out.println("be finished before this one(One at a time) or");
								System.out.println("enter EXIT to end inputing dependencies");
								String prename = reader.nextLine();
								
								if(prename.equals("EXIT")) {
									break;
								} else {
									if(list.findNode(prename) == null) {
										System.out.println("Activity Not Found");
										System.out.println("Please enter one that is in list");
									} else {
										Node pre = list.findNode(prename);
										edit.addPredecessor(pre);
									}
								}
							}
							
							// ask to delete dependency
							while(true) {
								System.out.println("\nDelete dependency\n");
								System.out.println("Please enter the name of activity that you");
								System.out.println("want to delete from the precedessor list");
								System.out.println("enter EXIT to end");
								String prename = reader.nextLine();
								
								if(prename.equals("EXIT")) {
									break;
								} else {
									Node pre = list.findNode(prename);
									if(list.findNode(prename) == null) {
										System.out.println("Activity Not Found");
										System.out.println("Please enter one that is in list");
									} else if (!edit.getPredecessors().contains(pre)) {
										System.out.println("The activity you enter is not in the precedessor list");
										System.out.println("Nothing to remove");
									}
									else {
										edit.removePredecessor(pre);
									}
								}
							}
							
							list.setNodes(list.topologicalSort());
							list.fillAllInfo();
							
							ask2 = false;
						}
					} while(ask2);
					
					break;
				
				case "4": // Print All nodes
					String format = "%-20s%-20s%-20s%-20s%-20s%-20s%s%n";

					
					System.out.format(format, "Node", "Duration", "EarliestStartTime", "EarliestFinishTime",
							"LatestStartTime", "LastestFinishTime", "SlackTime");
					System.out.println("--------------------------------------------------------------------"
							+ "-----------------------------------------------------------------------");
					for(int i = 0; i < list.getSize(); i ++) {
						Node temp = list.getNodes().get(i);
						System.out.format(format, temp.getId(), temp.getDuration(), temp.getEarliestStartTime(),
								temp.getEarliestFinishTime(), temp.getLatestStartTime(), temp.getLatestFinishTime(),
								temp.getSlackTime());
					}
					System.out.println("---------------------------------------------------------------------"
							+ "------------------------------------------------------------------------");
					//System.out.format(format, "Total", "num");
					break;
				
				case "5": // Critical Path
					
					System.out.println(list.criticalPath());
					break;
					
				case "6": // topological order
					ArrayList<Node> temp = list.topologicalSort();
					System.out.print("\nThe topological order is: ");
					for(Node node : temp) {
						System.out.print(node.getId() + " ");
					}
					System.out.println("\n");
					break;
					
				case "7": // Clear Screen
					for(int i = 0; i < 100; i++)
						System.out.println("\n");

					break;
				
				case "8": // Exit
					System.out.println("Goodbye!");
					reader.close();
					System.exit(0);
					
					break;
					
				default: // Bad choice
					System.out.println
					(
						"\n" +
						"*********************\n" +
						"* Invalid selection *\n" +
						"*********************\n"
					);

					break;
			}
		}
	}
}

