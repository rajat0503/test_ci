import matlab.unittest.TestRunner % Package for running test suite 
import matlab.unittest.plugins.TAPPlugin
import matlab.unittest.plugins.ToFile
import matlab.unittest.plugins.XMLPlugin
import sltest.plugins.ModelCoveragePlugin
import sltest.plugins.coverage.CoverageMetrics
import sltest.plugins.coverage.ModelCoverageReport
import matlab.unittest.plugins.codecoverage.CoberturaFormat


try
    mcdcMet = CoverageMetrics('Decision',true,'Condition',true,'MCDC',true);
    covSettings = ModelCoveragePlugin('RecordModelReferenceCoverage',true,...
                     'Collecting',mcdcMet);
    tf = sltest.testmanager.TestFile('testman.mldatx');         
    suite = testsuite(tf.FilePath); %Use SLTEST testman.mldatx file to create testsuite
    % Create and configure the runner
    
    % Create Cobertura Report
    rptfile = [bdroot,'.xml'];
    rpt = CoberturaFormat(rptfile);
    
    % TAP File Creation For Test Anything Protocol Integration
    % Store Tap results
    TapResultFolder = './TapResults';
    
    if ~exist(TapResultFolder, 'dir')
       mkdir(TapResultFolder)
    end
    tapResultsFile = './TapResults/TAPResults.tap' ; 
    xmlResultsFile = './TapResults/myTestResults.xml';
    p = XMLPlugin.producingJUnitFormat(xmlResultsFile);
   
    runner = TestRunner.withTextOutput;
    
    % Store coverage results in directory
    
    CovPath = './exReports/Coverage/';
     if ~exist(CovPath, 'dir')
       mkdir(CovPath)
     else
      d = dir('./exReports/Coverage/*.xml');
     for i= 1:length(d)
         delete(['./exReports/Coverage/',d(i).name]);
     end
     end
  
    % Create Cobertura Report
    rptfile = [CovPath,bdroot,'.xml'];
    rpt = CoberturaFormat(rptfile);
    %mcr = ModelCoverageReport(path);
    
    mc = ModelCoveragePlugin('Collecting',mcdcMet,'Producing',rpt);
    
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile),'Verbosity',3));
    runner.addPlugin(p);
    runner.addPlugin(mc);
    runner.addPlugin(covSettings);
    
    % Turn off command line warnings:
    warning off Stateflow:cdr:VerifyDangerousComparison
    warning off Stateflow:Runtime:TestVerificationFailed

    results = runner.run(suite);

    display(results);

catch e
    disp(getReport(e, 'extended'));
 
end
