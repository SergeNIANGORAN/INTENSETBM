#' Function to directly import project databases files
#'
#'@param .
#'@param
#'
#'@param
#'@param
#'
#'@return a object of class \code{CytOpt}, which is a list of two elements:\itemize{
#'   \item \code{proportions} a \code{data.frame} with the (optionally true and)
#'   estimated proportions for each \code{method}
#'   \item \code{monitoring} a list of estimates over the optimization iterations
#'   for each \code{method} (listed within)
#' }
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
  pathOfFilesPython <- "C:/PYTHON_SCRIPTS/redcapy_import_intensetbm"
  codePython <- reticulate::py_run_file(paste0(pathOfFilesPython,"/script_csv_intensetbm_copy.py"))
  codePython$test_function(URL, API_KEY, REF_IDENTIFIER, pathSave)
}


generateFileData(URL = 'https://intense-tbm.pacci.ci/api/',
                 API_KEY = '4C0097230C6C8E0CA468357CCAED572B',
                 REF_IDENTIFIER = 'record_id',
                 pathSave = "C:/PROJETS/Projet INTENSE TBM/DATABASES/FileSave")
