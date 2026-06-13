import datetime
import sys
import os
import subprocess
import platform
import base64

def usage():
    pass

def image_to_data_url(image_path):
    with open(image_path, "rb") as image_file:
        encoded_string = base64.b64encode(image_file.read()).decode("utf-8")
        
    if image_path.lower().endswith(('.png')):
        mime = "image/png"
    elif image_path.lower().endswith(('.jpg', '.jpeg')):
        mime = "image/jpeg"
    elif image_path.lower().endswith(('.gif')):
        mime = "image/gif"
    elif image_path.lower().endswith(('.webp')):
        mime = "image/webp"
    else:
        mime = "image/octet-stream"
    
    return f"data:{mime};base64,{encoded_string}"

def sys_create_file(filename, insert_string):
    try:
        with open(filename, "w", encoding="utf-8") as f:
            f.write(insert_string)
    except PermissionError:
        print(f"Error: Permission denied. Cannot write to file '{filename}'.", file=sys.stderr)
        sys.exit(1)
    except OSError as e:
        print(f"Error: Operating system error while creating file: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: Unexpected error occurred: {e}", file=sys.stderr)
        sys.exit(1)

def main():
    print()

