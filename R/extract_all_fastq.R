extract_all_fastq <- function(fast5dir,prefix){
  files <- list.files(fast5dir,full.names=TRUE)
  files <- files[grep("\\.fast5$",files)]
  n <- length(files)
  fastq <- paste0(prefix,".fastq")
  info <- paste0(prefix,"_info.tsv")
  fastq_file <- file(fastq,"w")
  info_file <- file(info,"w")
  for(i in 1:n){
    cat(i,"/",n,"\n")
    junk <- extract_fastq(files[i])
    if(!is.null(junk)){
      filename <- gsub("^@","",unlist(strsplit(junk$fastq," "))[1])
      cat(junk$fastq,file=fastq_file)
      cat(paste0(paste(c(basename(files[i]),filename,junk$chr,junk$start,junk$end,junk$strand),collapse="\t"),"\n"),file=info_file)
    }
  }
  close(fastq_file)
  close(info_file)
}
