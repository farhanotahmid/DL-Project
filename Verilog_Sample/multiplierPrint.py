with open("prints.txt", 'w+') as file:
    for  j in range(0, 16):
        for i in range(0,16):
            file.write('A['+ str(j) + ']&B[' + str((16-i-1)) + '], ')
        file.write('\n\n\n')
    
