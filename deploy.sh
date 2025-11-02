#!/bin/bash

# Deploy script for one-percenter-svc Helm chart
# Usage: ALPHA_VANTAGE_API_KEY=your-key ./deploy.sh

set -e

# Check if ALPHA_VANTAGE_API_KEY is set
if [ -z "$ALPHA_VANTAGE_API_KEY" ]; then
    echo "Error: ALPHA_VANTAGE_API_KEY environment variable is not set"
    echo "Usage: ALPHA_VANTAGE_API_KEY=your-key ./deploy.sh"
    exit 1
fi

# Chart configuration
RELEASE_NAME="local-helm"
CHART_PATH="."
NAMESPACE="dev"

echo "Deploying $RELEASE_NAME..."
echo "Using chart: $CHART_PATH"

# Deploy with Helm
helm upgrade --install "$RELEASE_NAME" \
    --namespace "$NAMESPACE" \
    "$CHART_PATH" \
    --set secrets.alphaVantageApiKey="$ALPHA_VANTAGE_API_KEY"

echo "Deployment complete!"
echo ""
echo "To check the status:"
echo "  kubectl get pods"
echo "  kubectl get svc"
echo ""
echo "To view logs:"
echo "  kubectl logs -l app.kubernetes.io/name=local-helm"
