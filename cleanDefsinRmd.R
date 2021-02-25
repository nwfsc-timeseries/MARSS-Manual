#replace math commands with their definitions
#Why do a replacement like this? See comments below
require(stringr)
replace.defs = function(defsfile, inputfile, outputfile){
  defs=readLines(defsfile)
  content=readLines(inputfile)
  for(i in defs){
    start=str_locate(i,"newcommand[{]")[2]+1
    end=str_locate(i,"[}]")[1]-1
    tag=str_sub(i, start, end)
    tag=str_replace(tag, "\\\\","\\\\\\\\")
    start=str_locate_all(i,"[{]")[[1]][2,1]+1
    end=str_length(i)-1
    repval=str_sub(i, start, end)
    repval=str_replace_all(repval, "\\\\","\\\\\\\\")
    content=str_replace_all(content, tag, repval)
  }
  writeLines(content, outputfile)
}

basefiles=c(
  "src/01-introduction",
  "src/02-quick-start",
  "src/part2",
  "src/03-0-output",
  "src/03-1-uniss",
  "src/03-2-marss",
  "src/04-0-input",
  "src/04-1-model-list",
  "src/04-2-covariates",
  "src/05-1-output-parameters",
  "src/05-2-output-smoothed",
  "src/05-3-output-fitted",
  "src/06-residuals",
  "src/07-conf-intervals",
  "src/08-predictions",
  "src/09-troubleshooting",
  "src/10-algorithm-notes",
  "src/11-other-packages"
)
for(basefile in basefiles){
  filename=str_split(basefile,"/")[[1]][2]
  outputfile = paste("cleanedRmd/",filename,".Rmd",sep="")
  replace.defs("tex/defs.tex", paste(basefile,".Rmd",sep=""), outputfile)
}

