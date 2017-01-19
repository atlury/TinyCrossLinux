
source stage0n_variables
source stage01_variables
source stage02_variables
 
PKGNAME=smack
PKGVERSION=1.3.0

# Download:
# https://github.com/smack-team/smack/archive/v1.3.0.tar.gz

[ -f ${SRCDIR}/v${PKGVERSION}.tar.gz ] || wget -O ${SRCDIR}/v${PKGVERSION}.tar.gz \
	https://github.com/smack-team/smack/archive/v${PKGVERSION}.tar.gz

# Prepare build:

mkdir -p ${CLFS}/build/${PKGNAME}-${PKGVERSION}
cd ${CLFS}/build/${PKGNAME}-${PKGVERSION}
tar xvf ${SRCDIR}/v${PKGVERSION}.tar.gz

# Build and install

export CPPFLAGS=-I${CLFS}/targetfs/${CLFS_TARGET}/include/kernel

cd ${CLFS}/build/${PKGNAME}-${PKGVERSION}/${PKGNAME}-${PKGVERSION}
bash autogen.sh
./configure --prefix=/usr --host=${CLFS_TARGET}
make || exit 1
make install DESTDIR=${CLFS}/targetfs || exit 1

# Clean up

rm -rf ${CLFS}/build/${PKGNAME}-${PKGVERSION}/${PKGNAME}-${PKGVERSION}

