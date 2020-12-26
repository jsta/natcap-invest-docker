#!/usr/bin/env sh

# check http://releases.naturalcapitalproject.org/?prefix=invest/3.9.0/data/ for
# options.
# NOTE: this data is only an example used for the tester UI, it is NOT used
#       for running in production when the user supplies data.
investDataUrl='https://storage.googleapis.com/releases.naturalcapitalproject.org/invest/3.9.0/data/NDR.zip'

pushd /data
ndr_zip=NDR.zip
wget -O $ndr_zip "$investDataUrl"
unzip $ndr_zip
rm $ndr_zip
mv NDR NDR-sample
popd

# we can remove the dev dependencies after building the python bindings
apt-get purge --assume-yes \
  libgdal-dev
apt-get autoremove --assume-yes
apt-get --assume-yes clean
rm -rf \
  /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*
rm setup.sh
