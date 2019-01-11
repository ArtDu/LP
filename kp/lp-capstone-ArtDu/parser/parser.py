import os
f = open('../my_gen.ged')
people = {}
line = f.readline().split()
while len(line)>0:
	if len(line)<3:
		pass
	elif line[2] == 'INDI':
		no = line[1]
		while (line[1] != 'GIVN'):
			line = f.readline().split()
		name = line[2]
		while (line[1] != 'SURN' and line[1] != '_MARNM'):
			line = f.readline().split()
		surname = line[2]
		line = f.readline().split()
		if (line[1] == '_MARNM'):
			surname = line[2]
		people[no] = '"'+surname+' '+name+'"'

	elif line[2] == 'FAM':
		wife = ""
		husband = ""
		line = f.readline().split()
		line = f.readline().split()
		if line[1] == 'HUSB':
			husband = people[line[2]]
			line = f.readline().split()
		if line[1] == 'WIFE':			
			wife = people[line[2]]
			line = f.readline().split()
		while (line[1] == 'CHIL'):
			if len(wife)>0 and len(husband)>0:
				print("parents({0}, {1}, {2}).".format(people[line[2]], husband , wife))
			line = f.readline().split()


	line = f.readline().split()


