FROM ubuntu:12.04
MAINTAINER Yuichi Murata <mrk21info+docker@gmail.com>

RUN apt-get update
RUN apt-get install -y python-software-properties vim wget tree git subversion make autoconf
RUN add-apt-repository --yes ppa:ubuntu-toolchain-r/test
RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -
RUN add-apt-repository --yes 'deb http://llvm.org/apt/precise/ llvm-toolchain-precise main'
RUN apt-get update
RUN apt-get install -y gcc-4.9 g++-4.9 clang-3.7 clang++-3.7
RUN update-alternatives --install /usr/bin/clang   clang   /usr/bin/clang-3.7   37 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.7 37
RUN cd && \
    wget http://www.cmake.org/files/v3.1/cmake-3.1.0.tar.gz && \
    tar xvf cmake-3.1.0.tar.gz && \
    cd cmake-3.1.0 && \
    ./bootstrap --prefix=/usr && \
    make && \
    make install && \
    cd && \
    rm -rf cmake-3.1.0*
RUN cd && \
    svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx && \
    cd libcxx && \
    mkdir build && \
    cd build && \
    CC=clang CXX=clang++ cmake \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release \
      -DLIBCXX_CXX_ABI=libstdc++ \
      -DLIBCXX_LIBSUPCXX_INCLUDE_PATHS="/usr/include/c++/4.9;/usr/include/x86_64-linux-gnu/c++/4.9" \
    .. && \
    make && \
    make install && \
    cd && \
    rm -rf libcxx
RUN cd && \
    apt-get install -y python-dev libbz2-dev && \
    wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz && \
    tar xvf boost_1_57_0.tar.gz && \
    cd boost_1_57_0 && \
    ./bootstrap.sh --with-toolset=clang --prefix=/usr && \
    ./b2 install \
      toolset=clang \
      cxxflags="-std=gnu++14 -stdlib=libc++" \
      linkflags="-stdlib=libc++" \
      --prefix=/usr \
      -j 2 \
    && \
    cd && \
    rm -rf boost_1_57_0*
RUN apt-get install -y libssl-dev
