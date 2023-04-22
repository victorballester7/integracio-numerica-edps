echo "Creating plots..."
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
for f in *.pdf; do
# change the DPI number for resolution of the image: 100 (very low resolution) ---- 1000 (very high resolution)
  magick convert -density 300 "$f" "${f%.pdf}.jpg";
  if [ $? -eq 0 ]; then
    echo "Converted ${f%.pdf}.pdf to ${f%.pdf}.jpg"
  else
    echo "Error converting ${f%.pdf}.pdf to ${f%.pdf}.jpg"
    exit 1
  fi
done
cd ../..
echo "Done!"
echo "Creating animation..."
# Creates a gif from a series of jpg files
convert -delay 100 -loop 0 plot/Images/*.jpg plot/animation.gif
if [ $? -eq 0 ]; then
  echo "Animation created successfully"
else
  echo "Error creating animation"
  exit 1
fi