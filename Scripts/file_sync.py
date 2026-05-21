import os
import shutil
import sys
import time

def get_file_list(folder_path):
    """
    Traverse a directory and return a list of files with their relative paths.
    """
    file_list = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            abs_path = os.path.join(root, file)
            rel_path = os.path.relpath(abs_path, folder_path)
            file_list.append((rel_path, abs_path))
    return file_list

def compare_folders(source, dest):
    """
    Compare files in Source (A) vs Destination (B).
    Returns a list of tuples: (source_full_path, dest_full_path, reason)
    """
    tasks = []
    
    for root, dirs, files in os.walk(source):
        rel_path = os.path.relpath(root, source)
        
        dest_dir = os.path.join(dest, rel_path)
        
        for filename in files:
            src_file = os.path.join(root, filename)
            dst_file = os.path.join(dest_dir, filename)
            
            if not os.path.exists(dst_file):
                tasks.append((src_file, dst_file, "NEW FILE"))
            
            else:
                src_mtime = os.path.getmtime(src_file)
                dst_mtime = os.path.getmtime(dst_file)
                
                if src_mtime > dst_mtime + 1:
                    tasks.append((src_file, dst_file, "UPDATE (Source is newer)"))

    return tasks

def main():
    print("------------------------------------------------")
    print("   FILE DIFFERENCE MANAGER (One-way Sync)")
    print("------------------------------------------------")
    
    while True:
        path_a = input("Enter Source Folder Path (A): ").strip()
        if os.path.isdir(path_a):
            break
        print("[!] Error: Path A does not exist or is not a directory. Please try again.")

    while True:
        path_b = input("Enter Destination Folder Path (B): ").strip()
        if not os.path.exists(path_b):
            create = input(f"Path B does not exist. Create it? (y/n): ").lower()
            if create == 'y':
                try:
                    os.makedirs(path_b)
                    break
                except OSError as e:
                    print(f"[!] Error creating directory: {e}")
            else:
                continue
        elif os.path.isdir(path_b):
            break
        else:
            print("[!] Error: Path B is a file, not a directory.")

    print("\nScanning directories... Please wait.")
    
    sync_tasks = compare_folders(path_a, path_b)

    if not sync_tasks:
        print("\n[OK] No differences found. Folder B is up to date with Folder A.")
        sys.exit(0)

    print(f"\nFound {len(sync_tasks)} file(s) in A that need to be copied to B:")
    print("-" * 60)
    for src, dst, reason in sync_tasks:
        print(f"[{reason}] {os.path.basename(src)}")
        print(f"    From: {src}")
        print(f"    To:   {dst}")
    print("-" * 60)

    confirm = input(f"\nProceed with copying {len(sync_tasks)} files? (y/n): ").lower()
    
    if confirm != 'y':
        print("Operation cancelled by user.")
        sys.exit(0)

    print("\nStarting copy process...")
    success_count = 0
    error_count = 0

    for src, dst, reason in sync_tasks:
        try:
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            
            shutil.copy2(src, dst)
            print(f"[DONE] {os.path.basename(src)}")
            success_count += 1
        except Exception as e:
            print(f"[FAIL] Could not copy {os.path.basename(src)}")
            print(f"       Reason: {e}")
            error_count += 1

    print("\n------------------------------------------------")
    print("SUMMARY")
    print(f"Total Processed: {len(sync_tasks)}")
    print(f"Successful:      {success_count}")
    print(f"Failed:          {error_count}")
    print("------------------------------------------------")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nScript interrupted by user. Exiting.")
        sys.exit(0)

