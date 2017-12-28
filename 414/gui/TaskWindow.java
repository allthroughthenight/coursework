package ics414fa17.gui;

import ics414fa17.CPM.Node;
import ics414fa17.main.Main;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.util.ArrayList;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class TaskWindow extends JPanel implements ActionListener {

	private static final long serialVersionUID = -6588157218218137276L;
	public JTextField name = new JTextField();
	private JLabel nameLabel = new JLabel("Name");
	public JTextField duration = new JTextField();
	private JLabel durationLabel = new JLabel("Duration");
	public JTextField dependencies = new JTextField();
	private JLabel dependenciesLabel = new JLabel("Dependencies");
	private JLabel inValid = new JLabel();
	private JButton confirm = new JButton("OK");
	private JDialog dialog;
	private String nodeTarget = "";
	private boolean edit = false;

	public TaskWindow(JDialog dialog) {
		this.dialog = dialog;

		this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		this.draw();
	}

	private void draw() {
		this.add(nameLabel);
		this.add(name);
		this.add(durationLabel);
		this.add(duration);
		this.add(dependenciesLabel);
		this.add(dependencies);
		this.add(inValid);

		confirm.setActionCommand("ok");
		confirm.addActionListener(this);
		this.add(confirm);
	}

	public void setEdit(String target) {
		this.edit = true;
		this.nodeTarget = target;

		if (edit) {
			Node node = Main.list.findNode(target);
			this.name.setText(target);
			this.duration.setText(Integer.toString(node.getDuration()));
			StringBuilder str = new StringBuilder();
			for (Node pre : node.getPredecessors())
				str.append(pre.getId() + ",");
			if (str.length() >= 1)
				this.dependencies.setText(str.substring(0, str.length() - 1));

		}
	}

	@Override
	public void actionPerformed(ActionEvent event) {
		switch (event.getActionCommand()) {
		case "ok":
			String nodeName = this.name.getText();
			String nodeDuration = this.duration.getText();
			int duration = 0;
			String[] dependNodes = this.dependencies.getText().split(",");
			ArrayList<String> inValid = new ArrayList<>();

			if (isFloat(nodeDuration))
				duration = Integer.parseInt(nodeDuration);
			else
				inValid.add(nodeDuration);

			Node newNode = new Node(nodeName, duration);

			if (dependNodes.length > 0) {
				for (String dep : dependNodes) {
					if (dep.isEmpty()) continue;
					Node pre = Main.list.findNode(dep.trim());
					if (pre != null)
						newNode.addPredecessor(pre);
					else
						inValid.add(dep);
				}
			}

			if (inValid.isEmpty()) {
				if (edit) Main.list.removeNode(Main.list.findNode(nodeTarget));
				Main.list.addNode(newNode);
				this.dialog.dispatchEvent(new WindowEvent(this.dialog,
						WindowEvent.WINDOW_CLOSING));
			} else {
				StringBuilder out = new StringBuilder("Invalid Input(s): ");
				for (String input : inValid)
					out.append(input + ", ");
				this.inValid.setText(out.substring(0, out.length() - 2));
			}

			break;
		}

	}

	// http://stackoverflow.com/questions/237159/whats-the-best-way-to-check-to-see-if-a-string-represents-an-integer-in-java
	public static boolean isFloat(String arg) {
		if (arg == null)
			return false;

		int length = arg.length();

		if (length == 0)
			return false;

		int x = 0;

		if (arg.charAt(0) == '-') {
			if (length == 1)
				return false;
			x = 1;
		}

		for (; x < length; x++) {
			char c = arg.charAt(x);
			if ((c <= '/' || c >= ':') && c != '.')
				return false;
		}

		return true;
	}

}
