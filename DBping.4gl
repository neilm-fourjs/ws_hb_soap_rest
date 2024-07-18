IMPORT FGL log

&include "DBping.inc"

--------------------------------------------------------------------------------
FUNCTION DBping()
	LET DBpingResponse.status = doDBping()
	IF DBpingResponse.status != "OK" THEN
		CALL setError(-1, "ERROR", "")
	END IF
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION doDBping() RETURNS STRING
	DEFINE l_db STRING
	LET l_db = fgl_getenv("DATABASE")
	TRY
		DATABASE l_db
		CALL log.log("doDBping: Okay")
		RETURN "OK"
	CATCH
		CALL log.log(SFMT("doDBping to '%1' failed: %2 %3", l_db, sqlca.sqlcode, sqlca.sqlerrm))
		RETURN SFMT("Failed to connect to '%1' %2", l_db, sqlca.sqlcode)
	END TRY
END FUNCTION
