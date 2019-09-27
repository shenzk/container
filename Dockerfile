# docker-cli
# FROM alpine:3.10
FROM xenocider/container:python3.7.3
LABEL maintainer="xenos <xenos.lu@gmail.com>"

ENV PS1 '\h:\w\$ '
ENV TZ 'Asia/Shanghai'

RUN apk add --no-cache \
            tzdata \
            docker-cli \
            docker \
            curl \
            git \
            vim \
            openssh-client \
            openssh-server\
            nethogs \
            &&\
    apk add --no-cache \
            python3-dev \
            libffi-dev \
            openssl-dev \
            gcc \
            libc-dev \
            make &&\
    apk add --no-cache \
            nodejs \
            yarn &&\
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime &&\
    echo $TZ > /etc/timezone &&\
    pip3 install docker-compose &&\
    rm -rf /root/.cache

RUN ssh-keygen -A && \
    echo "root:$RANDOM" | chpasswd &&\
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config &&\
	echo StrictHostKeyChecking no>> /etc/ssh/ssh_config

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl &&\
    mv ./kubectl /usr/local/bin/kubectl

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
    
CMD ["/usr/sbin/sshd", "-D"]
