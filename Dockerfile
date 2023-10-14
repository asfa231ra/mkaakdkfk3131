# Use Nginx for serving the build content
FROM nginx:1.19.0-alpine

# Copy the pre-built app to nginx serve folder
COPY ./ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
