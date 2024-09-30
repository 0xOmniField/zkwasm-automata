# Use the official Rust image from the Docker Hub
FROM rust:latest
# Install Node.js 18.6
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs=18.6.0-1nodesource1

# Install Git
RUN apt-get update && apt-get install -y git

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    pkg-config \
    libssl-dev \
    libclang-dev \
    curl

# Install supervisor
RUN apt-get update && apt-get install -y supervisor && apt-get clean


# Set the working directory inside the container
WORKDIR /usr/src/

# Clone the GitHub repository
RUN git clone https://github.com/DelphinusLab/zkwasm-typescript-mini-server

WORKDIR /usr/src/zkwasm-typescript-mini-server/dbservice

# Build the application
RUN cargo build --release

# Set the working directory inside the container
WORKDIR /usr/src/zkwasm-typescript-mini-server

RUN  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# Set the working directory inside the container
WORKDIR /usr/src/zkwasm-typescript-mini-server

COPY . zkwasm-automata

WORKDIR /usr/src/zkwasm-typescript-mini-server/zkwasm-automata/ts

RUN npm install

WORKDIR /usr/src/zkwasm-typescript-mini-server/zkwasm-automata

RUN  ls && make

WORKDIR /usr/src/zkwasm-typescript-mini-server

# Create the supervisor configuration directory
RUN mkdir -p /etc/supervisor/conf.d
RUN cp zkwasm-automata/deploy/supervisord.conf /etc/supervisor/supervisord.conf
RUN cp zkwasm-automata/deploy/start.sh ./start.sh

RUN cp -R zkwasm-automata/ts ./zkwasm-ts-server

EXPOSE 3000

# Run the application
CMD ["sh", "start.sh"]
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

