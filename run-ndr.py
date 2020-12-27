# coding=UTF-8
# hardcoded demo runner script for the ndr model using the sample data
# from natcap.

import time
import sys
import os
import logging
from natcap.invest.ndr import ndr

logging.basicConfig(stream=sys.stdout, level=logging.WARN)

def now():
    return int(time.time() * 1000.0)
start_ms = now()
print('[INFO] starting up')

data_dir = "data/NDR-sample/"
args = {
    "workspace_dir": "workspace", 
    "dem_path": data_dir + "DEM_gura.tif", 
    "lulc_path": data_dir + "land_use_gura.tif", 
    "runoff_proxy_path": data_dir + "precipitation_gura.tif",
    "watersheds_path": data_dir + "watershed_gura.shp",
    "biophysical_table_path": data_dir + "biophysical_table_gura.csv",    
    "calc_p": True,
    "calc_n": False,
    "threshold_flow_accumulation": 1000,
    "k_param": 2,
    "subsurface_eff_p": 0, # not used for p model
    "subsurface_critical_length_p": 0 # not used for p model
     }

if __name__ == '__main__':
    ptvsd_enable = os.getenv('PTVSD_ENABLE', default=0)
    if ptvsd_enable == '1':
        print('[INFO] Remote debugging, via ptvsd, is enabled')
        # somewhat following https://vinta.ws/code/remotely-debug-a-python-app-inside-a-docker-container-in-visual-studio-code.html
        import ptvsd
        ptvsd_port = int(os.getenv('PTVSD_PORT', default=3000))
        ptvsd.enable_attach(address=('0.0.0.0', ptvsd_port))
        print('[INFO] ptvsd is started (port=%d), waiting for you to attach...' % ptvsd_port)
        ptvsd.wait_for_attach()
        print('[INFO] debugger is attached, breakpointing so you can set your own breakpoints')
        breakpoint()
    print('[INFO] starting execution of the ndr model')
    ndr.execute(args)
    elapsed_time = now() - start_ms
    print('[INFO] finished execution of the ndr model, elapsed time {}ms'.format(elapsed_time))
