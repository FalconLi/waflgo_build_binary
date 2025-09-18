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
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out -- /home/waflgo-bento4/fuzz/mp4audioclip.ci  @@ /dev/null
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
export ASAN_OPTIONS=abort_on_error=1:symbolize=0
/home/WAFLGo/afl-fuzz  -T waflgo-bento4 -t 1000+ -m none -z exp -c 45m -q 1 -i /home/mp4 -o /home/out_asan -- /home/waflgo-bento4/fuzz/mp42aac.ci  @@ /dev/null
```

### tcpreplay-issue-702
Docker Container
```commandline
docker run -d --name waflgo-tcpreplay-702 waflgo_image tail -f /dev/null
docker exec -it waflgo-tcpreplay-702 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pcap
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pcap/* /home/pcap/
```
Download Subject
```commandline
git clone https://github.com/appneta/tcpreplay /home/waflgo-tcpreplay
cd /home/waflgo-tcpreplay; git checkout 0a65668a
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y guile-2.2-dev

cd /home
wget https://ftp.gnu.org/gnu/autogen/rel5.18.16/autogen-5.18.16.tar.xz
tar -xvf autogen-5.18.16.tar.xz
cd autogen-5.18.16
./configure --disable-dependency-tracking
sed -i 's/-Werror//g' getdefs/Makefile
sed -i 's/-Wall//g' getdefs/Makefile
make
make install

export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"
echo 'export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"' >> ~/.bashrc

apt-get install -y libpcap-dev

cd /home/waflgo-tcpreplay
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline --disable-local-libopts LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp src/tcprewrite ./
get-bc tcprewrite

mkdir fuzz; cd fuzz
cp ../tcprewrite.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tcprewrite.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tcprewrite.ci.bc -lstdc++ -lopts -lpcap -o tcprewrite.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-tcpreplay -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pcap -o /home/out -- /home/waflgo-tcpreplay/fuzz/tcprewrite.ci -i @@ -o /dev/null
```

### tcpreplay-issue-718
Docker Container
```commandline
docker run -d --name waflgo-tcpreplay-718 waflgo_image tail -f /dev/null
docker exec -it waflgo-tcpreplay-718 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pcap
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pcap/* /home/pcap/
```
Download Subject
```commandline
git clone https://github.com/appneta/tcpreplay /home/waflgo-tcpreplay
cd /home/waflgo-tcpreplay; git checkout 2c76868d
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y guile-2.2-dev

cd /home
wget https://ftp.gnu.org/gnu/autogen/rel5.18.16/autogen-5.18.16.tar.xz
tar -xvf autogen-5.18.16.tar.xz
cd autogen-5.18.16
./configure --disable-dependency-tracking
sed -i 's/-Werror//g' getdefs/Makefile
sed -i 's/-Wall//g' getdefs/Makefile
make
make install

export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"
echo 'export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"' >> ~/.bashrc

apt-get install -y libpcap-dev

cd /home/waflgo-tcpreplay
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline --disable-local-libopts LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp src/tcprewrite ./
get-bc tcprewrite

mkdir fuzz; cd fuzz
cp ../tcprewrite.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tcprewrite.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tcprewrite.ci.bc -lstdc++ -lopts -lpcap -o tcprewrite.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-tcpreplay -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pcap -o /home/out -- /home/waflgo-tcpreplay/fuzz/tcprewrite.ci -i @@ -o /dev/null
```

### tcpreplay-issue-756
Docker Container
```commandline
docker run -d --name waflgo-tcpreplay-756 waflgo_image tail -f /dev/null
docker exec -it waflgo-tcpreplay-756 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pcap
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pcap/* /home/pcap/
```
Download Subject
```commandline
git clone https://github.com/appneta/tcpreplay /home/waflgo-tcpreplay
cd /home/waflgo-tcpreplay; git checkout 16442ac3
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y guile-2.2-dev

cd /home
wget https://ftp.gnu.org/gnu/autogen/rel5.18.16/autogen-5.18.16.tar.xz
tar -xvf autogen-5.18.16.tar.xz
cd autogen-5.18.16
./configure --disable-dependency-tracking
sed -i 's/-Werror//g' getdefs/Makefile
sed -i 's/-Wall//g' getdefs/Makefile
make
make install

export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"
echo 'export ACLOCAL_PATH="/usr/share/aclocal:/usr/local/share/aclocal"' >> ~/.bashrc

apt-get install -y libpcap-dev

cd /home/waflgo-tcpreplay
export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++
./autogen.sh
./configure --enable-static --disable-shared --without-python --without-readline --disable-local-libopts LDFLAGS="-static"

make clean;make 
unset AFL_CC AFL_CXX

cp src/tcpprep ./
get-bc tcpprep

mkdir fuzz; cd fuzz
cp ../tcpprep.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tcpprep.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ tcpprep.ci.bc -lstdc++ -lopts -lpcap -o tcpprep.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-tcpreplay -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pcap -o /home/out -- /home/waflgo-tcpreplay/fuzz/tcpprep.ci --auto=bridge -i @@ -o /dev/null
```

### tcpreplay-issue-772 (Unable to run after building binary, anyone who can solve this error, just raise an issue)
Docker Container
```commandline
docker run -d --name waflgo-tcpreplay-772 waflgo_image tail -f /dev/null
docker exec -it waflgo-tcpreplay-772 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pcap
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pcap/* /home/pcap/
```
Download Subject
```commandline
git clone https://github.com/appneta/tcpreplay /home/waflgo-tcpreplay
cd /home/waflgo-tcpreplay; git checkout 4f9158da
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y guile-2.0-dev

cd /home
wget https://ftp.gnu.org/gnu/autogen/rel5.18.12/autogen-5.18.12.tar.xz
tar -xvf autogen-5.18.12.tar.xz
cd autogen-5.18.12
./configure
make
make install

apt-get install -y libpcap-dev

cd /home/waflgo-tcpreplay
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

cp src/tcpreplay ./
get-bc tcpreplay

mkdir fuzz; cd fuzz
cp ../tcpreplay.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff | ./showlinenum.awk show_header=0 path=1 | awk '
BEGIN { 
    prev_line = 0; prev_file = ""; 
    in_deleted_block = 0; deleted_file = ""; deleted_prev_line = 0 
}
/\.(c|h|cpp|cc):/ {
    if ($0 ~ /:[0-9]+:[+-]/) {
        # Line with number and +/- change
        # First, handle any pending deleted block
        if (in_deleted_block) {
            if (deleted_file == prev_file && deleted_prev_line > 0) {
                print deleted_file ":" deleted_prev_line
                print deleted_file ":" (deleted_prev_line + 1)
            }
            in_deleted_block = 0
        }
        
        match($0, /^([^:]+):([0-9]+):([+-])/, arr)
        file = arr[1]
        line_num = arr[2]
        change_type = arr[3]
        
        gsub(".*/", "", file)  # Extract just filename
        print file ":" line_num
        
        prev_line = line_num
        prev_file = file
    } else if ($0 ~ /:[[:space:]]+:[+-]/) {
        # Deleted line (no line number, just spaces)
        match($0, /^([^:]+):[[:space:]]+:[-]/, arr)
        file = arr[1]
        gsub(".*/", "", file)  # Extract just filename
        
        if (!in_deleted_block) {
            # Start of a new deleted block
            in_deleted_block = 1
            deleted_file = file
            deleted_prev_line = prev_line
        }
    } else if ($0 ~ /:[0-9]+:/) {
        # Context line (no +/- but has line number)
        # First, handle any pending deleted block
        if (in_deleted_block) {
            if (deleted_file == prev_file && deleted_prev_line > 0) {
                print deleted_file ":" deleted_prev_line
                print deleted_file ":" (deleted_prev_line + 1)
            }
            in_deleted_block = 0
        }
        
        match($0, /^([^:]+):([0-9]+):/, arr)
        prev_line = arr[2]
        prev_file = arr[1]
        gsub(".*/", "", prev_file)
    }
}
END {
    # Handle any remaining deleted block at the end
    if (in_deleted_block) {
        if (deleted_file == prev_file && deleted_prev_line > 0) {
            print deleted_file ":" deleted_prev_line
            print deleted_file ":" (deleted_prev_line + 1)
        }
    }
}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets tcpreplay.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

cat > tcpedit_stub.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>

// More complete stub for tcpedit
typedef struct {
    char* name;
    char* desc;
    int value;
} optDesc_t;

static optDesc_t dummy_opts[] = {
    {"dummy", "dummy option", 0},
    {NULL, NULL, 0}
};

const void* const tcpedit_tcpedit_optDesc_p = (void*)dummy_opts;

// Add any other missing symbols
void tcpedit_init(void) {}
void tcpedit_cleanup(void) {}
EOF

/home/WAFLGo/afl-clang-fast -c tcpedit_stub.c -o tcpedit_stub.o

/home/WAFLGo/afl-clang-fast++ tcpreplay.ci.bc \
  tcpedit_stub.o \
  /home/waflgo-tcpreplay/src/tcpedit/libtcpedit.a \
  /home/waflgo-tcpreplay/src/common/libcommon.a \
  /home/waflgo-tcpreplay/libopts/.libs/libopts.a \
  /home/waflgo-tcpreplay/lib/libstrl.a \
  -lstdc++ -lpcap -o tcpreplay.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
/home/WAFLGo/afl-fuzz  -T waflgo-tcpreplay -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pcap -o /home/out -- /home/waflgo-tcpreplay/fuzz/tcpreplay.ci -i eth0 @@
```

### poppler-issue-1282
Docker Container
```commandline
docker run -d --name waflgo-poppler-1282 waflgo_image tail -f /dev/null
docker exec -it waflgo-poppler-1282 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pdf
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pdf/* /home/pdf/
```
Download Subject
```commandline
git clone https://gitlab.freedesktop.org/poppler/poppler.git /home/waflgo-poppler
git clone git://git.freedesktop.org/git/poppler/test /home/test
cd /home/waflgo-poppler; git checkout 3d35d20
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff5-dev libcairo2-dev

#export ADD="-g -static --notI"
#export CC=/home/WAFLGo/afl-clang-fast 
#export CXX=/home/WAFLGo/afl-clang-fast++
#export CFLAGS="$ADD" 
#export CXXFLAGS="$ADD"
#export LDFLAGS="-static"
#export AFL_CC=gclang 
#export AFL_CXX=gclang++

export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++

#cmake .
cmake . \
  -DCMAKE_BUILD_TYPE=Debug \
  -DBUILD_SHARED_LIBS=OFF
make clean;make 
unset AFL_CC AFL_CXX

cp utils/pdfunite ./
get-bc pdfunite

mkdir fuzz; cd fuzz
cp ../pdfunite.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets pdfunite.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ pdfunite.ci.bc -lstdc++ -o pdfunite.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
export LD_LIBRARY_PATH=/home/waflgo-poppler:/home/waflgo-poppler/cpp:/home/waflgo-poppler/glib:$LD_LIBRARY_PATH
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdfunite.ci @@ @@ /dev/null
# or
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdfunite.ci @@ /dev/null
```

### poppler-issue-1289
Docker Container
```commandline
docker run -d --name waflgo-poppler-1289 waflgo_image tail -f /dev/null
docker exec -it waflgo-poppler-1289 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pdf
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pdf/* /home/pdf/
```
Download Subject
```commandline
git clone https://gitlab.freedesktop.org/poppler/poppler.git /home/waflgo-poppler
cd /home/waflgo-poppler; git checkout 3cae777
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff5-dev libcairo2-dev

export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++

cmake .
make clean;make 
unset AFL_CC AFL_CXX

cp utils/pdfunite ./
get-bc pdfunite

mkdir fuzz; cd fuzz
cp ../pdfunite.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets pdfunite.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ pdfunite.ci.bc -lstdc++ -L/home/waflgo-poppler -lpoppler -o pdfunite.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
export LD_LIBRARY_PATH=/home/waflgo-poppler:/home/waflgo-poppler/cpp:/home/waflgo-poppler/glib:$LD_LIBRARY_PATH
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdfunite.ci @@ @@ /dev/null
# or
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdfunite.ci @@ /dev/null
```

### poppler-issue-1303
Docker Container
```commandline
docker run -d --name waflgo-poppler-1303 waflgo_image tail -f /dev/null
docker exec -it waflgo-poppler-1303 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pdf
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pdf/* /home/pdf/
```
Download Subject
```commandline
git clone https://gitlab.freedesktop.org/poppler/poppler.git /home/waflgo-poppler
cd /home/waflgo-poppler; git checkout e674ca6
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff5-dev libcairo2-dev

export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++

cmake .
make clean;make 
unset AFL_CC AFL_CXX

cp utils/pdftops ./
get-bc pdftops

mkdir fuzz; cd fuzz
cp ../pdftops.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets pdftops.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ pdftops.ci.bc -lstdc++ -L/home/waflgo-poppler -lpoppler -o pdftops.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
export LD_LIBRARY_PATH=/home/waflgo-poppler:/home/waflgo-poppler/cpp:/home/waflgo-poppler/glib:$LD_LIBRARY_PATH
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdftops.ci @@ /dev/null
```

### poppler-issue-1305
Docker Container
```commandline
docker run -d --name waflgo-poppler-1305 waflgo_image tail -f /dev/null
docker exec -it waflgo-poppler-1305 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pdf
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pdf/* /home/pdf/
```
Download Subject
```commandline
git clone https://gitlab.freedesktop.org/poppler/poppler.git /home/waflgo-poppler
git clone git://git.freedesktop.org/git/poppler/test /home/test
cd /home/waflgo-poppler; git checkout aaf2e80
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff5-dev libcairo2-dev

cat > toolchain.cmake << 'EOF'
set(CMAKE_C_COMPILER /home/WAFLGo/afl-clang-fast)
set(CMAKE_CXX_COMPILER /home/WAFLGo/afl-clang-fast++)
set(CMAKE_C_FLAGS_INIT "-g  --notI -fPIC")
set(CMAKE_CXX_FLAGS_INIT "-g --notI -fPIC")

# Manually set library paths to bypass detection tests
set(FREETYPE_LIBRARY /usr/lib/x86_64-linux-gnu/libfreetype.so)
set(FREETYPE_INCLUDE_DIRS /usr/include/freetype2)
set(FREETYPE_FOUND TRUE)

set(JPEG_LIBRARY /usr/lib/x86_64-linux-gnu/libjpeg.so)
set(JPEG_INCLUDE_DIR /usr/include)
set(JPEG_FOUND TRUE)

set(PNG_LIBRARY /usr/lib/x86_64-linux-gnu/libpng.so)
set(PNG_PNG_INCLUDE_DIR /usr/include)
set(PNG_FOUND TRUE)

set(TIFF_LIBRARY /usr/lib/x86_64-linux-gnu/libtiff.so)
set(TIFF_INCLUDE_DIR /usr/include)
set(TIFF_FOUND TRUE)

set(CAIRO_LIBRARIES /usr/lib/x86_64-linux-gnu/libcairo.so)
set(CAIRO_INCLUDE_DIRS /usr/include/cairo)
set(CAIRO_FOUND TRUE)

set(ICONV_LIBRARIES "")
set(ICONV_FOUND TRUE)
EOF

export AFL_CC=gclang 
export AFL_CXX=gclang++

cmake . -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake -DENABLE_LIBOPENJPEG=none

#export ADD="-g --notI"
#export CC=/home/WAFLGo/afl-clang-fast 
#export CXX=/home/WAFLGo/afl-clang-fast++
#export CFLAGS="$ADD" 
#export CXXFLAGS="$ADD"

make clean;make 
unset AFL_CC AFL_CXX

cp utils/pdftoppm ./
get-bc pdftoppm

mkdir fuzz; cd fuzz
cp ../pdftoppm.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets pdftoppm.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ pdftoppm.ci.bc -lstdc++ -L/home/waflgo-poppler -lpoppler -o pdftoppm.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
export LD_LIBRARY_PATH=/home/waflgo-poppler:/home/waflgo-poppler/cpp:/home/waflgo-poppler/glib:$LD_LIBRARY_PATH
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdftoppm.ci @@
# or
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdftoppm.ci -mono -cropbox @@
```

### poppler-issue-1381
Docker Container
```commandline
docker run -d --name waflgo-poppler-1381 waflgo_image tail -f /dev/null
docker exec -it waflgo-poppler-1381 /bin/bash
```
Compile WAFLGo<br>
Refer to the commands [here](https://github.com/NESA-Lab/WAFLGo/tree/master#how-to-test-with-waflgo)

Copy Seeds to Required Dictionary
```
mkdir /home/pdf
git clone https://github.com/FalconLi/waflgo_build_binary.git /home/waflgo_build_binary
cp /home/waflgo_build_binary/seeds/pdf/* /home/pdf/
```
Download Subject
```commandline
git clone https://gitlab.freedesktop.org/poppler/poppler.git /home/waflgo-poppler
cd /home/waflgo-poppler; git checkout 245abad
```
Build Binary
```commandline
chmod 1777 /tmp
apt-get update
apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff5-dev libcairo2-dev

export ADD="-g --notI"
export CC=/home/WAFLGo/afl-clang-fast 
export CXX=/home/WAFLGo/afl-clang-fast++
export CFLAGS="$ADD" 
export CXXFLAGS="$ADD"
export AFL_CC=gclang 
export AFL_CXX=gclang++

cmake .
make clean;make 
unset AFL_CC AFL_CXX

cp utils/pdftoppm ./
get-bc pdftoppm

mkdir fuzz; cd fuzz
cp ../pdftoppm.bc .

echo $'' > $TMP_DIR/BBtargets.txt
git diff HEAD^1 HEAD > ./commit.diff
cp /home/showlinenum.awk ./
sed -i -e 's/\r$//' showlinenum.awk
chmod +x showlinenum.awk
cat ./commit.diff |  ./showlinenum.awk show_header=0 path=1 | grep -e "\.[ch]:[0-9]*:+" -e "\.cpp:[0-9]*:+" -e "\.cc:[0-9]*:+" | cut -d+ -f1 | rev | cut -c2- | rev | awk -F: '{n=split($1,a,"/"); print a[n]":"$2}' > ./targets

/home/WAFLGo/instrument/bin/cbi --targets=targets pdftoppm.bc --stats=false
cp ./targets_id.txt /home
cp ./suffix.txt /home
cp ./targets*.txt /home
cp ./distance.txt /home
cp ./branch-distance.txt /home
cp ./branch-distance-min.txt /home
cp ./branch-curloc.txt /home
cp ./*_data.txt /home

/home/WAFLGo/afl-clang-fast++ pdftoppm.ci.bc -lstdc++ -L/home/waflgo-poppler -lpoppler -o pdftoppm.ci
cp ./bbinfo-fast.txt /home/bbinfo-ci-bc.txt
cp ./branch-distance-order.txt /home
cp ./*-distance-order.txt /home
cp ./*-order.txt /home
```
Start fuzzing
```commandline
export LD_LIBRARY_PATH=/home/waflgo-poppler:/home/waflgo-poppler/cpp:/home/waflgo-poppler/glib:$LD_LIBRARY_PATH
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdftoppm.ci @@
# or
/home/WAFLGo/afl-fuzz  -T waflgo-poppler -t 1000+ -m none -z exp -c 45m -q 1 -i /home/pdf -o /home/out -- /home/waflgo-poppler/fuzz/pdftoppm.ci -mono -cropbox @@
```

