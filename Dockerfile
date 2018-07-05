FROM ubuntu
RUN apt update && apt install -y git wget unzip make g++
RUN apt install -y libboost-all-dev libopenblas-dev opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev zlib1g-dev
RUN git clone https://github.com/gcp/leela-zero
RUN cat /leela-zero/src/config.h | grep -v "define USE_OPENCL$" > /leela-zero/src/config_nogpu.h
RUN mv /leela-zero/src/config_nogpu.h /leela-zero/src/config.h
RUN cd /leela-zero/src/ && make
RUN cd /leela-zero/ && wget http://zero.sjeng.org/best-network
ENTRYPOINT ["/leela-zero/src/leelaz", "--weights", "/leela-zero/best-network"]
