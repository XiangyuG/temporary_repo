import subprocess

filename = 'spam_detection'
for i in range(10):
    print('cp' + ' /tmp/' + filename + '_equivalent_'+str(i+1) + '.c ' + filename)
    (_, _) = subprocess.getstatusoutput('cp ' +
                             ' /tmp/' + filename + '_equivalent_'+str(i+1) + '.c' +
                             ' ' + filename)
