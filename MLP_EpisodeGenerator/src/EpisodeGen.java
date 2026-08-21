import javax.swing.JFrame;

public class EpisodeGen {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JFrame frame = new JFrame("Episode Generator");
		EpisodeGenPanel panel = new EpisodeGenPanel();
		
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		frame.getContentPane().add(panel);
		
		frame.pack();
		frame.setVisible(true);	
		}

}
