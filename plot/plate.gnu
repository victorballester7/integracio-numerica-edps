set terminal pdf
# set terminal x11
# Set up the color map
set pm3d map
set palette defined (0 "white", 1 "blue", 2 "cyan", 3 "yellow", 4 "red")

# define the data file and block separator
datafile = 'data/grid.txt'

stats datafile using 1 nooutput
nblocks = STATS_blocks
print nblocks

# set margins 0,0,2,0
# set border 0
set size ratio -1 # set aspect ratio x-y to 1
set xlabel "x"
set ylabel "y"
set cbrange [0:*]
set cblabel "Temperature"

# Removes all files in the current directory
system("rm plot/Images/*")

do for [i=0:nblocks-1] {
    # Plot heatmap
    # set title sprintf("Set %d",i)
    # splot datafile using 1:2:3:4:5 index i-1 with pm3d
    set output sprintf('plot/Images/heatmap_%d.pdf', i)
    splot datafile index i with pm3d
    set output
}
### end of code