# ---- Build Stage ----
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the Vite React app
RUN npm run build


# ---- Production Stage ----
FROM nginx:stable-alpine

# Copy built files from build stage to Nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom Nginx config (optional, useful for React Router)
# Uncomment the next line if you have an nginx.conf file
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

