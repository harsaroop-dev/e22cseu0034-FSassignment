##FROM node

##WORKDIR /app

###COPY package.json /app

##COPY . /app

##RUN npm install

##EXPOSE 3000

##CMD ["npm", "start"]

## fetch node.js image from docker hub
#FROM node

#WORKDIR /app

## COPY . .
## first dot represent - source - copy all files from current location
## second dot represent - destination - paste all files in app directory

## COPY package.json /app/
## COPY server.js /app/

#COPY . /app/

#ARG NODE_ENV
#RUN if [ "$NODE_ENV" = "development" ]; \
#    then npm install; \
#    else npm install --only=production; \
#    fi

#ENV PORT 3000
#EXPOSE ${PORT}

## CMD ["node", "server.js"]
## CMD ["npm", "start"]
#CMD ["node", "server.js"]







# Use the official Node.js image from Docker Hub
FROM node

# Set the working directory inside the container to /app
WORKDIR /app

# Copy only package.json and package-lock.json first for dependency installation
# This helps with Docker caching the npm install step if no dependencies have changed.
COPY package*.json ./

# Install dependencies based on the environment (development or production)
# Ensure bcrypt is built inside the container's environment.
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
    then npm install; \
    else npm install --only=production; \
    fi

# Now copy the rest of the application files to the container
COPY . .

# Set the environment variable for the port
ENV PORT 3000

# Expose the port that the app will run on
EXPOSE ${PORT}

# Define the default command to run your application
CMD ["node", "server.js"]
