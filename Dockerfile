# Use an official Node.js runtime as a parent image
FROM node:20

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and yarn.lock if they exist
COPY package.json yarn.lock* ./

# Install Yarn if it's not already installed
RUN command -v yarn >/dev/null 2>&1 || { \
    curl -o- -L https://yarnpkg.com/install.sh | bash \
    && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"; \
}

# Install app dependencies using yarn
RUN yarn install

# Copy the rest of the application code into the container
COPY . .

# For production build
RUN yarn build

# Command to run the application
CMD [ "yarn", "start" ]
