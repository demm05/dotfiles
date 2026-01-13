import os
import sys
from pathlib import Path

import requests


def create_desktop_file(app_name, app_path):
    # 1. Setup Paths
    home = Path.home()
    desktop_dir = home / ".local/share/applications"
    icon_dir = home / ".local/share/icons"
    desktop_dir.mkdir(parents=True, exist_ok=True)
    icon_dir.mkdir(parents=True, exist_ok=True)

    app_path = os.path.abspath(app_path)
    icon_path = icon_dir / f"{app_name}.png"

    # 2. Try to fetch an icon (Simple search logic)
    print(f"Searching for icon for {app_name}...")
    # Using a public icon API or a direct search
    icon_url = (
        f"https://dashboard.snapcraft.io/site_media/appicons/default/48/{app_name}.png"
    )

    try:
        r = requests.get(icon_url, timeout=5)
        if r.status_code == 200:
            with open(icon_path, "wb") as f:
                f.write(r.content)
            print(f"Successfully downloaded icon to {icon_path}")
        else:
            # Fallback to a generic developer icon
            icon_path = "utilities-terminal"
    except:
        icon_path = "utilities-terminal"

    # 3. Create the .desktop content
    content = f"""[Desktop Entry]
Type=Application
Version=1.0
Name={app_name.capitalize()}
Comment=Installed via Pixi
Exec={app_path} %F
Icon={icon_path}
Terminal=true
Categories=Development;TextEditor;
"""

    file_path = desktop_dir / f"{app_name}.desktop"
    with open(file_path, "w") as f:
        f.write(content)

    os.chmod(file_path, 0o755)
    print(f"\nSUCCESS: Created {file_path}")
    print(f"You can now find '{app_name}' in your application launcher.")


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python app-gen.py <app_name> <path_to_binary>")
        sys.exit(1)

    create_desktop_file(sys.argv[1], sys.argv[2])
