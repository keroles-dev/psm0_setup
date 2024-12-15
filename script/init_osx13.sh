xhost +

docker run --name osx13 -it \
    -e RAM=12 \
    -e CORES=4 \
    --gpus all \
    --device /dev/nvidia0 \
    --device /dev/nvidia-uvm \
    --device /dev/nvidia-uvm-tools \
    --device /dev/nvidiactl \
    --device /dev/kvm \
    -p 50922:10022 \
    -v "/mnt/docker/mac_osx13_hdd.img:/image" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0}" \
    -e WIDTH=1280 \
    -e HEIGHT=768 \
    -e MASTER_PLIST_URL=https://raw.githubusercontent.com/sickcodes/Docker-OSX/master/custom/config-nopicker-custom.plist \
    sickcodes/docker-osx:naked
