fROM node:14.17.1 as build
WORKDIR /app
COPY package.json ./
RUN npm install --ignore-engines
COPY . ./
RUN npm run build

FROM nginx:1.21-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
