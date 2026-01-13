# Use a specific Node.js version based on an argument, 
# defaulting to 24.12.0 which is an LTS version as Jan 2026
ARG NODE_VERSION=24.12.0
FROM node:${NODE_VERSION}-alpine

# Every command will be run inside this folder
WORKDIR /usr/src/app

# Copy only package files first (to leverage Docker cache)
COPY package*.json ./

# Install dependencies
RUN npm install

# Run the application as a non-root user
USER node

# COPY <source> <destination>
# source → project root on your host
# destination → /usr/src/app (WORKDIR)
# “Copy everything from the build context into the working directory”
COPY . .

# Sets the environment variable we'll use in our application
ENV PORT=3000

# Expose the port that the application listens on.
# This is just for documentation, this actually does not publish the port
EXPOSE 3000
# To publish the port when running the container, use the -p flag:
# docker run -p 3000:3000 <image-name> or using docker-compose.yml

# Run the application.
CMD ["npm", "start"]
