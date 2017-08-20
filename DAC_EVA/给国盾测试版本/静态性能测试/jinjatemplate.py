# -*- coding: utf-8 -*-

# https://www.python.org/ftp/python/3.4.4/python-3.4.4.amd64.msi
# >pip install jinja2
# jinja2-2.9.6

# addpath('C:\Python34\Doc')
# addpath('C:\Python34\DLLs')
# addpath('C:\Python34')
# pyversion C:\Python34\python.exe

from jinja2 import Environment, PackageLoader 

env = Environment(loader=PackageLoader('data','templates'))

def render(filename,data):
    return env.get_template(filename).render(data)

'''
mod2 = py.importlib.import_module('jinjatemplate');
py.importlib.reload(mod2);
a=char(mod2.render('Report.csv',struct('ceshibanhao','aaa','mubiaozengyi1','1.22')));
'''

if __name__ == '__main__':
    import sys
    import json
    f = open(sys.argv[2], 'r',encoding='gbk')
    obj=json.loads(f.read())
    f.close()
    print(render(sys.argv[1],obj['data']))

