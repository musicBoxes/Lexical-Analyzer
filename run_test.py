import os
for i in range(1, 11):
	print(i)
	cmd = "./syn.out < ./test/test_1_r%02d.spl > ./test_result/test_1_r%02d.out"%(i, i)
	# print(cmd)
	os.system(cmd)
	if (i > 4):
		continue
	val = os.system("diff ./test_result/test_1_r%02d.out ./test/test_1_r%02d.out > tmp.txt"%(i, i))
	if (val == 0):
		print("Pass!")
	elif (val == 256):
		print("Fail!")
		f = open("./test_result/test_1_r%02d.out"%(i))
		for line in f:
			print(line.strip("\n"))
	else:
		print("Fail!")
for i in range(1, 4):
	print(i)
	cmd = "./syn.out < ./test/test_1_o%02d.spl > ./test_result/test_1_o%02d.out"%(i, i)
	# print(cmd)
	os.system(cmd)
cmd = "./syn.out < ./test/for_test.spl > ./test_result/for_test.out"
os.system(cmd)