# ------------------------------------------------------------------------------
# Start with the base image
# ------------------------------------------------------------------------------

FROM phusion/baseimage:0.9.19

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Use Supervisor to run and manage all other services
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# ------------------------------------------------------------------------------
# Provision the server
# ------------------------------------------------------------------------------

# Copy data
COPY provision /provision
COPY app /app

# Set up and install
RUN chmod 755 /provision/bin/setup.sh
RUN /provision/bin/setup.sh

# Expose ports
EXPOSE 80