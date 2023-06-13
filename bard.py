import sys
cookie="WQjKRrrtorh5vfzDVPJv1HH3QNSRVe7XDpGpGNoPTwSCggDZxBoq5nfbUah4odlMpefdXA."


from bardapi import Bard

token = cookie
question = "Who is  the {sys.argv[1]} of sys.argv[2]"
bard = Bard(token=token)
answer=bard.get_answer()['content']
print(answer)