#!/bin/python
import subprocess


def calculate_time(time):
    return f'{str(int(time) // 60).zfill(2)}:{str(int(time) % 60).zfill(2)}'


cmd = ['cmus-remote', '-Q']
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
output = proc.stdout.readlines()
# Convert byte to string
output = [_.decode('utf-8') for _ in output]

if 'paused' in output[0]:
    print('paused')
else:
    name, duration, current = output[1:4]
    name = name.strip().split('/')[-1]
    name = ''.join(name.split('.')[:-1])
    duration = duration.strip().split(' ')[-1]
    current = current.strip().split(' ')[-1]

    duration = calculate_time(duration)
    current = calculate_time(current)

    print(f'{name} ({current} / {duration})')

