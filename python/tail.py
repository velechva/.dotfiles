#!/usr/bin/env python3

import os
import sys
import subprocess
import time
import signal

def main():
    """
    Usage:
        python tail.py <output_dir> <file1> [file2 ...]
    """
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <output_dir> <file1> [file2 ...]")
        sys.exit(1)

    output_dir = sys.argv[1]
    input_files = sys.argv[2:]

    os.makedirs(output_dir, exist_ok=True)

    processes = []

    try:
        for file_path in input_files:
            out_file_path = os.path.join(output_dir, os.path.basename(file_path))

            out_file_handle = open(out_file_path, 'ab')

            p = subprocess.Popen(
                ["tail", "-n0", "-f", file_path],
                stdout=out_file_handle,
                stderr=subprocess.DEVNULL,
            )

            processes.append((p, out_file_handle))

        print("Tailing started. Press Ctrl+C to stop.")

        while True:
            time.sleep(1)

    except KeyboardInterrupt:
        print("\nReceived Ctrl+C. Stopping all tails...")

    finally:
        for p, f_handle in processes:
            p.terminate()
            f_handle.close()

        print("All processes stopped. Exiting.")

if __name__ == "__main__":
    main()
