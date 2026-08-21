import java.util.ArrayList;
import java.util.Random;

public class textGenTest {

	public static void main(String[] args) {
		ArrayList<String> phrases = new ArrayList<String>();
		Random rand = new Random();
		
		boolean isIdling = false;
		boolean gameRunning = false;
		
		int tFSwitch2 = rand.nextInt(2);
		
		//simulates the game running
		if (tFSwitch2 == 1){
			gameRunning = true;
		}else {
			gameRunning = false;
		}
		
		while(gameRunning){
			
			int tFSwitch = rand.nextInt(2);
			
			if (tFSwitch == 1){
				isIdling = true;
			}else {
				isIdling = false;
			}
		}
		
		/*phrases.add("I love you, Sy!");
		phrases.add("Hello, my beloved!");
		phrases.add("My amplifier is my heart, and you have my heart.");
		phrases.add("Thank you for existing.");

		int index = rand.nextInt(phrases.size());
		
		String value = phrases.get(index);
		
		System.out.println(value);*/
	}

}
