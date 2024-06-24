# set the base image to create the image for react app
FROM node:20-alpine

# set the user to run the app
RUN adduser -S app

# Create the /app directory and change its ownership
RUN mkdir -p /app && chown app /app

# set the working directory to /app
WORKDIR /app

# copy package.json and package-lock.json to the working directory
# This is done before copying the rest of the files to take advantage of Docker's
# cache
# If the package.json and package-lock.json files haven't changed, Docker will use 
# use cached dependencies.
COPY package*.json ./

RUN npm install

COPY . ./

RUN npm run build

# expose port 8080 to tell Docker that the contained listnes on the specified
# network ports at runtime
EXPOSE 8080

CMD ["npm", "run", "preview"]

