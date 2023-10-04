# Use an official Node.js runtime as a parent image
FROM --platform=linux/amd64 node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install Strapi dependencies
RUN npm install

# Copy the rest of the Strapi application source code to the container
COPY . .

# Expose the port that Strapi will run on (usually 1337)
EXPOSE 1337

CMD ["npm", "start"]
