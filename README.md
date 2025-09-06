# WAFLGo Build Binary Commands
It contains the commands to build the binaries for all the commits evaluated in the [WAFLGO](https://www.usenix.org/conference/usenixsecurity24/presentation/xiang-yi) paper.

The [Github repository](https://github.com/NESA-Lab/WAFLGo) of the paper only provides command to build the binary of libjpeg-issue-493. This directory will provide commands to build binaries of all the commits evaluated in the paper.

## Docker Image
The Docker image provided by the authors have a serious bug inside. You cannot pull this image if you are using rootless Docker, which restricts the running of the program on remote servers.
A Dockerfile is provided to build an image with the bug solved
Use the following command in the directory where Dockerfile is present to build the image:
```commandline
docker build -t walfgo_image .
```
An image with the name walfgo_image is built.

## Seeds
Clone the seeds used in the paper.
```commandline
cd /home
git clone https://github.com/unifuzz/seeds.git
```

## Commands for Commits Evaluated in Paper
### mujs-issue-65
Download Subject
```commandline
git clone https://codeberg.org/ccxvii/mujs.git /home/waflgo-mujs
cd /home/mujs; git checkout 8c27b12
```
Copy Seeds to Required Dictionary
```commandline
mkdir js
cp /home/seeds/general_evaluation/mujs/* /home/js/
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
cd /home
/home/WAFLGo/afl-fuzz  -T waflgo-mujs -t 1000+ -m none -z exp -c 45m -q 1 -i /home/js -o /home/out -- /home/waflgo-mujs/fuzz/mujs.ci  @@
```
