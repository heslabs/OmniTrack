#!/usr/bin/env bash

cp -f runtime-jpg.toml ./config/runtime.toml

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export QNN_SDK_ROOT="${QNN_SDK_ROOT:-${HERE}}"
export QNN_LIB_DIR="${QNN_LIB_DIR:-${HERE}/lib/aarch64-ubuntu-gcc9.4}"
export LD_LIBRARY_PATH="${QNN_LIB_DIR}:${LD_LIBRARY_PATH:-}"
export ADSP_LIBRARY_PATH="${QNN_LIB_DIR}:/dsp"
export DSP_LIBRARY_PATH="${QNN_LIB_DIR}"

LOG="${HERE}/demo.log"
# Truncate the log so we never match a "threads up" line from a previous run.
: > "$LOG"

"${HERE}/omnitrack_runtime" --config "${HERE}/config/runtime.toml" "$@" >> "$LOG" 2>&1 &
TRACKER_PID=$!

# Poll the log until the runtime signals all threads are up and the UDP
# init listener is bound — then immediately send the init bbox.
until grep -q "\[runtime\] all threads up" "$LOG" 2>/dev/null; do
    sleep 0
done

cd /home/deepmentor/sandbox/omnitrack_client
# by pass top-left x y w h not cx cy
python send_init.py 127.0.0.1 5005 546 463 79 53
wait "$TRACKER_PID"
