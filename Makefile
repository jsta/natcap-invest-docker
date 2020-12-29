interactive:
	docker run -it --entrypoint /bin/bash jsta/natcap-invest-docker:latest

test:
	docker run --rm -v $(pwd)/run-ndr.py:/run-ndr.py -v $(pwd)/NDR-sample/:/data/NDR-sample/ jsta/natcap-invest-docker:latest python /run-ndr.py

