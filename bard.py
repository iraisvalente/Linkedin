import sys
cookie="XQj3ga9d6fRsB_ynfX32NCZ3CV5QW1BTM2Jd-C9knYVfYsxw7bNsrsx4GUSEsWX9eCw48Q."


from bardapi import Bard

print(f"{sys.argv[1]}  {sys.argv[2]}")
token = cookie
question = f"{sys.argv[1]}  {sys.argv[2]}"
bard = Bard(token=token)
answer= bard.get_answer(question)['content']
answer_list=answer.split(".")
correct_answer= [x for x in answer_list if f"{sys.argv[1].upper()}" in x.upper() and  f"{sys.argv[2].upper()}" in x.upper() and  "IS" in x.upper()]
complete_answer = ''.join(correct_answer)
name = correct_answer[0]
name = name.split("is")
name = [y for y  in name if "THE" not in y.upper()]
Real_answer = name[0].strip() + ".\n" + complete_answer  
print(Real_answer)