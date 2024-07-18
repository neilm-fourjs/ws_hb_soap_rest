
GLOBALS
# VARIABLE : DBpingResponse
  DEFINE DBpingResponse RECORD ATTRIBUTE(XMLSequence,XMLName="DBpingResponse",XMLNamespace="https://generodemos/g/ws/r/HelloWorld")
		status STRING ATTRIBUTE(XMLName="status")
	END RECORD

END GLOBALS