redo-ifchange ../src/unsigned.in ../src/signed.in

redo-ifchange mk-m4defs.sh
redo-ifchange ../src/c.m4 ../src/predithmatic.c
redo-ifchange \
    ../src/align-portable.m4 \
    ../src/*_unsigned-portable.m4 \
    ../src/*_signed-portable.m4


cat ../src/predithmatic.c |
    m4 >> $3


# create declarations bits

for T in `grep -v '^\s*#' ../src/unsigned.in | grep .`; do
    ./mk-m4defs.sh $T |
        cat ../src/c.m4 - ../src/*_unsigned-portable.m4 |
        m4 |
        grep -h '^\S.*) {$' | sed 's/) {$/);/g' >> $3
    echo '' >> $3
done;

for T in `grep -v '^\s*#' ../src/signed.in | grep .`; do
    ./mk-m4defs.sh $T |
        cat ../src/c.m4 - ../src/*_signed-portable.m4 |
        m4 |
        grep -h '^\S.*) {$' | sed 's/) {$/);/g' >> $3
    echo '' >> $3
done;

cat ../src/c.m4 ../src/align-portable.m4 |
    grep -h '^\S.*) {$' | sed 's/) {$/);/g' |
    m4 >> $3
echo '' >> $3

echo '' >> $3


# create definitions

for T in `grep -v '^\s*#' ../src/unsigned.in | grep .`; do
    ./mk-m4defs.sh $T |
        cat ../src/c.m4 - ../src/*_unsigned-portable.m4 |
        m4 >> $3
done;

for T in `grep -v '^\s*#' ../src/signed.in | grep .`; do
    ./mk-m4defs.sh $T |
        cat ../src/c.m4 - ../src/*_signed-portable.m4 |
        m4 >> $3
done;

cat ../src/c.m4 ../src/align-portable.m4 |
    m4 >> $3
