#building 1st intermediate fedora image as builder 

FROM fedora:latest AS builder
#pulling fedora image
RUN mkdir GIT  && \
    sudo yum install git -y
WORKDIR GIT       # set the working dir GIT
RUN git init && \
    git clone https://github.com/Tej-Singh-Rana/Class-test.git && \
    mkdir /key
#copy file from base machine inside container
COPY shree.py /key

#building 2nd alpine image as build1

FROM alpine:latest AS build1
RUN apk add python3        #installing python3 pkg
COPY --from=builder /key/shree.py /        #importing shree.py from builder
WORKDIR /  
RUN python3 shree.py >>shree.txt

#building final alpine image as build2 
FROM alpine:latest AS build2
WORKDIR /root/
RUN mkdir git && \
    touch code
#importing files & dir from 1st and 2nd image 
COPY --from=builder /GIT/* git/
COPY --from=build1 /shree.txt code
RUN cat code







