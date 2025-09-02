# Gunakan image Bun untuk build
FROM oven/bun:1.1.13 AS builder

WORKDIR /app
COPY . .
RUN bun install
RUN bun run build

# Gunakan image nginx untuk serve static files
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY static/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]