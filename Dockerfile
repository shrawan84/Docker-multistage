FROM fedora:latest AS builder
RUN mkdir GIT
RUN sudo yum install git -y
WORKDIR GIT
RUN git init
RUN git clone https://github.com/Tej-Singh-Rana/Class-test.git
RUN mkdir /fgh
COPY shree.py /fgh



FROM alpine:latest AS build1
RUN apk add python3
COPY --from=builder /fgh/shree.py /
WORKDIR /  
RUN python3 shree.py >>shree.txt


FROM alpine:latest AS build2
WORKDIR /root/
RUN mkdir git && \
    touch code
COPY --from=builder /GIT/* git/
COPY --from=build1 /shree.txt code
RUN cat code







