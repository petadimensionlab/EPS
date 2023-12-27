FROM --platform=linux/x86_64 python:3.8
USER root

CMD ["/bin/bash"]

RUN pip3 install anadama2
RUN pip3 install humann==3.8 --no-binary :all: && ldconfig /usr/local/lib
RUN pip3 install numpy cython
RUN pip3 install biom-format
RUN pip3 install metaphlan==4.0.4
WORKDIR /tmp
