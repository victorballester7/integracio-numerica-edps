set term gif animate delay 100 optimize size 800,600 background "white"
set output "heatmap.gif"

# Set up the color map
set pm3d map
set palette defined (0 "white", 1 "blue", 2 "green", 3 "yellow", 4 "red")

# Set the x and y ranges
set xrange [0:0.5]
set yrange [0:0.5]

# Set the labels for the x and y axes and the color bar
set xlabel "X"
set ylabel "Y"
set cbrange [0:*]
set cblabel "Value"

# define the data file and block separator
datafile = 'data/grid.txt'

stats datafile using 2:3 nooutput
nblocks = STATS_blocks

# Loop through each time step in the file
do for [i=0:nblocks-1] {
       # Skip comments and empty lines
    # stats datafile every :::i::i using 1:2:3 nooutput
    # if (STATS_records == 0) { next }

    # Set title and output file name
    title_str = sprintf('Data block %d', i)
    out_file = sprintf('heatmap_%d.png', i)

    # Plot heatmap
    set title title_str
    set output out_file
    splot datafile every ::2 with pm3d notitle
}
