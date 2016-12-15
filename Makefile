all:
	make build && make run && make copy && make stop && make rm && make rmi

build:
	docker build --build-arg RUBY_VERSION=${RUBY_VERSION} -t build-ruby-centos:${RUBY_VERSION} .

run:
	docker run -dit build-ruby-centos:${RUBY_VERSION} > build-container.pid

copy:
	docker cp `cat build-container.pid`:/usr/local/ruby-${RUBY_VERSION}.tar.gz ./blob/ruby-${RUBY_VERSION}.tar.gz

stop:
	docker stop `cat build-container.pid`

rm:
	docker rm `cat build-container.pid` && rm build-container.pid

rmi:
	docker rmi build-ruby-centos:${RUBY_VERSION}
