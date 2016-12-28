# Android Image Slicer
Android Image Slicer (AIS) is a simple Ruby script to slice images as Android drawable.

# Dependencies:
This script requires: **ruby** and **imageMagick**. It also requires the following ruby gems:

- rubygems
- RMagick
- json
- rest-client

# Usage
Put all image files in the same folder and run the following command:

`ruby /path/to/file/air.rb ~/path/to/image/folder/`

The AIS will create the drawable folders, resize all images according to dpi proportion and create a new resized image in each folder.

# Accepted Formats
This script supports only .jpg and .png files.
