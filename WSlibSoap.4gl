IMPORT FGL log
IMPORT com

#
# Global HTTP server incoming variable type definition
#
TYPE tGlobalServerHttpInputVariableType RECORD
	verb STRING,                    # HTTP request VERB
	url  STRING,                    # HTTP request URL
	headers DYNAMIC ARRAY OF RECORD # HTTP Headers
		name  STRING,
		value STRING
	END RECORD
END RECORD

#
# Global HTTP server outgoing variable type definition
#
TYPE tGlobalServerHttpOutputVariableType RECORD
	code INTEGER,                   # HTTP status code
	desc STRING,                    # HTTP description
	headers DYNAMIC ARRAY OF RECORD # HTTP Headers
		name  STRING,
		value STRING
	END RECORD
END RECORD

PUBLIC DEFINE WS_HttpIn  tGlobalServerHttpInputVariableType
PUBLIC DEFINE WS_HttpOut tGlobalServerHttpOutputVariableType

FUNCTION run()
	DEFINE l_ret INT

	CALL com.WebServiceEngine.Start()
	CALL log.log("Server started")
	WHILE TRUE
		TRY
			DISCONNECT ALL
		END TRY
		LET l_ret = com.WebServiceEngine.ProcessServices(30)
		CASE l_ret
			WHEN 0
				CALL log.log("Success")
			WHEN -01
				CALL log.log("Time out reached")
			WHEN -02
				CALL log.log("Disconnected from application server")
				EXIT PROGRAM
			WHEN -03
				CALL log.log("Lost connection with the client")
			WHEN -04
				CALL log.log("Server has been interrupted with Ctrl-C")
			WHEN -05
				CALL log.log("Bad HTTP request")
			WHEN -06
				CALL log.log("Malformed SOAP envelope")
			WHEN -07
				CALL log.log("Malformed XML document")
			WHEN -08
				CALL log.log("HTTP error")
			WHEN -09
				CALL log.log("Unsupported operation")
			WHEN -10
				CALL log.log("Internal server error")
			WHEN -11
				CALL log.log("WSDL Generation failed")
			WHEN -12
				CALL log.log("WSDL Service not found")
			WHEN -13
				CALL log.log("Reserved")
			WHEN -14
				CALL log.log("Incoming request overflow")
			WHEN -15
				CALL log.log("Server was not started")
			WHEN -16
				CALL log.log("Request still in progress")
			WHEN -17
				CALL log.log("Stax response error")
				CALL log.log(SFMT("ERROR : %1 %2", STATUS, SQLCA.SQLERRM))
			OTHERWISE
				CALL log.log(SFMT("Unrecognized Status %1", l_ret))
				CALL log.log(SFMT("ERROR : %1 %2", STATUS, SQLCA.SQLERRM))
		END CASE
		IF int_flag <> 0 THEN
			LET int_flag = 0
			EXIT WHILE
		END IF
		CALL log.log("Request processed")
	END WHILE

END FUNCTION

FUNCTION createWS_service(l_srv STRING, l_url STRING) RETURNS INT
	DEFINE service   com.WebService
	DEFINE operation com.WebOperation

	TRY
		# Create Web Service
		LET service = com.WebService.CreateWebService(l_srv, l_url)
		CALL service.setFeature("Soap1.1", TRUE)

		# Handle HTTP register methods
		CALL service.registerInputHttpVariable(WS_HttpIn)
		CALL service.registerOutputHttpVariable(WS_HttpOut)

		#
		# Create Headers
		#
		--CALL service.createHeader( , )

		#
		# Operation: GetDebtorStatus
		#

		# Publish Operation : HelloWorld
		CALL addFunctions(service)

		#
		# Register Service
		#
		CALL com.WebServiceEngine.RegisterService(service)
		RETURN 0

	CATCH
		RETURN STATUS
	END TRY
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION setError(l_stat INT, l_err STRING, l_ns STRING)
	CALL com.WebServiceEngine.SetFaultCode(l_stat, l_ns)
	CALL com.WebServiceEngine.SetFaultString(l_err)
END FUNCTION
