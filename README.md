This repo is a docker wrapper around NatCap's InVEST:
https://github.com/natcap/invest

Currently the focus is on running the NDR model but it could easily be
adapted to run any of the other models.

## Pulling the image

```bash
docker pull jsta/natcap-invest-docker:latest
```

## Running the image

The image is built and deployed on DockerHub so you *don't* need to clone this
repo to run it. You only need to clone if you're going to do some development.

The image contains all the data it needs to run the NDR model, we just
want to mount a volume so we can get the results on the host.

```bash
mkdir /tmp/output
# it takes less than 2 minutes to run usually
docker run \
 --rm \
 -it \
 -v /tmp/output:/workspace \
 jsta/natcap-invest-docker:latest

sudo chown -R `id -u` /tmp/output
# now browse to /tmp/output to see the output files
```

## Changelog

### 0.0.1

 - cloned from https://github.com/ternandsparrow/natcap-invest-docker

 - updated to use the NDR model
