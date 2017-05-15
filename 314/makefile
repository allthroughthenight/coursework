PROGRAM=DriverMain
JAVAC=javac
JAVA=java

default: DriverMain.class run

run: DriverMain.class
	java DriverMain

DriverMain.class: DriverMain.java
	javac DriverMain.java

Calendar.class: Calendar.java
	javac Calendar.java

Event.class: Event.java
	javac Event.java

clean:
	/bin/rm *.class

