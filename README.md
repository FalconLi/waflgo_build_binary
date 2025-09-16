# WAFLGo Build Binary Commands
It contains the commands to build the binaries for all the commits evaluated in the [WAFLGO](https://www.usenix.org/conference/usenixsecurity24/presentation/xiang-yi) paper.

The [Github repository](https://github.com/NESA-Lab/WAFLGo) of the paper only provides command to build the binary of libjpeg-issue-493. This directory will provide commands to build binaries of all the commits evaluated in the paper.

## Docker
The [Docker image](https://hub.docker.com/r/he1lonice/waflgo) provided by the authors have a serious bug inside. You cannot pull this image if you are using rootless Docker, which restricts the running of the program on remote servers.
A Dockerfile is provided to build an image with the bug solved
Use the following command in the directory where Dockerfile is present to build the image:
```commandline
docker build -t waflgo_image .
```
An image with the name waflgo_image is built.

## Commands for Commits Evaluated in Paper
### mujs-issue-65
Docker Container
```commandline
docker run -d --name waflgo-mujs-65 waflgo_image tail -f /dev/null
docker exec -it waflgo-mujs-65 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```commandline
mkdir /home/js
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/js/* /home/js/
```
Download Subject
```commandline
git clone https://codeberg.org/ccxvii/mujs.git /home/waflgo-mujs
cd /home/waflgo-mujs; git checkout 8c27b12
```
Build Binary
```commandline
export CC=/home/WAFLGo/afl-clang-fast
export CXX=/home/WAFLGo/afl-clang-fast++
export AFL_CC=gclang
export AFL_CXX=gclang++

make clean
make CFLAGS="-g --notI" CXXFLAGS="-g --notI"
unset AFL_CC AFL_CXX

cp build/release/mujs ./
get-bc mujs

mkdir fuzz
cd fuzz
cp ../mujs.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mujs.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mujs.ci.bc  -lstdc++  -o mujs.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-mujs -t 1000+ -m none -z exp -c 45m -q 1 -i /home/js -o /home/out -- /home/waflgo-mujs/fuzz/mujs.ci  @@
```

### mujs-issue-141
Docker Container
```commandline
docker run -d --name waflgo-mujs-141 waflgo_image tail -f /dev/null
docker exec -it waflgo-mujs-141 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```commandline
mkdir /home/js
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/js/* /home/js/
```
Download Subject
```commandline
git clone https://codeberg.org/ccxvii/mujs.git /home/waflgo-mujs
cd /home/waflgo-mujs; git checkout 832e069
```
Build Binary
```commandline
export CC=/home/WAFLGo/afl-clang-fast
export CXX=/home/WAFLGo/afl-clang-fast++
export AFL_CC=gclang
export AFL_CXX=gclang++

make clean
make CFLAGS="-g --notI" CXXFLAGS="-g --notI" HAVE_READLINE=no
unset AFL_CC AFL_CXX

cp build/release/mujs ./
get-bc mujs

mkdir fuzz
cd fuzz
cp ../mujs.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mujs.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mujs.ci.bc  -lstdc++  -o mujs.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-mujs -t 1000+ -m none -z exp -c 45m -q 1 -i /home/js -o /home/out -- /home/waflgo-mujs/fuzz/mujs.ci  @@
```

### mujs-issue-145
Docker Container
```commandline
docker run -d --name waflgo-mujs-145 waflgo_image tail -f /dev/null
docker exec -it waflgo-mujs-145 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```commandline
mkdir /home/js
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/js/* /home/js/
```
Download Subject
```commandline
git clone https://codeberg.org/ccxvii/mujs.git /home/waflgo-mujs
cd /home/waflgo-mujs; git checkout 4c7f6be
```
Build Binary
```commandline
export CC=/home/WAFLGo/afl-clang-fast
export CXX=/home/WAFLGo/afl-clang-fast++
export AFL_CC=gclang
export AFL_CXX=gclang++

make clean
make CFLAGS="-g --notI" CXXFLAGS="-g --notI" HAVE_READLINE=no
unset AFL_CC AFL_CXX

cp build/release/mujs ./
get-bc mujs

mkdir fuzz
cd fuzz
cp ../mujs.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mujs.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mujs.ci.bc  -lstdc++  -o mujs.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-mujs -t 1000+ -m none -z exp -c 45m -q 1 -i /home/js -o /home/out -- /home/waflgo-mujs/fuzz/mujs.ci  @@
```

### mujs-issue-166
Docker Container
```commandline
docker run -d --name waflgo-mujs-166 waflgo_image tail -f /dev/null
docker exec -it waflgo-mujs-166 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```commandline
mkdir /home/js
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/js/* /home/js/
```
Download Subject
```commandline
git clone https://codeberg.org/ccxvii/mujs.git /home/waflgo-mujs
cd /home/waflgo-mujs; git checkout 3f71a1c
```
Build Binary
```commandline
export CC=/home/WAFLGo/afl-clang-fast
export CXX=/home/WAFLGo/afl-clang-fast++
export AFL_CC=gclang
export AFL_CXX=gclang++

make clean
make CFLAGS="-g --notI" CXXFLAGS="-g --notI" HAVE_READLINE=no
unset AFL_CC AFL_CXX

cp build/release/mujs ./
get-bc mujs

mkdir fuzz
cd fuzz
cp ../mujs.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mujs.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mujs.ci.bc  -lstdc++  -o mujs.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-mujs -t 1000+ -m none -z exp -c 45m -q 1 -i /home/js -o /home/out -- /home/waflgo-mujs/fuzz/mujs.ci  @@
```

### libxml2-issue-535
Docker Container
```commandline
docker run -d --name waflgo-libxml2-535 waflgo_image tail -f /dev/null
docker exec -it waflgo-libxml2-535 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/xml
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/xml/* /home/xml/
```
Download Subject
```commandline
git clone https://gitlab.gnome.org/GNOME/libxml2.git /home/waflgo-libxml2
cd /home/waflgo-libxml2; git checkout 9a82b94
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make
unset AFL_CC AFL_CXX

get-bc xmllint

mkdir fuzz-walfgo
cd fuzz-walfgo
cp ../xmllint.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets xmllint.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ xmllint.ci.bc -lz -o xmllint.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libxml2 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/xml -o /home/out -- /home/waflgo-libxml2/fuzz-walfgo/xmllint.ci  @@
```

### libxml2-issue-550
Docker Container
```commandline
docker run -d --name waflgo-libxml2-550 waflgo_image tail -f /dev/null
docker exec -it waflgo-libxml2-550 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/xml
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/xml/* /home/xml/
```
Download Subject
```commandline
git clone https://gitlab.gnome.org/GNOME/libxml2.git /home/waflgo-libxml2
cd /home/waflgo-libxml2; git checkout 7e3f469
```
Build Binary
```commandline
cd /home
AUTOMAKE_VERSION=1.16.3
wget "https://ftp.gnu.org/gnu/automake/automake-${AUTOMAKE_VERSION}.tar.gz"
tar -xzf "automake-${AUTOMAKE_VERSION}.tar.gz"
cd "automake-${AUTOMAKE_VERSION}"
./configure
make
make install

cd /home/waflgo-libxml2
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++

export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"
echo 'export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"' >> ~/.bashrc
./autogen.sh --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make
unset AFL_CC AFL_CXX
get-bc xmllint

mkdir fuzz-walfgo
cd fuzz-walfgo
cp ../xmllint.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets xmllint.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ xmllint.ci.bc -lz -o xmllint.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libxml2 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/xml -o /home/out -- /home/waflgo-libxml2/fuzz-walfgo/xmllint.ci  @@
```

### libjpeg-issue-493
Docker Container
```commandline
docker run -d --name waflgo-libjpeg-493 waflgo_image tail -f /dev/null
docker exec -it waflgo-libjpeg-493 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Download Subject
```commandline
git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git /home/waflgo-libjpeg
cd /home/waflgo-libjpeg; git checkout 88ae609
```
Build Binary
```commandline
export ADD="-g --notI "
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make -j $(nproc) 
unset AFL_CC AFL_CXX

cp ./cjpeg-static ./
get-bc cjpeg-static 

mkdir fuzz; cd fuzz
cp ../cjpeg-static.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets cjpeg-static.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ cjpeg-static.ci.bc  -lstdc++  -o cjpeg-static.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libjpeg -t 1000+ -m none -z exp -c 45m -q 1 -i /home/jpg -o /home/out -- /home/waflgo-libjpeg/fuzz/cjpeg-static.ci  @@
```

### libjpeg-issue-636
Docker Container
```commandline
docker run -d --name waflgo-libjpeg-636 waflgo_image tail -f /dev/null
docker exec -it waflgo-libjpeg-636 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Download Subject
```commandline
git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git /home/waflgo-libjpeg
cd /home/waflgo-libjpeg; git checkout 88ae609
```
Build Binary
```commandline
export ADD="-g --notI "
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make -j $(nproc) 
unset AFL_CC AFL_CXX

cp ./jpegtran-static ./
get-bc jpegtran-static

mkdir fuzz; cd fuzz
cp ../jpegtran-static.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets jpegtran-static.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ jpegtran-static.ci.bc  -lstdc++  -o jpegtran-static.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libjpeg -t 1000+ -m none -z exp -c 45m -q 1 -i /home/jpg -o /home/out -- /home/waflgo-libjpeg/fuzz/jpegtran-static.ci  @@
```

### libtiff-issue-488
Docker Container
```commandline
docker run -d --name waflgo-libtiff-488 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-488 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout 7057734d
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcrop ./
get-bc tiffcrop

mkdir fuzz; cd fuzz
cp ../tiffcrop.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcrop.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcrop.ci.bc  -lstdc++ -lz -o tiffcrop.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcrop.ci  @@ /dev/null
```

### libtiff-issue-498
Docker Container
```commandline
docker run -d --name waflgo-libtiff-498 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-498 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout 07d79fcac
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcrop ./
get-bc tiffcrop

mkdir fuzz; cd fuzz
cp ../tiffcrop.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcrop.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcrop.ci.bc  -lstdc++ -lz -o tiffcrop.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcrop.ci  @@ /dev/null
```

### libtiff-issue-519
Docker Container
```commandline
docker run -d --name waflgo-libtiff-519 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-519 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout f13cf46b
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcrop ./
get-bc tiffcrop

mkdir fuzz; cd fuzz
cp ../tiffcrop.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcrop.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcrop.ci.bc  -lstdc++ -lz -o tiffcrop.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcrop.ci  @@ /dev/null
```

### libtiff-issue-520
Docker Container
```commandline
docker run -d --name waflgo-libtiff-520 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-520 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout e3195080
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcrop ./
get-bc tiffcrop

mkdir fuzz; cd fuzz
cp ../tiffcrop.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcrop.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcrop.ci.bc  -lstdc++ -lz -o tiffcrop.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcrop.ci  @@ /dev/null
```

### libtiff-issue-527
Docker Container
```commandline
docker run -d --name waflgo-libtiff-527 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-527 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout 07d79fcac
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcrop ./
get-bc tiffcrop

mkdir fuzz; cd fuzz
cp ../tiffcrop.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcrop.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcrop.ci.bc  -lstdc++ -lz -o tiffcrop.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcrop.ci  @@ /dev/null
```

### libtiff-issue-530
Docker Container
```commandline
docker run -d --name waflgo-libtiff-530 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-530 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout f13cf46b
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcrop ./
get-bc tiffcrop

mkdir fuzz; cd fuzz
cp ../tiffcrop.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcrop.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcrop.ci.bc  -lstdc++ -lz -o tiffcrop.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcrop.ci  @@ /dev/null
```

### libtiff-issue-548
Docker Container
```commandline
docker run -d --name waflgo-libtiff-548 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-548 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout 3079627e
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffcp ./
get-bc tiffcp

mkdir fuzz; cd fuzz
cp ../tiffcp.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffcp.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffcp.ci.bc  -lstdc++ -lz -o tiffcp.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffcp.ci  '@@' /dev/null
```

### libtiff-issue-559
Docker Container
```commandline
docker run -d --name waflgo-libtiff-559 waflgo_image tail -f /dev/null
docker exec -it waflgo-libtiff-559 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/tiff
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/tiff/* /home/tiff/
```
Download Subject
```commandline
git clone https://gitlab.com/libtiff/libtiff.git /home/waflgo-libtiff
cd /home/waflgo-libtiff; git checkout b90b20d3
```
Build Binary
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp tools/tiffinfo ./
get-bc tiffinfo

mkdir fuzz; cd fuzz
cp ../tiffinfo.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tiffinfo.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tiffinfo.ci.bc  -lstdc++ -lz -o tiffinfo.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-libtiff -t 1000+ -m none -z exp -c 45m -q 1 -i /home/tiff -o /home/out -- /home/waflgo-libtiff/fuzz/tiffinfo.ci  @@
```

### bento4-issue-652
Docker Container
```commandline
docker run -d --name waflgo-bento4-652 waflgo_image tail -f /dev/null
docker exec -it waflgo-bento4-652 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/mp4
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/mp4/* /home/mp4/
```
Download Subject
```commandline
git clone https://github.com/axiomatic-systems/Bento4.git /home/waflgo-bento4
cd /home/waflgo-bento4; git checkout c9f2c53
```
Build Binary
```commandline
export ADD="-g --notI "
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make
unset AFL_CC AFL_CXX

cp ./mp4info ./
get-bc mp4info 

mkdir fuzz; cd fuzz
cp ../mp4info.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff | ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | sed 's/:+.*$//' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mp4info.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mp4info.ci.bc  -lstdc++  -o mp4info.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out -- /home/waflgo-bento4/fuzz/mp4info.ci  @@
```

### bento4-issue-679
Docker Container
```commandline
docker run -d --name waflgo-bento4-679 waflgo_image tail -f /dev/null
docker exec -it waflgo-bento4-679 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/mp4
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/mp4/* /home/mp4/
```
Download Subject
```commandline
git clone https://github.com/axiomatic-systems/Bento4.git /home/waflgo-bento4
cd /home/waflgo-bento4; git checkout 2e29350
```
Build Binary
```commandline
export ADD="-g --notI "
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make
unset AFL_CC AFL_CXX

cp ./mp4info ./
get-bc mp4info 

mkdir fuzz; cd fuzz
cp ../mp4info.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff | ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | sed 's/:+.*$//' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mp4info.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mp4info.ci.bc  -lstdc++  -o mp4info.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out -- /home/waflgo-bento4/fuzz/mp4info.ci  @@
```

### bento4-issue-732
Docker Container
```commandline
docker run -d --name waflgo-bento4-732 waflgo_image tail -f /dev/null
docker exec -it waflgo-bento4-732 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/mp4
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/mp4/* /home/mp4/
```
Download Subject
```commandline
git clone https://github.com/axiomatic-systems/Bento4.git /home/waflgo-bento4
cd /home/waflgo-bento4; git checkout bbb6f24
```
Build Binary
```commandline
export ADD="-g --notI "
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make
unset AFL_CC AFL_CXX

cp ./mp4audioclip ./
get-bc mp4audioclip

mkdir fuzz; cd fuzz
cp ../mp4audioclip.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff | ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | sed 's/:+.*$//' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mp4audioclip.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mp4audioclip.ci.bc  -lstdc++  -o mp4audioclip.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out -- /home/waflgo-bento4/fuzz/mp4audioclip.ci  @@
```

### bento4-issue-751
Docker Container
```commandline
docker run -d --name waflgo-bento4-751 waflgo_image tail -f /dev/null
docker exec -it waflgo-bento4-751 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/mp4
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/mp4/* /home/mp4/
```
Download Subject
```commandline
git clone https://github.com/axiomatic-systems/Bento4.git /home/waflgo-bento4
cd /home/waflgo-bento4; git checkout 61b2012
```
Build Binary
```commandline
export ADD="-g --notI "
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make
unset AFL_CC AFL_CXX

cp ./mp42aac ./
get-bc mp42aac

mkdir fuzz; cd fuzz
cp ../mp42aac.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff | ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*: " -e "\.cpp:[0-9]*: " -e "\.cc:[0-9]*: " | sed 's/: .*//' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mp42aac.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mp42aac.ci.bc  -lstdc++  -o mp42aac.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Build Binary with ASAN
```commandline
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast CXX=/home/WAFLGo/afl-clang-fast++  CFLAGS="$ADD" CXXFLAGS="$ADD"
export AFL_CC=gclang AFL_CXX=gclang++

cmake . 
make clean;make
unset AFL_CC AFL_CXX

cp ./mp42aac ./
get-bc mp42aac

mkdir fuzz; cd fuzz
cp ../mp42aac.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff | ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*: " -e "\.cpp:[0-9]*: " -e "\.cc:[0-9]*: " | sed 's/: .*//' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets mp42aac.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ mp42aac.ci.bc  -fsanitize=address -lstdc++  -o mp42aac.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out -- /home/waflgo-bento4/fuzz/mp42aac.ci  @@ /dev/null
```
Start fuzzing with ASAN enabled
```commandline
export ASAN_OPTIONS=abort_on_error=1
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out_asan -- /home/waflgo-bento4/fuzz/mp42aac.ci  @@ /dev/null
```

