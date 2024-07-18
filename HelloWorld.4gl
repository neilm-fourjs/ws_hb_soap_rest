IMPORT FGL log

&include "HelloWorld.inc"

FUNCTION HelloWorld(l_name STRING ATTRIBUTES(WSParam)) ATTRIBUTES(WSGet, WSPath = "/HelloWorld/{l_name}", WSDescription = "HelloWorld") RETURNS STRING
	CALL log.log(SFMT("Hello World '%1'", l_name))
	RETURN SFMT("HelloWorld: Hello World '%1'", l_name)
END FUNCTION

--------------------------------------------------------------------------------
FUNCTION HelloWorldS()
	CALL log.log(SFMT("HelloWorldS: Hello World '%1'", HBRequest.name))
	LET HBResponse.reply = HelloWorld( HBRequest.name )
END FUNCTION
--------------------------------------------------------------------------------
