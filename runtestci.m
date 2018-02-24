import matlab.unittest.TestRunner
import matlab.unittest.plugins.TAPPlugin
import matlab.unittest.TestSuite
import matlab.unittest.plugins.ToFile
jenkins_workspace = pwd;

try
    
    suite = testsuite;
    tapResultsFile = fullfile(jenkins_workspace, 'TAPResults.tap');
    
    % Create and configure the runner
    runner = TestRunner.withTextOutput();
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile)));
		
	% Run tests
    results = runner.run(suite);
    results2 = runtests('testman.mldatx');
    display(results);
catch e
    disp(getReport(e, 'extended'));
    %exit(1);
end

