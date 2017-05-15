import java.util.Scanner;

public class Event {
  private String description;
  private String dateTimeS;
  private String dateTimeE;
  private String location;
  private String summary;
  private String classType;

  /**
   * Event constructor.
   */
  public Event() {
    this.summary = "";
    this.dateTimeS = "";
    this.dateTimeE = "";
    this.location = "";
    this.description = "";
    this.classType = "";
  }

  /*****************
   * Setter methods.
   ****************/

  /**
   * Method to create new event.
   *
   * @return New event that was created
   */
  @SuppressWarnings("resource")
  public Event createEvent() {
    Event event = new Event();
    Scanner sc = new Scanner(System.in);
    String input = "";

    System.out.print("Enter the event title: ");
    input = sc.nextLine();
    event.setSummary(input);
    input = "";

    System.out.print("Enter the event start date (YYYYMMDD): ");
    input += sc.nextLine() + "T";
    System.out.print("Enter the event start time (24 hour, HHMM): ");
    input += sc.nextLine() + "00";
    event.setDateTimeStart(input);
    input = "";

    System.out.print("Enter the event end date (YYYYMMDD): ");
    input += sc.nextLine() + "T";
    System.out.print("Enter the event end time (24 hour, HHMM): ");
    input += sc.nextLine() + "00";
    event.setDateTimeEnd(input);
    input = "";

    System.out.print("Enter the event location: ");
    input = sc.nextLine();
    event.setLocation(input);
    input = "";

    System.out.print("Enter the event description: ");
    input = sc.nextLine();
    event.setDescription(input);
    input = "";

    event.setClassType("PUBLIC");

    return event;
  }

  /**
   * Sets the summary of the Event.
   *
   * @param summaryL
   *          The description of the event to be set
   */
  public void setSummary(String summaryL) {
    this.summary = summaryL;
  }

  /**
   * Sets the starting date and time of the Event.
   *
   * @param input
   *          The date and time to be set
   */
  public void setDateTimeStart(String input) {
    this.dateTimeS = input;
  }

  /**
   * Sets the ending date and time of the Even.
   *
   * @param dateTimeEnL
   *          The date and time to be set
   */
  public void setDateTimeEnd(String dateTimeEnL) {
    this.dateTimeE = dateTimeEnL;
  }

  /**
   * Sets the location of the Event.
   *
   * @param locationL
   *          The location to be set
   */
  public void setLocation(String locationL) {
    this.location = locationL;
  }

  /**
   * Sets the descriptions of the Even.
   *
   * @param descriptionL
   *          The description to be set
   */
  public void setDescription(String descriptionL) {
    this.description = descriptionL;
  }

  /**
   * Sets the class type of the Event.
   *
   * @param classTypeL
   *          The class type to be set
   */
  public void setClassType(String classTypeL) {
    this.classType = classTypeL;
  }

  /*****************
   * Getter methods.
   ****************/

  /**
   * Gets Event object's fields and makes a formatting string to print to file.
   *
   * @return Formated string of Event fields.
   */
  public String getEvent() {
    String event = "";

    event += "SUMMARY:" + this.summary + "\n";
    event += "DTSTART:" + this.dateTimeS + "\n";
    event += "DTEND:" + this.dateTimeE + "\n";
    event += "DESCRIPTION:" + this.description + "\n";
    event += "LOCATION:" + this.location + "\n";
    event += "CLASS:" + this.classType;

    return event;
  }

  /**
   * Return the start time DTG of the event.
   *
   * @return String of the Event start time
   */
  public String getDateTimeS() {
    return this.dateTimeS;
  }

  /**
   * Returns the end time DTG of the Event.
   *
   * @return String of the Event end time
   */
  public String getDateTimeE() {
    return this.dateTimeE;
  }
}
