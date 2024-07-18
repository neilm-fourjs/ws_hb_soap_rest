IMPORT FGL log
IMPORT FGL WSlibSoap
IMPORT FGL DBping
IMPORT FGL HelloWorld
IMPORT com

&include "HelloWorld.inc"
&include "DBping.inc"

MAIN
	DEFINE l_stat INT

	DISPLAY DBping.doDBping()

	CALL log.log("Create Soap WS...")
	CALL WSlibSoap.createWS_service("HelloWorld", "https://generodemos/g/ws/r/HelloWorld") RETURNING l_stat
	IF l_stat <> 0 THEN
		CALL log.log(SFMT("Error creating service %1 - %2", l_stat, err_get(l_stat)))
		EXIT PROGRAM
	END IF

	CALL WSlibSoap.run()
END MAIN
--------------------------------------------------------------------------------
-- Add the soap operation - called from WSlib.CreateWS_Server()
FUNCTION addFunctions(l_serv com.WebService)
	DEFINE l_op com.WebOperation

	CALL log.log("Publish HelloWorld ...")
	LET l_op = com.WebOperation.CreateDOCStyle("HelloWorld.HelloWorldS", "HelloWorld", HBRequest, HBResponse)
	CALL l_serv.publishOperation(l_op, "")

	CALL log.log("Publish DBping ...")
	LET l_op = com.WebOperation.CreateDOCStyle("DBping.DBpingS", "DBping", NULL, DBpingResponse)
	CALL l_serv.publishOperation(l_op, "")

END FUNCTION

