import re
import subprocess

program_file = "/Users/Xiangyu/domino_example_test/domino-examples/domino_programs/learn_filter.c"
group_size = "1"

def print_dic(given_dic):
    for x, y in given_dic.items():
        print(x, "<-----------", y)

# Run domino
(ret_code, output) = subprocess.getstatusoutput("domino " + program_file + " hh.sk 10 10")

# Run canonicalizer
(ret_code, output) = subprocess.getstatusoutput("canonicalizer " + program_file)
assert ret_code == 0, "canonicalizer failed"

canonicalizer_file ="/tmp/" + program_file[program_file.rfind('/') + 1 : program_file.rfind('.')] + "_canonicalizer.c"
# grouper
(ret_code,output) = subprocess.getstatusoutput("grouper " + canonicalizer_file + " " + group_size)
assert ret_code == 0, "grouper failed"

group_file = "/tmp/" + canonicalizer_file[canonicalizer_file.rfind('/') + 1:canonicalizer_file.rfind('.')] + "_equivalent_" + str(int(output) - 1) + ".c"
# domino_to_chipmunk
(ret_code, output) = subprocess.getstatusoutput("domino_to_chipmunk " + group_file)
assert ret_code == 0, "domino_to_chipmunk failed"

# build dic for each file
file_name_list = ["/tmp/canonicalizer_map.txt", "/tmp/grouper_map.txt", "/tmp/domino_to_chipmunk_map.txt"]
dic_list = [{}, {}, {}]

# read from each file from file_name_list and put them into the dict
for i in range(len(file_name_list)):
    filename = file_name_list[i]
    f = open(filename, "r")
    for x in f:
        key = x.split(':')[0]
        val = x.split(':')[1].split(',')
        assert len(val) == 1, "wrong length of val"
        if val[-1][-1] == '\n':
            val[-1] = val[-1][:-1]
        dic_list[i][key] = val[0]
    print_dic(dic_list[i])

# propagate dic_list
for i in range(1, len(file_name_list)):
    for x in dic_list[0]:
        print(x)
        print(dic_list[0][x])
        if dic_list[0][x] in dic_list[i]:
             dic_list[0][x] = dic_list[i][dic_list[0][x]]

# Build the influ_dic
# i.e. last_update:last_update,p.now --> key: last_update; val: [p.now, last_update]
influ_dic = {}
influence_map_file = "/tmp/influence_map.txt"
f = open(influence_map_file, "r")
for x in f:
    key = x.split(':')[0]
    val = x.split(':')[1].split(',')
    # remove the '\n' char
    if val[-1][-1] == '\n':
        val[-1] = val[-1][:-1]
    for i in range(len(val)):
        val[i] = dic_list[0][val[i]]
    influ_dic[dic_list[0][key]] = val
print_dic(influ_dic)
