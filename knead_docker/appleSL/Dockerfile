FROM  --platform=linux/x86_64 python:3.8
USER root

RUN apt-get update

CMD ["/bin/bash"]

RUN pip3 install anadama2==0.10.0

RUN pip3 install kneaddata==0.12.0 --no-binary :all:


# Install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 && \
    rm -r Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/miniconda3/bin:$PATH

RUN pip install --upgrade pip && \
    conda update -n base -c defaults conda 


RUN conda install -c bioconda trf==4.09.1

RUN conda install -c bioconda bbmap==38.84-0

## Install Java
RUN apt-get install -y default-jdk=2:1.17-74
RUN apt-get install -y default-jre=2:1.17-74


WORKDIR /tmp
