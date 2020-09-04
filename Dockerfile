FROM golang:1.15.1-buster

RUN apt-get update && apt-get install -y autoconf libtool softhsm2 opensc

WORKDIR /workspace

RUN git clone https://github.com/opendnssec/pkcs11-testing.git

WORKDIR /workspace/pkcs11-testing

RUN chmod +x autogen.sh && \
    ./autogen.sh && \
    ./configure --disable-dependency-tracking && \
    make install 

WORKDIR /go

RUN rm -rf /workspace

RUN go get github.com/miekg/pkcs11

WORKDIR /workspace

COPY . .

RUN cd pkcs11mod && make all && cd ..

RUN CGO_ENABLED=1 go build -buildmode c-shared -o libmypkcs11module.so main.go

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]