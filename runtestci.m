import matlab.unittest.TestSuite;
import matlab.unittest.TestRunner;
import matlab.unittest.plugins.TAPPlugin;
import matlab.unittest.plugins.ToFile;
jenkins_workspace = getenv('WORKSPACE');

try
    
    suite = testsuite();
    
    
    % Create and configure the runner
    runner = TestRunner.withTextOutput();
    tapResultsFile = fullfile(jenkins_workspace, 'TAPResults.tap');
    
		
	% Run tests
    results = runner.run(suite);
    %results2 = runtests('testman.mldatx');
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile)));
    display(results);
%     display(results2);
catch e
    disp(getReport(e, 'extended'));
    exit(1);
end

