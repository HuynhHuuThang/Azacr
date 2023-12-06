FROM node:16-alpine as build

WORKDIR /usr/src/app/

ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY ./package.json ./


RUN yarn 
RUN yarn config set unsafe-perm true

COPY . /usr/src/app/



RUN yarn build:demo:dev

# production environment
FROM nginx:stable-alpine


COPY --from=build /usr/src/app/build/demo_dev /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]