all: Infix.eyp I2PIR.trg
	eyapp Infix.eyp
	treereg -m main I2PIR.trg

run: all input1.inf
	infix2pir.pl input1.inf

clean: 
	rm -f I2PIR.pm Infix.pm
