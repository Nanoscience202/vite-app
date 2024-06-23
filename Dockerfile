# set the base image to create the image for react app
FROM node:20-alpine

# set the user to run the app
USER app

# set the working directory to /app
WORKDIR /app

# copy package.json and package-lock.json to the working directory
# This is done before copying the rest of the files to take advantage of Docker's
# cache
# If the package.json and package-lock.json files haven't changed, Docker will use 
# use cached dependencies.
COPY package*.json ./

USER app

RUN npm install

COPY . ./

# expose port 8080 to tell Docker that the contained listnes on the specified
# network ports at runtime
EXPOSE 5173

CMD ["npm", "run", "dev"]

