## jupyter lab
FROM xenocider/container:python3.7.3
LABEL maintainer="xenos <xenos.lu@gmail.com>"
    
RUN apk add --no-cache --virtual .fetch-deps \
       g++ &&\
    pip3 install jupyterlab &&\
    apk del .fetch-deps &&\
    rm -rf /var/cache/* /root/.cache

EXPOSE 8888

CMD ["jupyter", "lab"]
