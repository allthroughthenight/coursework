PROGRAM=Jsh
JAVA=java
JAVAC=javac

default: $(PROGRAM) run

run: $(PROGRAM)
	$(JAVA) $(PROGRAM)

$(PROGRAM): $(PROGRAM).java
	$(JAVAC) $(PROGRAM).java

clean:
	rm *.class
