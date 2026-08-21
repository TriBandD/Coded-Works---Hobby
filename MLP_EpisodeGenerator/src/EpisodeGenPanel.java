import java.util.Random;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class EpisodeGenPanel extends JPanel 
{

	private JLabel seasonLabel;
	private JLabel episodeLabel;
	private JTextField seasonTextField;
	private JTextField episodeTextField;
	private JButton genButton;
	
	Random gen = new Random();
	
	public EpisodeGenPanel() 
	{
		seasonLabel = new JLabel ("Season number: ");
		episodeLabel = new JLabel ("Episode number: ");
		seasonTextField = new JTextField(20);
		episodeTextField = new JTextField(20);
		genButton = new JButton("Generate Episode");
		
		/*if I wanted a "keep/skip" button, or a generate new button. I believe I would have to use a loop.
		However, I think that the code for a gui like this is already a loop, so, idk*/
		
	add(genButton);
	add(seasonLabel);
	add(seasonTextField);
	add(episodeLabel);
	add(episodeTextField);
	
	genButton.addActionListener(new ButtonListener());
	
	setBackground(Color.GRAY);
	seasonLabel.setForeground(Color.BLACK);
	episodeLabel.setForeground(Color.BLACK);
	setPreferredSize(new Dimension(150, 300));
	seasonTextField.setText("Season here");
	episodeTextField.setText("Episode here");
	}//end of constructor
	
	private class ButtonListener implements ActionListener
	{
		
		public void actionPerformed (ActionEvent event) 
		{
			
			if(event.getSource() == genButton) {
				Random gen = new Random();

				int max1 = 9, min1 = 1; 
				int max2 = 26, min2 = 1;
				//int season = gen.nextInt(max1 - min1) + 1;
				int season = gen.nextInt(9)+1;
				int episode = gen.nextInt(26)+1;
				//int episode = gen.nextInt(max2 - min2) + 1;
				
				seasonTextField.setText(Integer.toString(season));
				episodeTextField.setText(Integer.toString(episode));
				;
				//System.out.println("Season #: " + );
				//System.out.println("Episode #: " + );
				
				}//end of getSource
			}//end of actionPerformed
		}//end of ButtonListener
	} //end of class

//The code needs to be able to pick a season number between 1 and 9
//It also needs to be able to pick an episode number between 1 and 