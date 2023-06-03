echo "Creating plots..."
# Remove all previous plots
rm plot/Images/*.pdf plot/Images/animation_jpg/*.jpg plot/*.gif

gnuplot -p plot/plate.gnu
if [ $? -eq 0 ]; then
  echo "Plots created successfully!"
else
  echo "Error creating plots"
  exit 1
fi
cd plot/Images/
# convert all .pdf files to .jpg
echo "Converting images from pdf to jpg..."
num_images=$(ls -l | grep -c '.pdf')
echo "Found $num_images images"
for f in *.pdf; do
# change the DPI number for resolution of the image: 100 (very low resolution) ---- 1000 (very high resolution)
  magick convert -density 300 "$f" "animation_jpg/${f%.pdf}.jpg";
  if [ $? -eq 0 ]; then
    echo "Converted ${f%.pdf}.pdf to animation_jpg/${f%.pdf}.jpg"
  else
    echo "Error converting ${f%.pdf}.pdf to animation_jpg/${f%.pdf}.jpg"
    exit 1
  fi
done
cd ../..
echo "Done!"
echo "Creating animation..."
# Creates a gif from a series of jpg files
# -delay X: delay between frames in 1/100th of a second (e.g. X = centiseconds)
convert -delay 5 -loop 0 plot/Images/animation_jpg/*.jpg plot/animation.gif 
if [ $? -eq 0 ]; then
  echo "Animation created successfully"
else
  echo "Error creating animation"
  exit 1
fi