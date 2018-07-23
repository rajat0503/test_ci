import matlab.unittest.TestRunner % Package for running test suite 
import matlab.unittest.plugins.TAPPlugin
import matlab.unittest.plugins.ToFile
import matlab.unittest.plugins.XMLPlugin
jenkins_workspace = getenv('WORKSPACE');
cd(jenkins_workspace);

try
%     mcdcMet = CoverageMetrics('Decision',true,'Condition',true,'MCDC',true);
% covSettings = ModelCoveragePlugin('RecordModelReferenceCoverage',true,...
%      'Collecting',mcdcMet);
suite = testsuite('testman'); %Use SLTEST testman.mldatx file to create testsuite
    % Create and configure the runner
    
    % TAP File Creation For Test Anything Protocol Integration
    tapResultsFile = fullfile(jenkins_workspace, 'TAPResults.tap');
    xmlResultsFile = fullfile(jenkins_workspace, 'myTestResults.xml');
    p = XMLPlugin.producingJUnitFormat(xmlResultsFile);
    
    % new Tap File Creation 
    % TAP File Created in Jenkins Workspace Path
    
    runner = TestRunner.withTextOutput();
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile),'Verbosity',3));
    runner.addPlugin(p);
    
%     addPlugin(runner,covSettings);
%  	coverageFile = fullfile(jenkins_workspace, 'coverage.xml');
%     addCoberturaCoverageIfPossible(runner, jenkins_workspace, coverageFile);	
	% Run tests
results = runner.run(suite);
%     results2 = runtests('testman.mldatx');
    %matlab.unittest.plugins.ToFile('myFile.tap')
    display(results);
%      display(results2);
catch e
    disp(getReport(e, 'extended'));
 
end