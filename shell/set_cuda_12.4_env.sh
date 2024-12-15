#!bin/bash
function set_cu124_env(){
	export PATH=$PATH:/usr/local/cuda-12.4/bin
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-12.4/lib64
}
set_cu124_env
