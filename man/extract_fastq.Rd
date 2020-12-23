\name{extract_fastq}
\alias{extract_fastq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
test
}
\description{
test
}
\usage{
extract_fastq(fast5)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fast5}{
test
}
}
\details{
test
}
\value{
test
}
\references{
test
}
\author{
test
}
\note{
test
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
test
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (fast5) 
{
    h5closeAll()
    junk <- try(fid <- H5Fopen(fast5), silent = TRUE)
    if (attr(junk, "class") == "try-error") {
        warning(attr(junk, "condition"))
        return(NULL)
    }
    alignment_attr <- "/Analyses/RawGenomeCorrected_000/BaseCalled_template/Alignment"
    junk <- try(gid <- H5Gopen(fid, alignment_attr), silent = TRUE)
    if (attr(junk, "class") == "try-error") {
        warning(attr(junk, "condition"))
        h5closeAll()
        return(NULL)
    }
    mapped_start <- H5Aread(H5Aopen(gid, "mapped_start"))
    mapped_end <- H5Aread(H5Aopen(gid, "mapped_end"))
    mapped_strand <- H5Aread(H5Aopen(gid, "mapped_strand"))
    mapped_chrom <- H5Aread(H5Aopen(gid, "mapped_chrom"))
    H5Gclose(gid)
    fastq_attr <- "/Analyses/Basecall_1D_000/BaseCalled_template/Fastq"
    junk <- try(did <- H5Dopen(fid, fastq_attr), silent = TRUE)
    if (attr(junk, "class") == "try-error") {
        warning(attr(junk, "condition"))
        h5closeAll()
        return(NULL)
    }
    fastq <- H5Dread(did, compoundAsDataFrame = TRUE)
    H5Dclose(did)
    h5closeAll()
    return(list(fastq = fastq, chr = mapped_chrom, strand = mapped_strand, 
        start = mapped_start, end = mapped_end))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
