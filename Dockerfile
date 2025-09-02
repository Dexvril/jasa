# Gunakan image node untuk build
FROM node:20 AS builder

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Gunakan image nginx untuk serve static files
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY static/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]