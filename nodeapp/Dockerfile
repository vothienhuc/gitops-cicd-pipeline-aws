FROM node:18

RUN apt update 

# Create app directory
WORKDIR /nodeapp

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Start the app using server.js
CMD ["node", "server.js"]
