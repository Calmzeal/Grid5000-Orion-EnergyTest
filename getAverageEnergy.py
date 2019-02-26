import re
import numpy as np
with open('logC1N6400S2.txt', 'r') as myfile:
  data = myfile.read()
ans = re.sub('\s','',data)
ans = re.split(r'[\[\],\n]',ans)
ans = list(filter(None,ans))
ans = list(map(float,ans))
print(np.mean(ans))
myfile.close()
