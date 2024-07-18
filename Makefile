
export FGLAPPSERVER=8080
export DATABASE=njm_demo310

all:	cli_helloworld_ws_rest.4gl cli_helloworld_ws_soap.4gl
	gsmake ws_soap_and_rest_heartbeat.4pw

run_cli_rest:
	cd bin_cli500 && fglrun cli_helloworld_rest

run_cli_soap:
	cd bin_cli500 && fglrun cli_helloworld_soap

run_srv_rest:
	cd bin500 && fglrun HelloWorldRest

run_srv_soap:
	cd bin500 && fglrun HelloWorldSoap

clean:
	find . -name \*.42? -delete

HelloWorld.wsdl:
	wget -O $@ http://localhost:8080/?WSDL

cli_helloworld_ws_soap.4gl: HelloWorld.wsdl
	fglwsdl -o cli_helloworld_ws_soap $^

HelloWorld.json:
	wget -O $@ http://localhost:8080/HelloWorld?openapi.json

cli_helloworld_ws_rest.4gl: HelloWorld.json
	fglrestful -o cli_helloworld_ws_rest $^
