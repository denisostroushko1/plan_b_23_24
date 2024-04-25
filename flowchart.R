
library(DiagrammeR)
library(DiagrammeRsvg)

flowchart <- 
  grViz(" 
 
digraph flowchart {

# Graph style 
graph [layout = dot, fontsize = 35, overlap = true
] 
node [shape = box, fontsize = 35, overlap = true] 
edge [arrowhead = vee, fontsize = 35, overlap = true, style = filled, fillcolor = Linen, minlen = 3] 

# Nodes 
start   [label='20,121 Patients with Unspecified Mental Disorder, \nMCI, or AD identified from Fairview EHR \nbetween 2004 and 2020'] 
filter1 [label='9,286 patients with AD only removed']
filter1_res [label='10,835 Remain']
filter2 [label='332 Patients with Other Dimentia removed']
cohort1 [label='Cohort 1: 10,503 Remain']

cohort_1_to_2 [label='407 patients with AD before \nMCI or Unspecified Diagnosis removed']
cohort2 [label='Cohort 2: 10,096 Patients']

cohort_2_to_3 [label='3,528 patients with only one MCI or \nUnspecified Diagnosis removed; 
                      \nall patients have at least two diagnoses\n either two MCI or one of AD and MCI']
cohort3[label ='Cohort 3: 6,568 Patients Remain']

cohort_3_to_4 [label='857 patients below the age of 50 removed']
cohort4[label ='Cohort A: 5,711 Patients Remain']

cohort_4_to_5 [label='2,904 of non-progressing patients with MCI diagnosis\n spanning less than 50 days removed; 
                      \ncriteria did not apply to those who progressed to AD']
cohort5[label ='Cohort B: 2,807 Patients Remain']

cohort_5_to_6 [label='372 patients removed when criteria \nof at least two MCI diagnoses over \nthe span of at least 50 days applied to everyone']
cohort6[label = 'Cohort C: 2,435 patients remain', fillcolor = 'Red']

# Edges 
start -> filter1
filter1 -> filter1_res
filter1_res -> filter2 
filter2 -> cohort1
  {rank = same; filter2; cohort1}
filter2 -> cohort_1_to_2
cohort_1_to_2 -> cohort2
  {rank = same; cohort_1_to_2; cohort2}
cohort_1_to_2 -> cohort_2_to_3
cohort_2_to_3 -> cohort3
  {rank = same; cohort_2_to_3; cohort3}
cohort_2_to_3 -> cohort_3_to_4
cohort_3_to_4 -> cohort4 
  {rank = same; cohort_3_to_4; cohort4}
cohort_3_to_4 -> cohort_4_to_5
cohort_4_to_5 -> cohort5
  {rank = same; cohort_4_to_5; cohort5}
cohort_4_to_5 -> cohort_5_to_6
cohort_5_to_6 -> cohort6
  {rank = same; cohort_5_to_6; cohort6}

# A note at the bottom 
labelloc = 'b'  }
s
        ", 
    
    engine = 'dot'
  ) 

flowchart

# # Write the SVG content to a file
svg <- export_svg(flowchart) 
svg_file <- "flowchart.svg"
writeLines(svg, con = svg_file)

# Convert SVG to PNG
png_file <- "flowchart.png"
rsvg::rsvg_png(svg_file, png_file)

