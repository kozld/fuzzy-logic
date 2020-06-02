FROM node:13.12 as build-stage

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY app .
RUN npm run build

# production stage
FROM nginx:1.17-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]