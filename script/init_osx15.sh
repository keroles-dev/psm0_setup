xhost +

docker run --name osx15 -it \
    -e RAM=12 \
    -e CORES=4 \
    --device /dev/kvm \
    -p 50922:10022 \
    -v "/mnt/docker/mac_osx15_hdd.img:/image" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0}" \
    -e WIDTH=1280 \
    -e HEIGHT=768 \
    -e GENERATE_UNIQUE=true \
    -e MAC_ADDRESS="$(xxd -c1 -p -l 6 /dev/urandom | tr '\n' ':' | cut -c1-17)" \
    -e CPU='Haswell-noTSX' \
    -e CPUID_FLAGS='kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on' \
    -e MASTER_PLIST_URL='https://raw.githubusercontent.com/sickcodes/osx-serial-generator/master/config-custom-sonoma.plist' \
    -e SHORTNAME=sequoia \
    sickcodes/docker-osx:naked
