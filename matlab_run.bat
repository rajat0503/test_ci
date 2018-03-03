SET MATLABROOT="C:\Program Files\MATLAB\R2017b\bin"
PATH=%MATLABROOT%;%PATH%
START matlab.exe -r -nodesktop %1 -logfile c:\temp\logfile
PAUSE