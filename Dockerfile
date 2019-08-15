# xenocider/container:ubuntu-uam
FROM ubuntu:18.04
LABEL maintainer="xenos <xenos.lu@gmail.com>"
ENV LANG="C.UTF-8"
COPY requirements.txt /

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    apt-get update &&\
    apt-get install -y python3\
                       python3-pip \
                       wget \
                       curl \
                       jq \
                       git \
                       make \
                       gnupg \
                       g++ \
                       ruby \
                       ruby-dev &&\
     pip3 install -r /requirements.txt &&\
    gem install cf-uaac &&\
    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - &&\
    echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list &&\
    apt-get update &&\
    apt-get install -y cf-cli &&\
    echo StrictHostKeyChecking no>> /etc/ssh/ssh_config

CMD ["/bin/bash"]
