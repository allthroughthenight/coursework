import java.util.ArrayList;
import java.util.Scanner;

public class DriverMain {

  /**
   * Main driver.
   */
  public static void main(String[] args) {

    System.out.println("Event Calendar Creator v 1.0");

    /* Events Array List */
    ArrayList<Event> eventsCalendar = new ArrayList<Event>();

    /* Temp event holder */
    Event tempEvent = new Event();

    /* Null event */
    Event nullEvent = new Event();

    /* Main Menu */
    String choice = "";
    Scanner menuIn = new Scanner(System.in);
    boolean run = true;

    do {

      System.out.println("+------------------------+");
      System.out.println("|      -Main Menu-       |");
      System.out.println("|  [1] Make New Event    |");
      System.out.println("|  [2] Print Calendar    |");
      System.out.println("|  [3] Clear Screen      |");
      System.out.println("|  [4] Exit              |");
      System.out.println("+------------------------+");
      System.out.print("\nEnter your selection: ");

      choice = menuIn.nextLine();
      System.out.println();

      switch (choice) {
        /* New event */
        case "1":
          System.out.println("-New Event-\n");
          tempEvent = tempEvent.createEvent();
          eventsCalendar.add(tempEvent);

          Calendar.sortEvents(eventsCalendar);

          tempEvent = nullEvent;

          System.out.println("\n-Event added-\n");
          break;
        /* Print calendar */
        case "2":
          Calendar.sortEvents(eventsCalendar);

          System.out.println("-Calendar Start-\n");
          Calendar.printCalendar(eventsCalendar);
          System.out.println("-Calendar End-\n");
          break;
        /* Clear screen */
        case "3":
          Calendar.clearScreen();
          break;
        /* Exit program */
        case "4":
          System.out.println("Exiting Event Calendar Creator...");
          run = false;
          System.exit(1);
          break;
        /* Invalid entry */
        default:
          System.out.println("-Invalid selection-\n");
          break;
      }
    } while (run);
    menuIn.close();
  }
}
