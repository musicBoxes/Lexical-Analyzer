import os
for i in range(1, 11):
	print(i)
	os.system("./syn.out < ./test/test_1_r%02d.spl > ./test_result/test_1_r%02d.out"%(i, i))