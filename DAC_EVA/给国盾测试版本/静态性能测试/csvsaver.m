classdef csvsaver < handle
    properties
        data=struct(...
           'ceshibanhao','δ��д',...
           'mubiaozengyi1','δ��д',  'mubiaozengyi2','δ��д',   'mubiaozengyi3','δ��д',   'mubiaozengyi4','δ��д',...
           'shijizengyi1','δ��д',   'shijizengyi2','δ��д',    'shijizengyi3','δ��д',    'shijizengyi4','δ��д',...
           'shijimazhi1','δ��д',    'shijimazhi2','δ��д',     'shijimazhi3','δ��д',      'shijimazhi4','δ��д',...
           'mubiaopianzhi1','δ��д', 'mubiaopianzhi2','δ��д',  'mubiaopianzhi3','δ��д',   'mubiaopianzhi4','δ��д',...
           'shijipianzhi1','δ��д',  'shijipianzhi2','δ��д',   'shijipianzhi3','δ��д',    'shijipianzhi4','δ��д',...
           'pianzhimazhi1','δ��д',  'pianzhimazhi2','δ��д',   'pianzhimazhi3','δ��д',    'pianzhimazhi4','δ��д',...
           'DNL_MAX1','δ��д',       'DNL_MAX2','δ��д',        'DNL_MAX3','δ��д',         'DNL_MAX4','δ��д',...
           'INL_MAX1','δ��д',       'INL_MAX2','δ��д',        'INL_MAX3','δ��д',         'INL_MAX4','δ��д',...
           'DACzhijieshuchu_11','δ��д','DACzhijieshuchu_12','δ��д','DACzhijieshuchu_13','δ��д','DACzhijieshuchu_14','δ��д',...
           'DACjiehouduan_11','δ��д',  'DACjiehouduan_12','δ��д',  'DACjiehouduan_13','δ��д',   'DACjiehouduan_14','δ��д',...
           'DACzhijieshuchu_21','δ��д','DACzhijieshuchu_22','δ��д','DACzhijieshuchu_23','δ��д','DACzhijieshuchu_24','δ��д',...
           'DACjiehouduan_21','δ��д',  'DACjiehouduan_22','δ��д',  'DACjiehouduan_23','δ��д',   'DACjiehouduan_24','δ��д',...
           'DACzhijieshuchu_31','δ��д','DACzhijieshuchu_32','δ��д','DACzhijieshuchu_33','δ��д','DACzhijieshuchu_34','δ��д',...
           'DACjiehouduan_31','δ��д',  'DACjiehouduan_32','δ��д',  'DACjiehouduan_33','δ��д',   'DACjiehouduan_34','δ��д',...
           'DACzhijieshuchu_41','δ��д','DACzhijieshuchu_42','δ��д','DACzhijieshuchu_43','δ��д','DACzhijieshuchu_44','δ��д',...
           'DACjiehouduan_41','δ��д',  'DACjiehouduan_42','δ��д',  'DACjiehouduan_43','δ��д',   'DACjiehouduan_44','δ��д',...
           'DACzhijieshuchu_51','δ��д','DACzhijieshuchu_52','δ��д','DACzhijieshuchu_53','δ��д','DACzhijieshuchu_54','δ��д',...
           'DACjiehouduan_51','δ��д',  'DACjiehouduan_52','δ��д',  'DACjiehouduan_53','δ��д',   'DACjiehouduan_54','δ��д',...
           'SNR1','δ��д',   'SNR2','δ��д',    'SNR3','δ��д',    'SNR4','δ��д',...
           'ENOB1','δ��д',  'ENOB2','δ��д',   'ENOB3','δ��д',    'ENOB4','δ��д',...
           'THD1','δ��д',   'THD2','δ��д',    'THD3','δ��д',     'THD4','δ��д',...
           'SINAD1','δ��д', 'SINAD2','δ��д',  'SINAD3','δ��д',   'SINAD4','δ��д'...
            );%ȫ����ʼ��Ϊδ��д
    end
    
    methods
        function obj=csvsaver()
            % a=csvsaver;
            mpath = mfilename('fullpath');
            i=findstr(mpath,'\'); %#ok<FSTR>
            mpath=mpath(1:i(end));
            mpath1=mpath;
            addpath([mpath1,'jsonlab-master'])
        end
        function savefile(obj,filename)%��֧�־���·��,ֻ�ܴ浽data�ļ���
            % a.savefile()
            if nargin==1
                filename='data';
            end
            
            % mod2 = py.importlib.import_module('jinjatemplate');
            % py.importlib.reload(mod2);    
            % result=char(mod2.render('Report.csv',obj.data));
            mpath = mfilename('fullpath');
            i=findstr(mpath,'\'); %#ok<FSTR>
            mpath=mpath(1:i(end));
            mpath1=mpath;
            
            addpath([mpath1,'jsonlab-master'])
            data=obj.data;   %#ok<PROPLC>
            save([mpath,'data\',filename,'.mat'],'data');           
            datajson=savejson('data',data,[mpath,'data\',filename,'.json']);%#ok<PROPLC> %�˴������gbk����
            disp(datajson);
            
            [~,pypath,~]= pyversion;
            command=[pypath,' ',mpath1,'jinjatemplate.py ','Report.csv ',[mpath,'data\',filename,'.json'] ];
            % C:\Python34\python.exe E:\workspace\matlab\python\csvsaver\jinjatemplate.py Report.csv E:\workspace\matlab\python\csvsaver\data\data.json
            [status, result]=system(command);
            if ~(status==0)
                error('can''t exec python file')
            end
            
            fid=fopen([mpath,'data\',filename,'.csv'],'w');
            fprintf(fid,result);
            fclose(fid);
            
        end
        function readstruct(obj,struct_) %#ok<INUSL>
            % ��struct�ж�����
            % a.readstruct(struct('ceshibanhao','aaa','mubiaozengyi1','1.22'));
            if ~isa(struct_,'struct')
                error('not a struct or pointer')
            end
            names = fieldnames(struct_);
            for i=1:length(names)
               name = char(names(i));
               eval(['obj.setdata(''',name,''',struct_.', name ,');'])
            end
        end
        function setdata(obj,field,value)
            % a.setdata('mubiaozengyi2',1.3);
            if ~ischar(value)
                value=num2str(value);
            end
            boolbelong=false;
            for datafield = fieldnames(obj.data)
                boolbelong = (boolbelong | strcmp(field,datafield) );
            end
            if ~boolbelong
                error('field name error')
            end
            if ~strcmp(value,'δ��д')
                eval([ 'obj.data.',field,'=''',value ,''';' ])
            end
        end
        function readjson(obj)
            % a.readjson()
            pathstr = [pwd,'\data\'];
            namestr = [obj.data.ceshibanhao,'.json'];
%             [namestr,pathstr]=uigetfile({'*.json'});
            arcpic=[pathstr,namestr];
            if(exist(arcpic))
                jsondata = loadjson(arcpic);
                obj.readstruct(jsondata.data)
            end
        end
        function test(obj) %#ok<MANU>
%%
% cc
appdata=struct('ceshibanhao','aaa','mubiaozengyi1','1.22');
names = fieldnames(appdata);
for i=1:length(names)
   name = char(names(i)); 
   disp({name, getfield(appdata,name)}); %#ok<GFLD>
end

mod2 = py.importlib.import_module('jinjatemplate');
py.importlib.reload(mod2);
a=char(mod2.render('Report.csv',appdata));
disp(a);
%%            
        end
    end
end
