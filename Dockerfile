FROM --platform=linux/amd64 quay.io/keycloak/keycloak:25.0.4

# Copy the custom theme into the container
COPY themes/custom-theme/theme /opt/keycloak/themes/

# Build Keycloak with MySQL driver support
RUN /opt/keycloak/bin/kc.sh build --db mysql

# Set the working directory
WORKDIR /opt/keycloak

# Use the provided entrypoint
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]



