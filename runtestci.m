import matlab.unittest.TestRunner % Package for running test suite 
import matlab.unittest.plugins.TAPPlugin
import matlab.unittest.plugins.ToFile
import matlab.unittest.plugins.XMLPlugin
import sltest.plugins.ModelCoveragePlugin
import sltest.plugins.coverage.CoverageMetrics
import sltest.plugins.coverage.ModelCoverageReport


try
    mcdcMet = CoverageMetrics('Decision',true,'Condition',true,'MCDC',true);
    covSettings = ModelCoveragePlugin('RecordModelReferenceCoverage',true,...
                     'Collecting',mcdcMet);
    tf = sltest.testmanager.TestFile('testman.mldatx');         
    suite = testsuite(tf.FilePath); %Use SLTEST testman.mldatx file to create testsuite
    % Create and configure the runner
    
    % TAP File Creation For Test Anything Protocol Integration
    tapResultsFile = 'TAPResults.tap' ; %fullfile(jenkins_workspace, 'TAPResults.tap');
    xmlResultsFile = 'myTestResults.xml';% fullfile(jenkins_workspace, 'myTestResults.xml');
    p = XMLPlugin.producingJUnitFormat(xmlResultsFile);
   
    runner = TestRunner.withTextOutput;
    
    % Store coverage results in directory
    
    mkdir('./exReports/Coverage');
    path = './exReports/Coverage';
    mcr = ModelCoverageReport(path);
    
    mc = ModelCoveragePlugin('Producing',mcr);
    
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile),'Verbosity',3));
    runner.addPlugin(p);
    runner.addPlugin(mc);
    runner.addPlugin(covSettings);
    

results = runner.run(suite);
%     results2 = runtests('testman.mldatx');
    %matlab.unittest.plugins.ToFile('myFile.tap')
    display(results);
%      display(results2);
catch e
    disp(getReport(e, 'extended'));
 
end
