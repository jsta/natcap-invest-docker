#!/usr/bin/env sh
set -euo pipefail

# can be any git commit-ish (tags, commits, branches)
investCodeVersion=3.9.0

# check http://releases.naturalcapitalproject.org/?prefix=invest/3.9.0/data/ for
# options.
# NOTE: this data is only an example used for the tester UI, it is NOT used
#       for running in production when the user supplies data.
investDataUrl='https://storage.googleapis.com/releases.naturalcapitalproject.org/invest/3.9.0/data/NDR.zip'


# stop tzdata from prompting for a TZ, thanks https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive#comment91752692_44333806
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get dist-upgrade --assume-yes
apt-get install --assume-yes --no-install-recommends \
  libgdal20 \
  libgdal-dev \
  libspatialindex-c5


pushd /data
ndr_zip=NDR.zip
wget -O $ndr_zip "$investDataUrl"
unzip $ndr_zip
rm $ndr_zip
mv NDR NDR-sample
popd

pip3 install numpy Cython ptvsd
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip3 install natcap.invest==$investCodeVersion
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
