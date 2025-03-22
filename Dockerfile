# # Use officail Golang image for building
# FROM golang:1.22.1 AS builder

# # Set working directory inside the container
# WORKDIR /app

# # Copy go.mod and go.sum first to cache dependencies
# COPY go.mod ./
# COPY go.sum ./
# RUN go mod download

# # Copy the entire source code
# COPY . .

# # Install Air for hot reloading
# RUN go install github.com/cosmtrek/air@v1.42.0


# # Final lightweight image
# FROM golang:1.22.1

# WORKDIR /app

# # Copy built files from the builder stage
# COPY --from=builder /app /app

# # Copy .env file (ensure you add `.env` to `.dockerignore` for security)
# COPY .env .env

# # Expose the port
# EXPOSE 5000

# # Run the application
# CMD ["air", "-c", "air.toml"]

# Use official Golang image for building
FROM golang:1.22.1 AS builder

WORKDIR /app

# Accept environment file as a build argument
ARG ENV_FILE

# Copy go.mod and go.sum first to cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire source code
COPY . .

# Install Air (latest compatible version)
RUN go install github.com/cosmtrek/air@v1.42.0

# Final lightweight image
FROM golang:1.22.1

WORKDIR /app

# Copy built files from the builder stage
COPY --from=builder /app /app

# Copy Air executable from the builder
COPY --from=builder /go/bin/air /usr/local/bin/air

# Set correct permissions for Air
RUN chmod +x /usr/local/bin/air


# Expose port
EXPOSE 5000

CMD ["air", "-c", "air.toml"]

# # Use official Golang image for building
# FROM golang:1.22.1 AS builder

# WORKDIR /app

# # Install Air (hot reload tool)
# RUN go install github.com/cosmtrek/air/v2@latest

# # Copy go.mod and go.sum first to cache dependencies
# COPY go.mod go.sum ./
# RUN go mod download

# # Copy the entire source code
# COPY . .

# # Final lightweight image
# FROM golang:1.22.1

# WORKDIR /app

# # Copy only the built binary from the builder stage
# COPY --from=builder /app/main /app/main

# # Copy .env file
# COPY .env .env

# # Copy Air executable
# COPY --from=builder /go/bin/air /usr/local/bin/air

# EXPOSE 5000

# CMD ["air"]


# # Use official Golang image with Go 1.23
# FROM golang:1.23 AS builder

# WORKDIR /app

# # Install Air (hot reload tool)
# RUN go install github.com/cosmtrek/air@latest


# # Copy go.mod and go.sum first to cache dependencies
# COPY go.mod go.sum ./ 
# RUN go mod download

# # Copy the entire source code
# COPY . .

# # Final lightweight image
# FROM golang:1.23

# WORKDIR /app

# # Copy only the built binary from the builder stage
# COPY --from=builder /app/main /app/main

# # Copy .env file
# COPY .env .env

# # Copy Air executable
# COPY --from=builder /go/bin/air /usr/local/bin/air

# EXPOSE 5000

# CMD ["air"]
