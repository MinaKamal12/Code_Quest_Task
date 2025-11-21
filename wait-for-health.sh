#!/bin/sh
# Usage: ./wait-for-health.sh <service_name> <port> <timeout_seconds>
set -e

SERVICE_NAME=$1
PORT=$2
TIMEOUT=${3:-60}
COUNTER=0

echo "Waiting for $SERVICE_NAME to be ready..."

# Function to check if service is reachable
check_service() {
    case $SERVICE_NAME in
        postgres)
            # Check PostgreSQL with pg_isready
            PGPASSWORD=admin pg_isready -h "$SERVICE_NAME" -U admin -d votes -t 1 >/dev/null 2>&1
            ;;
        redis)
            # Check Redis with redis-cli ping
            redis-cli -h "$SERVICE_NAME" ping >/dev/null 2>&1
            ;;
        vote|result)
            # Check HTTP services with curl or wget
            if command -v curl >/dev/null 2>&1; then
                curl -sf "http://$SERVICE_NAME:$PORT/health" >/dev/null 2>&1
            elif command -v wget >/dev/null 2>&1; then
                wget -q -O /dev/null "http://$SERVICE_NAME:$PORT/health" 2>&1
            else
                # Fallback to nc (netcat) for basic connectivity
                nc -z "$SERVICE_NAME" "$PORT" >/dev/null 2>&1
            fi
            ;;
        *)
            # Generic TCP check with nc
            nc -z "$SERVICE_NAME" "$PORT" >/dev/null 2>&1
            ;;
    esac
}

while [ $COUNTER -lt $TIMEOUT ]; do
    if check_service; then
        echo "$SERVICE_NAME is ready!"
        exit 0
    fi
    sleep 2
    COUNTER=$((COUNTER + 2))
done

echo "Timed out waiting for $SERVICE_NAME to be ready"
exit 1