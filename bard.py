import sys
cookie="XQj3ga9d6fRsB_ynfX32NCZ3CV5QW1BTM2Jd-C9knYVfYsxw7bNsrsx4GUSEsWX9eCw48Q."


from bardapi import Bard

token = cookie
question = f"Who is  the {sys.argv[1]} of {sys.argv[2]}"
bard = Bard(token=token)
answer=bard.get_answer(question)['content']
answer_list=answer.split(".")
correct_answer=[x for x in answer_list if f"{sys.argv[1].upper()}" in x.upper() and  f"{sys.argv[2].upper()}" in x.upper() and  "IS" in x.upper()]
print(" ".join(correct_answer))