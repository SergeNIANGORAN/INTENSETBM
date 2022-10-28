#' Function to directly import project databases files
#'
#'@param URL .
#'@param API_KEY .
#'@param REF_IDENTIFIER .
#'@param pathSave .
#'
#'@return a list of object of class \code{ImportsFilesProject}, which is a list of several data
#'
#'@importFrom reticulate import_from_path
#'@importFrom stats sd
#'
#'@export
#'
#'@examples
#'if(interactive()){
#'
#'res <- CytOpT(X_s = HIPC_Stanford_1228_1A, X_t = HIPC_Stanford_1369_1A,
#'              Lab_source = HIPC_Stanford_1228_1A_labels,
#'              method='minmax')
#'summary(res)
#'plot(res)
#'
#'}
#'
## EXECUTE PYTHON CODE IN R
pathPython <- "C:/Program Files/Python37"
reticulate::use_python(pathPython)

generateFileData <- function(URL, API_KEY, REF_IDENTIFIER, pathSave){
  pathOfFilesPython <- "inst"
  codePython <- reticulate::py_run_file(paste0(pathOfFilesPython,"/script_csv_intensetbm_copy.py"))
  codePython$test_function(URL, API_KEY, REF_IDENTIFIER, pathSave)
}


generateFileData(URL = '' ,
                 API_KEY = '',
                 REF_IDENTIFIER = '',
                 pathSave = "")
