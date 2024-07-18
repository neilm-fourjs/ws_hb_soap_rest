
GLOBALS

# VARIABLE : WS_HB_Request
	DEFINE HBRequest RECORD ATTRIBUTE(XMLSequence,XMLName="HBRequest",XMLNamespace="https://generodemos/g/ws/r/HelloWorld")
		name STRING ATTRIBUTE(XMLName="name")
	END RECORD

#-------------------------------------------------------------------------------

# VARIABLE : WS_Response
	DEFINE HBResponse RECORD ATTRIBUTE(XMLSequence,XMLName="HBResponse",XMLNamespace="https://generodemos/g/ws/r/HelloWorld")
		reply STRING ATTRIBUTE(XMLName="status")
	END RECORD

#-------------------------------------------------------------------------------

END GLOBALS