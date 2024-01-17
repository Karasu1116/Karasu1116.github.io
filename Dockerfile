# Use the node:10-alpine image as a base to
# create a directory for the app and its node_modules with node as its owner
# install all packages in package.json
# expose port 8080 and run the app
# the docker lecture will help you complete this file 
# there should be a total of 9-12 lines

#Specifies the base image for your Docker image. 
#In this case, node:10-alpine is a lightweight version of the Node.js 10 image.
FROM node:10-alpine

#Executes shell commands in the container. 
#Here, it creates a directory /home/node/app and sets its owner to the node user.
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app

#Sets the working directory for the subsequent Dockerfile commands.
WORKDIR /home/node/app

#Copies package.json and package-lock.json (if available) from your project directory 
#into the container.
COPY package*.json ./

#Switches to the node user for security purposes.
USER node

#Installs the dependencies defined in package.json.
RUN npm install

#Informs Docker that the container listens on port 8080 at runtime.
EXPOSE 8080

#Copies your app's source code into the container, setting the node user as the owner.
COPY --chown=node:node . .

#Specifies the command to run the app. In this case, it's starting a Node.js app.
CMD node app.js