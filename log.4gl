FUNCTION log(l_mess STRING)
	DISPLAY SFMT("%1 %2: %3", TIME, base.Application.getProgramName(), NVL(l_mess, "NULL"))
END FUNCTION
