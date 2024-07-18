IMPORT FGL log
IMPORT FGL WSlibRest
IMPORT FGL DBping
IMPORT FGL HelloWorld
IMPORT com

&include "HelloWorld.inc"
&include "DBping.inc"

MAIN

	CALL log.log("Create Rest WS...")

	IF NOT WSlibRest.init("HelloWorld", "HelloWorld") THEN
		EXIT PROGRAM
	END IF

	CALL WSlibRest.start()

	CALL log.log("Finished")

END MAIN
