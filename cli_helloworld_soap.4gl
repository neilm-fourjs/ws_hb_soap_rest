
IMPORT FGL cli_helloworld_ws_soap

MAIN
	DEFINE l_reply STRING
	DEFINE l_stat INT
	DEFINE l_url STRING
	LET l_url = base.Application.getArgument(1)
	IF l_url IS NOT NULL THEN
		LET cli_helloworld_ws_soap.HelloWorld_HelloWorldPortTypeEndpoint.Address.Uri = l_url
	END IF
	CALL HelloWorld("Fred") RETURNING l_stat, l_reply
	DISPLAY SFMT("Status: %1 Reply: %2", l_stat, l_reply)
	CALL DBping() RETURNING l_stat, l_reply
	DISPLAY SFMT("Status: %1 Reply: %2", l_stat, l_reply)
END MAIN
