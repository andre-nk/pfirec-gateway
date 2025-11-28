FROM devopsfaith/krakend:2.5

# Install envsubst
USER root
RUN apk add --no-cache gettext

# Copy configuration template
COPY krakend.json /etc/krakend/krakend.json.template

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/__health || exit 1

# Run KraKend with env var substitution
# We explicitly list variables to avoid replacing things like $schema
CMD ["/bin/sh", "-c", "envsubst '${TASK_MANAGER_HOST} ${CLERK_JWK_URL} ${CLERK_ISSUER}' < /etc/krakend/krakend.json.template > /etc/krakend/krakend.json && krakend run -c /etc/krakend/krakend.json"]
