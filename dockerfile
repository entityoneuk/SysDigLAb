FROM nginx:1.23.3-alpine

COPY /src/html/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

