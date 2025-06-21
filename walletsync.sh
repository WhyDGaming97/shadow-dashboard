#!/bin/bash

WATCH_FILE="/opt/shadowshell/data/data.json"
OUTPUT_FILE="/opt/shadowshell/exports/wallets.md"

echo "[*] Monitoring: $WATCH_FILE"

last_checksum=""

while true; do
  if [[ -f "$WATCH_FILE" ]]; then
    new_checksum=$(md5sum "$WATCH_FILE")

    if [[ "$new_checksum" != "$last_checksum" ]]; then
      echo "[+] Detected change. Updating wallets.md..."
      last_checksum="$new_checksum"

      echo "# 🧠 Wallets Sync Report" > "$OUTPUT_FILE"
      echo "Last updated: $(date)" >> "$OUTPUT_FILE"
      echo -e "\n\`\`\`json" >> "$OUTPUT_FILE"
      cat "$WATCH_FILE" >> "$OUTPUT_FILE"
      echo -e "\n\`\`\`" >> "$OUTPUT_FILE"

      echo "[✓] Synced to $OUTPUT_FILE"
    fi
  fi
  sleep 2
done

