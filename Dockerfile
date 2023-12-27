FROM python:3.8
USER root

CMD ["/bin/bash"]


RUN pip3 install anadama2==0.10.0
RUN pip3 install humann==3.8 --no-binary :all: && ldconfig /usr/local/lib
RUN pip3 install numpy cython==3.0.6
RUN pip3 install biom-format==2.1.15
RUN pip3 install metaphlan==4.0.4
WORKDIR /tmp
