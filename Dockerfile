#FROM ubuntu:19.10
FROM ubuntu:18.04

MAINTAINER Md Ashraful Alam <anjonbd2007@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Dependencies for the Installation
RUN apt-get update && apt-get -yq install cmake git libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libuhd-dev iproute2 libzmq3-dev libtool autoconf iptables net-tools


#First, one needs to install libzmq
RUN git clone https://github.com/zeromq/libzmq.git
RUN cd /libzmq && chmod +x autogen.sh && ./autogen.sh && ./configure && make && make install && ldconfig


#Second, install czmq
RUN git clone https://github.com/zeromq/czmq.git
RUN cd /czmq && chmod +x autogen.sh && ./autogen.sh && ./configure && make && make install && ldconfig


# Fetching srsLTE
RUN git clone https://github.com/srsLTE/srsLTE.git
RUN cd /srsLTE && mkdir build && cd build && cmake ../ && make && make install


# Add configuration files from SRS
ADD conf/enb.conf /etc/srslte/
ADD conf/drb.conf /etc/srslte/
ADD conf/rr.conf /etc/srslte/
ADD conf/sib.conf /etc/srslte/
ADD conf/sib.conf.mbsfn /etc/srslte/
ADD conf/epc.conf /etc/srslte/
ADD conf/user_db.csv /etc/srslte/

# Add Kubernetes launch scripts
#ADD dns_replace.sh /

# Set env variables
#ENV enb_id=0x19B
#ENV mcc=222
#ENV mnc=93
#ENV n_prb=25

ADD launcher2.sh /
ADD launcher.sh /
RUN chmod +x launcher.sh
# Run the launcher script
#ENTRYPOINT ["bash","/launcher2.sh"]
