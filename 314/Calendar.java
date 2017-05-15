import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Calendar implements Comparator<Event> {

  /**
   * Method to print an Array List of Events.
   *
   * @param event
   *          Array List of Events to be printed
   *
   */
  public static void printCalendar(ArrayList<Event> event) {
    int length = event.size();

    for (int i = 0; i < length; i++) {
      System.out.println(event.get(i).getEvent() + "\n");
    }
  }

  /**
   * Give header string for beginning of .ics calendar file.
   *
   * @return Beginning of calendar header string
   */
  public String printHeader() {
    return "BEGIN:VCALENDAR";
  }

  /**
   * Give footer string for end of .ics calendar file.
   *
   * @return End of calendar footer string
   */
  public String printFooter() {
    return "END:VCALENDAR";
  }

  /**
   * Prints 30 new line characters to decluter screen.
   */
  public static void clearScreen() {
    for (int i = 30; i > 0; i--) {
      System.out.println();
    }
  }

  /**
   * Sorts an Array List of Events based on start time.
   *
   * @param calendar
   *          Array List to be sorted
   */
  public static void sortEvents(ArrayList<Event> calendar) {
    Calendar ical = new Calendar();

    if (calendar.size() > 1) {
      Collections.sort(calendar, ical);
    }
  }

  /**
   * Override of Collections comapreTo method to be used by sortEvents.
   *
   * @param o1
   *        Event 1 to compare
   *
   * @param o2
   *        Event 2 to compare
   */
  public int compare(Event o1, Event o2) {
    String start1 = (o1.getDateTimeS());
    String start2 = (o2.getDateTimeS());
    if (start1.compareTo(start2) <= 1) {
      return -1;
    } else {
      return 1;
    }
  }
}
