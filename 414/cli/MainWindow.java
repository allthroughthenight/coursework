import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class MainWindow extends JPanel implements ActionListener {

	private static final long serialVersionUID = -4427935707857800584L;
	private JLabel optionsHeader = new JLabel("Options");
	private JLabel taskHeader = new JLabel("Currect Tasks");
	private JLabel output = new JLabel();
	private JButton saveButton = new JButton("Save Tasks");
	private JButton loadButton = new JButton("Load Tasks");
	private JButton removeButton = new JButton("Remove Task");
	private JButton addButton = new JButton("Add Task");
	private JButton changeButton = new JButton("Change Task");
	private JTextArea paths = new JTextArea(15, 20);
	private JScrollPane scroll = new JScrollPane(paths);
	private GridBagConstraints bag = new GridBagConstraints();
	private JFileChooser fc = new JFileChooser();

	private JFrame frame = new JFrame("To Do List");

	/**
	 * Adds in all the parts needed for the GUI
	 */
	public MainWindow() {
		this.setLayout(new GridBagLayout());

		this.drawTextArea();
		this.drawPanel();
		this.drawButton();

		this.setPreferredSize(new Dimension(500, 400));
	}

	private void drawPanel() {
		bag.gridx = 2;
		bag.gridy = 0;
		bag.gridheight = 1;
		this.add(optionsHeader, bag);

		bag.gridx = 1;
		bag.gridheight = 1;
		this.add(taskHeader, bag);

		bag.gridy = 3;
		bag.gridx = 2;
		bag.gridheight = 2;
		this.add(output, bag);
	}

	private void drawButton() {
		int x = 2;
		int y = 5;

		addButton.setActionCommand("add");
		addButton.addActionListener(this);
		bag.fill = GridBagConstraints.HORIZONTAL;
		bag.gridx = x;
		bag.gridy = y++;
		bag.gridheight = 1;
		this.add(addButton, bag);

		removeButton.setActionCommand("remove");
		removeButton.addActionListener(this);
		bag.fill = GridBagConstraints.HORIZONTAL;
		bag.gridx = x;
		bag.gridy = y++;
		bag.gridheight = 1;
		this.add(removeButton, bag);

		changeButton.setActionCommand("change");
		changeButton.addActionListener(this);
		bag.fill = GridBagConstraints.HORIZONTAL;
		bag.gridx = x;
		bag.gridy = y++;
		bag.gridheight = 1;
		this.add(changeButton, bag);

		saveButton.setActionCommand("save");
		saveButton.addActionListener(this);
		bag.fill = GridBagConstraints.HORIZONTAL;
		bag.gridx = x;
		bag.gridy = y++;
		bag.gridheight = 1;
		this.add(saveButton, bag);

		loadButton.setActionCommand("load");
		loadButton.addActionListener(this);
		bag.fill = GridBagConstraints.HORIZONTAL;
		bag.gridx = x;
		bag.gridy = y++;
		bag.gridheight = 1;
		this.add(loadButton, bag);
	}

	private void drawTextArea() {
		bag.gridx = 1;
		bag.gridy = 1;
		bag.gridheight = 10;
		paths.setLineWrap(true);
		paths.setEditable(false);
		this.updateText();
		this.add(scroll, bag);
	}

	public void updateText() {
		String text = this.listNode() + "\n\n" + this.listSort();
		paths.setText(text);
	}

	public String listNode() {
		return Main.list.criticalPath();
	}

	public String listSort() {
		StringBuilder list = new StringBuilder("All Tasks (shortest to longest):\n");
		for (Node node : Main.list.topologicalSort())
			list.append(node.getId() + " -> ");

		return list.substring(0, list.length() - 4);

	}

	/**
	 * Checks for user input
	 */
	@Override
	public void actionPerformed(ActionEvent event) {
		String input = "";

		switch (event.getActionCommand()) {
			case "save":
				this.io(1);
				break;
			case "load":
				this.io(0);
				break;
			case "remove":
				input = JOptionPane.showInputDialog(this, "Name of task to remove");
				Node node = Main.list.findNode(input);
				if (node != null)
					Main.list.removeNode(node);
				break;
			case "add":
				this.createTaskPopup("Add Task", 0);
				break;
			case "change":
				input = JOptionPane.showInputDialog(this, "Name of task to edit");
				System.out.println(input);
				this.createTaskPopup("Edit Task", 1, input);
				break;
		}

		this.updateText();

	}

	// 0 to read, 1 to write
	private void io(int flag) {
		fc.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int value = fc.showDialog(this, "OK");

		if (value == JFileChooser.APPROVE_OPTION) {
			if (flag == 0) {
				ObjectInputStream reader;
				try {
					reader = new ObjectInputStream(new FileInputStream(fc.getSelectedFile()));
					NodeList parsedNodes = (NodeList) reader.readObject();

					reader.close();
					
					Main.list = parsedNodes;
					
					this.updateText();
				} catch (IOException | ClassNotFoundException e) {
					e.printStackTrace();
				}

			} else {
				try {
					ObjectOutputStream writer = new ObjectOutputStream(new FileOutputStream(new File(fc.getSelectedFile().getAbsolutePath())));
					writer.writeObject(Main.list);
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void createTaskPopup(String title, int flag) {
		this.createTaskPopup(title, flag, "");
	}

	// 0 to add, 1 to edit
	private void createTaskPopup(String title, int flag, String taskTarget) {
		JDialog dialog = new JDialog(frame, title);
		TaskWindow panel = new TaskWindow(dialog);

		if (flag == 1)
			panel.setEdit(taskTarget);

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		dialog.setPreferredSize(new Dimension(500, 200));
		dialog.setModal(true);
		dialog.setContentPane(panel);
		dialog.pack();
		dialog.setLocationRelativeTo(this);
		dialog.setVisible(true);
	}

	/**
	 * Starts up the GUI
	 */
	public void drawGUI() {

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setResizable(false);
		frame.add(this);

		frame.pack();
		frame.setVisible(true);
	}

}
