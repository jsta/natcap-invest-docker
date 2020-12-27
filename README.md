This repo is a docker wrapper around NatCap's InVEST:
https://github.com/natcap/invest

Currently the focus is on running the NDR model but it could easily be
adapted to run any of the other models.

## Running the image

The image is built and deployed on DockerHub so you *don't* need to clone this
repo to run it. You only need to clone if you're going to do some development.

We use a version scheme for GitHub and DockerHub tags: `{our version}_{InVEST
version}`, for example `1.0.0_3.4.2` means 1.0.0 is our version and we're using
version 3.4.2 of InVEST. Check DockerHub for the latest tag.

The image contains all the data it needs to run the NDR model, we just
want to mount a volume so we can get the results on the host.
```bash
mkdir /tmp/output
# it takes less than 2 minutes to run usually
docker run \
 --rm \
 -it \
 -v /tmp/output:/workspace \
 jsta/natcap-invest-docker:0.1.1_3.9.0

sudo chown -R `id -u` /tmp/output
# now browse to /tmp/output to see the output files
```
We use the `-it` flag so we get log output in a timely manner. You can leave it
out but the log messages don't seem to be flushed until the end of the run.

## Building the image locally

The build is fully automated and will download everything it needs.
```bash
tagVersion=0.1.1_3.9.0 # TODO change this to suit
cd natcap-invest-docker/
docker build -t jsta/natcap-invest-docker:$tagVersion
# see above for how to run it
```

## Remote debugging the container
We can use [ptvsd](https://github.com/microsoft/ptvsd) to let us connect a
remote debugger (like vscode) to the Docker container. You can do it like this:

  1. clone this repo
  1. make sure your local code exactly matches the code inside the container
     (use `git checkout <some tag>` for an easy way to sync with a tagged docker
     container). It doesn't seem to matter if you have the dependencies
     installed on your host, the sources must be pulled from the docker
     container.
  1. open your debugger, let's assume vscode because we already have the
     `launch.json` configured in this repo. Make sure you have this
     repo/project/directory open in vscode
  1. launch the docker container, as you would above, but with these additional
     parameters `-e PTVSD_ENABLE=1 -p 3000:3000`. This will set the env var to
     enable remote debugging and open a port to connect to the debug server
  1. the container will enable remote debugging and wait for your debugger to
     attach. Once attached, we trigger a breakpoint so you can set your own
     breakpoints before execution continues

## Changelog

### 0.1.1_3.9.0

 - cloned from https://github.com/ternandsparrow/natcap-invest-docker