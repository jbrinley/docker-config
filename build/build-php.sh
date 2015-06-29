#!/bin/bash

docker build -t jbrinley/php:5.6-apache php/5.6-apache
docker build -t jbrinley/php:5.6-fpm php/5.6-fpm
docker build -t jbrinley/php:5.5-apache php/5.5-apache
docker build -t jbrinley/php:5.5-fpm php/5.5-fpm
docker build -t jbrinley/php:5.4-apache php/5.4-apache
docker build -t jbrinley/php:5.4-fpm php/5.4-fpm
docker build -t jbrinley/php:5.3-fpm php/5.3-fpm
docker build -t jbrinley/php:5.2-fpm php/5.2-fpm