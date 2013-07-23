# Copyright 2013 Prometheus Team
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

all: cpp go java python

SUFFIXES:

cpp: cpp/metrics.pb.cc cpp/metrics.pb.h

cpp/metrics.pb.cc: metrics.proto
	protoc $< --cpp_out=cpp/

cpp/metrics.pb.h: metrics.proto
	protoc $< --cpp_out=cpp/

go: go/metrics.pb.go

go/metrics.pb.go: metrics.proto
	protoc $< --go_out=go/

java: src/main/java/io/prometheus/client/Metrics.java pom.xml
	mvn clean compile package

src/main/java/io/prometheus/client/Metrics.java: metrics.proto
	protoc $< --java_out=src/main/java

python: python/metrics_pb2.py

python/metrics_pb2.py: metrics.proto
	protoc $< --python_out=python/

clean:
	-rm -rf cpp/*
	-rm -rf go/*
	-rm -rf java/*
	-rm -rf python/*
	-mvn clean

.PHONY: all clean cpp go java python
