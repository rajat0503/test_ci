import matlab.unittest.TestRunner; % Package for running test suite 
import matlab.unittest.plugins.TAPPlugin;
import matlab.unittest.plugins.ToFile;
jenkins_workspace = getenv('WORKSPACE');
cd(jenkins_workspace);

try
    
    suite = testsuite('testman','Name','SLTEST_TC_*'); %this the new change
    
    
    % Create and configure the runner
    
    tapResultsFile = fullfile(jenkins_workspace, 'TAPResults.tap');
    runner = TestRunner.withTextOutput();
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile)));
		
	% Run tests
results = runner.run(suite);
%     results2 = runtests('testman.mldatx');
    %matlab.unittest.plugins.ToFile('myFile.tap')
    display(results);
%      display(results2);
catch e
    disp(getReport(e, 'extended'));
    exit(1);
end


