SET MATLABROOT="C:\Program Files\MATLAB\R2017b\bin"
PATH=%MATLABROOT%;%PATH%
START matlab.exe -nodesktop -nosplash -nodisplay -r "run('C:\Jenkins\workspace\CI_J_Test\runtestci.m')" %1 -logfile c:\temp\logfile
PAUSE