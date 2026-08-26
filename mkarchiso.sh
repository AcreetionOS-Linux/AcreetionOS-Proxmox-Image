mkarchiso -L AcreetionOS_Server -v -o ../ISO . -C ./pacman.conf export PACMAN_OPTS="--overwrite '*'" --j$nproc
