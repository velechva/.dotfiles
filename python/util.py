import subprocess
import re
import glob
import pprint

def ex(cmd, no_except=False, text=True, split=False):
	child = subprocess.Popen( \
		cmd, \
		shell=True, \
		text=text, \
		stdout=subprocess.PIPE, stderr=subprocess.PIPE \
	)

	(stdout, stderr) = child.communicate()
	ret = child.returncode

	if ret != 0:
		if no_except:
			stdout += stderr
		else:
				raise Exception("Command failed: %s\n\n%s%s" % (cmd, stderr, stdout))
	
	if split:
		return stdout.split('\n')

	return stdout

def intersperse(iterable, delimiter):
    it = iter(iterable)

    yield next(it)

    for x in it:
        yield delimiter
        yield x
