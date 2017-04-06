# ICS 314 Software Engineering I:
Problem analysis and design, team-oriented development, quality assurance, configuration management, and project planning.

A program that creates an Array List of Events that can be exported as an [.ics](https://en.wikipedia.org/wiki/ICalendar "iCalendar") file. Which can then be imported by various calendar systems, specifically Google calendar.
All formatting is [check-style](https://en.wikipedia.org/wiki/Checkstyle "Chekcstyle") compliant using the Eclipse ([Mars](https://www.eclipse.org/mars/ "Mars")) IDE and Check-Style [module](http://checkstyle.sourceforge.net/config.html "module").

#### Program Class Structure
The Event class contatins a construtor for user input, along with other getters and setters. The Calendar class has the sort method which implements the java.util.Comparator to overload the compare method. This is done so that Collection.sort can be used on an Event object based on it's start time.
