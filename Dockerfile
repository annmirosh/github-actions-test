# Use an official Node.js image as the base image
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install 

# Copy the entire project to the working directory
COPY . .

# Build the React app
RUN npm run build

# Use NGINX as the production server
FROM nginx:alpine

# Copy the built React app from the 'build' directory to NGINX's public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
