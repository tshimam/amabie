extract_fastq <- function(fast5){
  h5closeAll()
  junk <- try(fid <- H5Fopen(fast5),silent=TRUE)
  if(attr(junk,"class")=="try-error"){
    warning(attr(junk,"condition"))
    return(NULL)
  }
  alignment_attr <- "/Analyses/RawGenomeCorrected_000/BaseCalled_template/Alignment"
  junk <- try(gid <- H5Gopen(fid, alignment_attr),silent=TRUE)
  if(attr(junk,"class")=="try-error"){
    warning(attr(junk,"condition"))
    h5closeAll()
    return(NULL)
  }
  mapped_start <- H5Aread(H5Aopen(gid, "mapped_start"))
  mapped_end <- H5Aread(H5Aopen(gid, "mapped_end"))
  mapped_strand <- H5Aread(H5Aopen(gid, "mapped_strand"))
  mapped_chrom <- H5Aread(H5Aopen(gid, "mapped_chrom"))
  H5Gclose(gid)
  fastq_attr <- "/Analyses/Basecall_1D_000/BaseCalled_template/Fastq"
  junk <- try(did <- H5Dopen(fid, fastq_attr),silent=TRUE)
  if(attr(junk,"class")=="try-error"){
    warning(attr(junk,"condition"))
    h5closeAll()
    return(NULL)
  }
  fastq <- H5Dread(did, compoundAsDataFrame = TRUE)
  H5Dclose(did)
  h5closeAll()
  return(list(fastq=fastq,chr=mapped_chrom,strand=mapped_strand,
                 start=mapped_start,end=mapped_end))
}
