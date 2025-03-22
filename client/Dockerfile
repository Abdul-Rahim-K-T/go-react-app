# # Use Node.js to build the frontend
# FROM node:18-alpine AS builder

# # Set the working directory
# WORKDIR /app

# # Copy package.json and install dependencies
# COPY package.json package-lock.json ./
# RUN npm install

# # Copy the source code
# COPY . .

# # Build the React app
# RUN npm run build

# # Use a lightweight web Nginx to serve the frontend
# FROM nginx:alpine AS production

# # Set the working directory
# WORKDIR /usr/share/nginx/html

# # Remove the default nginx index page
# RUN rm -rf ./*

# # Copy a custom Nginx 
# COPY --from=build /app/dist .

# # Copy the built files from the previous stage
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Expose the Nginx port
# EXPOSE 80

# # Start Nginx 
# CMD ["nginx", "-g", "daemon off;"]

# Use Node.js to build the frontend
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package.json and install dependencies using npm ci (faster & stable)
COPY package.json package-lock.json ./
RUN npm ci

# Copy the source code
COPY . .

# Build the React app
RUN npm run build

# Use a lightweight Nginx to serve the frontend
FROM nginx:alpine AS production

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy the built files from the previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom Nginx config
COPY cleint/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
