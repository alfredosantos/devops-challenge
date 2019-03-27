import sys
import re

FILE_NAME = 1

if len(sys.argv) == 2:
    fileInput = open(sys.argv[FILE_NAME], 'r')

    content = fileInput.read()

    fileInput.close()

    position = content.rfind('.')

    newContent = int(content[position + 1:]) + 1

    n = content[:position + 1] + str(newContent)

    fileOutput = open(sys.argv[FILE_NAME], 'w')

    fileOutput.write(n)

    fileOutput.close()

else:
    print('Parameters: <file name>')
    print('For example: python increase-version.py component_version')


