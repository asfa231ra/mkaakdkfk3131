# Stage 1
# Use an official Node runtime as the parent image
FROM node:latest as build-stage

# Set the working directory in the container to /app
WORKDIR /app

# Add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install any needed packages
RUN npm install

# Bundle app source
COPY . .

# Build app for production
RUN npm run build

# Stage 2
# Use Nginx for serving the build content
FROM nginx:1.19.0-alpine as production-stage

# Copy built app to nginx serve folder
COPY --from=build-stage /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
