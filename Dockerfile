FROM devopsfaith/krakend:2.5

# Copy configuration
COPY krakend.json /etc/krakend/krakend.json

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/__health || exit 1

# Run KraKend
CMD ["run", "-c", "/etc/krakend/krakend.json"]
