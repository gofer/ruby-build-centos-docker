FROM centos:latest

MAINTAINER Gofer (@gofer_ex) <gofer@ex-studio.info>

ARG RUBY_VERSION=2.3.3

RUN yum -y install make git gcc
RUN yum -y install gdbm openssl readline zlib
RUN yum -y install gdbm-devel openssl-devel readline-devel zlib-devel

WORKDIR /usr/local/src
RUN curl -O https://cache.ruby-lang.org/pub/ruby/`echo $RUBY_VERSION | sed -E 's/([0-9]+)\.([0-9]+)\.([0-9]+)/\1\.\2/g'`/ruby-$RUBY_VERSION.tar.gz && tar xf ruby-$RUBY_VERSION.tar.gz
WORKDIR /usr/local/src/ruby-$RUBY_VERSION
RUN ./configure --prefix=/usr/local/ruby --libdir=/usr/local/ruby/lib64 --enable-shared --enable-pthread && make && make install

WORKDIR /usr/local/ruby
RUN mv ./share ../ruby-share

WORKDIR /usr/local
RUN tar cfz ruby-$RUBY_VERSION.tar.gz ./ruby/

WORKDIR /

ENTRYPOINT /bin/bash
