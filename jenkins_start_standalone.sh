#!/bin/bash
docker run -d -p 8081:8080 -v jenkins_standalone:/var/jenkins_home --name jenkins-standalone mkrzyzanowski/jenkins-kraqa:1.0
