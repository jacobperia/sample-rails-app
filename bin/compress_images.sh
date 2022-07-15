
for f in $(find ../app/assets/images/ -type f -name '*.jpg')
do
  echo "Converting: $f"
  convert $f -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB $f
done

for f in $(find ../app/assets/images/ -type f -name '*.jpeg')
do
  echo "Converting: $f"
  convert $f -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB $f
done

for f in $(find ../app/assets/images/ -type f -name '*.png')
do
  echo "Converting: $f"
  convert $f -strip $f
done