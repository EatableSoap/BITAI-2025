with open('./hexrom.txt','r') as f:
    line = f.readlines()

for l in line:
    temp = bin(int(l,base=16))
    temp = str(temp).replace('0b','')
    temp = int(temp)
    print('{:032d}'.format(temp))
