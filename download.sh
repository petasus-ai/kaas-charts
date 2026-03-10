#!/bin/bash

DEST_DIR="./charts"

# List of Helm chart URLs to download
# Add or remove chart names in this array as needed
CHART_URLS=(
    "oci://quay.io/kubermatic/helm-charts/kubelb-manager --version=v1.3.4"
    "oci://quay.io/kubermatic/helm-charts/kubelb-ccm --version=v1.3.4"
)


# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
fi

echo "Starting bulk download..."
echo "------------------------------------------------"

# Iterate through the array and pull each chart
for chart in "${CHART_URLS[@]}"; do
    echo "[Processing] Pulling chart: $chart"

    # Execute helm pull
    # The --destination flag ensures all .tgz files are saved in the specific folder
    helm pull ${chart} --destination "$DEST_DIR"

    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "[Success] Downloaded $chart to $DEST_DIR"
    else
        echo "[Error] Failed to pull $chart"
    fi
    echo "------------------------------------------------"
done

echo "Bulk download process completed."
ls -lh "$DEST_DIR"
