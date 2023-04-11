fROM node:13.12.0-alpine as build
WORKDIR /app
COPY package.json ./
RUN yarn install --ignore-engines
COPY . ./
RUN yarn run build --ignore-engines

FROM nginx:1.21-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
