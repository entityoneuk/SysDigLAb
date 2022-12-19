FROM nginx:1.23.3-alpine
COPY /GitHub/SysDigLAb/src/html/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

