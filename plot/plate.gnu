set terminal pdf size 4,4
# set terminal x11
# Set up the color map
set pm3d map
# specify the degree of interpolation (integer from 1 (very low interpolation) to 9 (very smooth surface))
# 0,0 means that gnuplot will choose the degree of interpolation automatically
# set pm3d map interpolate 0,0

# set palette defined (0 "white", 1 "blue", 2 "cyan", 3 "yellow", 4 "red")

# define the data file and block separator
datafile = 'data/grid.txt'

stats datafile using 3 nooutput
nblocks = STATS_blocks
maxTemp=ceil(STATS_max) # round up to nearest integer of the maximum temperature in the data file (which is in the 3rd column)
# print nblocks
# print maxTemp

# set margins 0,0,0,0
# set border 0
set tmargin 0 # remove top margin
set bmargin 0 # remove bottom margin
# show margins
set size ratio -1 # set aspect ratio x-y to 1
set xlabel "x"
set ylabel "y"
set cbrange [0:maxTemp]
set cblabel "Temperatura"


set nokey # remove the key (legend), otherwise it plots some weird stuff (letters inside the plot)

do for [i=0:nblocks-1] {
  # Plot heatmap
  # add the title from the data file. The awk command prints all lines starting with # and then with the sed command we only take the i-th line
  title_line = system(sprintf("awk '/^#/{print substr($0, 3)}' %s | sed -n '%i{p;q}'", datafile,i+1))
  set title title_line

  set output sprintf('plot/Images/heatmap_%05d.pdf', i) # 05 indicates 5 digits with leading zeros. I do this because otherwise the .gif is not sorted correctly
  splot datafile index i with pm3d
  set output
}
### end of code