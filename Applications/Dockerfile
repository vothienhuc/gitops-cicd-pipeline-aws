FROM node:alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .
RUN  echo "Running "
# Expose the application's port
EXPOSE 3000

# Define the command to run your app
CMD ["node", "index.js"]
