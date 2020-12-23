\name{extract_all_fastq}
\alias{extract_all_fastq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
extract_all_fastq(fast5dir, prefix)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fast5dir}{
%%     ~~Describe \code{fast5dir} here~~
}
  \item{prefix}{
%%     ~~Describe \code{prefix} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (fast5dir, prefix) 
{
    files <- list.files(fast5dir, full.names = TRUE)
    files <- files[grep("\\.fast5$", files)]
    n <- length(files)
    fastq <- paste0(prefix, ".fastq")
    info <- paste0(prefix, "_info.tsv")
    fastq_file <- file(fastq, "w")
    info_file <- file(info, "w")
    for (i in 1:n) {
        cat(i, "/", n, "\n")
        junk <- extract_fastq(files[i])
        if (!is.null(junk)) {
            filename <- gsub("^@", "", unlist(strsplit(junk$fastq, 
                " "))[1])
            cat(junk$fastq, file = fastq_file)
            cat(paste0(paste(c(basename(files[i]), filename, 
                junk$chr, junk$start, junk$end, junk$strand), 
                collapse = "\t"), "\n"), file = info_file)
        }
    }
    close(fastq_file)
    close(info_file)
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
