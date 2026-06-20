FROM node:18-alpine

WORKDIR /usr/src/app

# Copy only package.json and package-lock.json first
COPY package*.json ./

# Install dependencies, ignoring peer conflicts
RUN npm install --omit=dev --legacy-peer-deps

# Copy the rest of the application code
COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]

