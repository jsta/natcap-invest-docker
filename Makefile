interactive:
	docker run -it --entrypoint /bin/bash jsta/natcap-invest-docker:latest

test:
	docker run --rm -v $(pwd)/NDR-sample:/home jsta/natcap-invest-docker:latest python --version
	
test2:
	docker run \
	--rm \
	-td \
	-td \
	-v ~/Documents/Science/Models/natcap-invest-docker/NDR-sample:/data/NDR-sample \
	-v ~/Documents/Science/Models/natcap-invest-docker/run-ndr.py:/run-ndr.py \
	-v /tmp/output:/workspace \
	jsta/natcap-invest-docker:latest conda run -n r-invest python run-ndr.py


