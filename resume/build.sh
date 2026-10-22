#!/usr/bin/env bash
set -euo pipefail

resume_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
site_dir="$(cd "$resume_dir/.." && pwd)"
source_file="$resume_dir/resume.html"
output_file="$site_dir/Purva_Chiniya_Resume.pdf"

if [[ -n "${CHROME_BIN:-}" ]]; then
  chrome="$CHROME_BIN"
elif command -v google-chrome >/dev/null 2>&1; then
  chrome="$(command -v google-chrome)"
elif command -v chromium >/dev/null 2>&1; then
  chrome="$(command -v chromium)"
elif [[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]]; then
  chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
  echo "Chrome or Chromium is required. Set CHROME_BIN to its executable path." >&2
  exit 1
fi

"$chrome" \
  --headless \
  --disable-gpu \
  --no-first-run \
  --no-default-browser-check \
  --no-pdf-header-footer \
  --print-to-pdf="$output_file" \
  "file://$source_file"

echo "Built $output_file"
