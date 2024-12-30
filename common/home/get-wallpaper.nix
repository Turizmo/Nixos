{ pkgs, ...}:

let
  fetchImageScript = pkgs.writeShellApplication {
    name = "fetchWallhaven";
    runtimeInputs = [ pkgs.curl pkgs.imagemagick ];
    text = ''
 #!/usr/bin/env bash

# Generate a random seed
seed=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)
echo "$seed"

search_url="https://wallhaven.cc/search?categories=101&purity=110&atleast=3440x1440&sorting=random&order=asc&colors=663399&ai_art_filter=0&seed=$seed&page=1"
pattern="https://wallhaven.cc/w/[a-z0-9]{6}"

# Fetch the webpage content
webpage_content=$(curl -s "$search_url")

# Find the first URL matching the pattern
match=$(echo "$webpage_content" | grep -oE "$pattern" | head -n 1)
echo "$match"
if [[ -n $match ]]; then
  # Extract the matched groups using substring operations
  if [[ -n $(echo "$match" | awk -F'/' '{print $5}') ]]; then
    group1=$(echo "$match" | awk -F'/' '{print substr($5, 1, 2)}')
    group2=$(echo "$match" | awk -F'/' '{print substr($5, 3, 6)}')
    wall_url="https://wallhaven.cc/w/$group1$group2"
    
    # Fetch the wall page content
    wall_page_content=$(curl -s "$wall_url")
    
    # Extract the full image URL
    image_url=$(echo "$wall_page_content" | grep -oE "https://w.wallhaven.cc/full/$group1/wallhaven-$group1$group2\.[a-z]{3}")
    echo "$image_url"
    
    if [[ -n $image_url ]]; then
      # Extract the file extension
      file_extension=$(echo "$image_url" | awk -F'.' '{print $NF}')
      echo "File extension: $file_extension"
      
      # Download the image
      image_path="$HOME/Wallpaper/wallhaven.$file_extension"
      curl -o "$image_path" "$image_url"
      echo "Image downloaded successfully: wallhaven.$file_extension"
      
      # Convert to JPG if necessary
      if [[ "$file_extension" != "jpg" ]]; then
        magick "$image_path" -quality 100 "$HOME/Wallpaper/wallhaven.jpg"
        rm "$image_path"  # Delete the original after convertion
        echo "Image converted from $file_extension to jpg"
      fi
    else
      echo "Failed to extract image URL."
    fi
  else
    echo "Failed to extract code from the URL."
  fi
else
  echo "No matching URL found."
fi
   '';
  };
in {
  home.packages = [
    fetchImageScript
  ];
}


