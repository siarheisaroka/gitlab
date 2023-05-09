FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY ./02_Continuous_Delivery/html/ .
EXPOSE 80
