# 此脚本由 何友珏（北京大学2022级博士研究生）于2024年2月3日编写.
# 功能：提取标注层的起点和终点时间，以及总时长。
# 联系：使用中如遇任何问题可以电邮info[at]heyoujue.com联系脚本原作者。
# 本脚本抄了王旭莹和张明辉的脚本的部分代码，拼凑修改而成。

#This script was writen by Youjue He(Peking University)
#This script extracts the total duration and time point data of boundaries from certain tier. 
#Advices and suggestions are welcomed to email me(info[at]heyoujue.com)
#This script actually integrates lots of codes copied from scripts writen by Xuying Wang and Minghui Zhang.

! 执行这个程序,你需要在C盘temp文件夹下存放成对的[同名]TextGrid和Sound [单声道]文件.

form Choose the tier and filepath
real the_Index_of_Referenced_Tier_in_TextGrid 1
sentence File_path C:\Users\
sentence Save_path C:\Users\
endform

dirPath$=file_path$
savePath$=save_path$
if right$(dirPath$,1)<>"\" 
	dirPath$=dirPath$+"\"
endif
if right$(savePath$,1)<>"\" 
	savePath$=savePath$+"\"
endif

Create Strings as file list... list 'dirPath$'*.wav
fileNum= Get number of strings


tierNum=the_Index_of_Referenced_Tier_in_TextGrid

saveFileName$=  "all_durationratio.txt"
saveFileName$ = savePath$ +saveFileName$
filedelete 'saveFileName$'

for ifile to fileNum
	select Strings list
	fileName$ = Get string... ifile
	newFileName$ = fileName$ - ".wav"
	wavFileName$=newFileName$ +".wav"
	wavFileName$ = dirPath$ +wavFileName$
	textGridFileName$= newFileName$ +".TextGrid"
	textGridFileName$ = dirPath$ +textGridFileName$
	Read from file... 'wavFileName$'
	select Sound 'newFileName$'


	Read from file... 'textGridFileName$'
	select TextGrid 'newFileName$'

	label$=Get label of interval: tierNum, 2
	start_time=Get start time of interval: tierNum, 2
	start_time=number(fixed$(start_time, 5))
	end_time=Get end time of interval: tierNum, 2
	end_time=number(fixed$(end_time, 5))
	duration=Get total duration
	fileappend "'saveFileName$'" 'wavFileName$''tab$''label$''tab$''start_time''tab$''end_time''tab$''duration'

	fileappend "'saveFileName$'" 'newline$'
	select all
	minus Strings list
	Remove

endfor

