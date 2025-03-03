FROM ubuntu:latest

# Updating packages and installing needed dependencies
RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        cmake \
        git \
        build-essential \
        ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Cloning Cyclone DDS repository and compiling
RUN git clone https://github.com/eclipse-cyclonedds/cyclonedds.git /opt/cyclonedds \
    && cd /opt/cyclonedds \
    && mkdir build && cd build \
    && cmake -G Ninja .. \
    && ninja \
    && ninja install \
    && ldconfig
    
# Cloning Cyclone DDS C++ binding repository and compiling
RUN git clone https://github.com/eclipse-cyclonedds/cyclonedds-cxx.git /opt/cyclonedds-cxx \
    && cd /opt/cyclonedds-cxx \
    && mkdir build && cd build \
    && cmake -G Ninja .. \
    && ninja \
    && ninja install \
    && ldconfig

ENV PATH="/usr/local/bin:$PATH"

CMD ["/bin/bash"]
