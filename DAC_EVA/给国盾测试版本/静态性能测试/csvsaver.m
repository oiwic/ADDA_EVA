classdef csvsaver < handle
    properties
        data=struct(...
           'ceshibanhao','Î´ÌîÐ´',...
           'mubiaozengyi1','Î´ÌîÐ´',  'mubiaozengyi2','Î´ÌîÐ´',   'mubiaozengyi3','Î´ÌîÐ´',   'mubiaozengyi4','Î´ÌîÐ´',...
           'shijizengyi1','Î´ÌîÐ´',   'shijizengyi2','Î´ÌîÐ´',    'shijizengyi3','Î´ÌîÐ´',    'shijizengyi4','Î´ÌîÐ´',...
           'shijimazhi1','Î´ÌîÐ´',    'shijimazhi2','Î´ÌîÐ´',     'shijimazhi3','Î´ÌîÐ´',      'shijimazhi4','Î´ÌîÐ´',...
           'mubiaopianzhi1','Î´ÌîÐ´', 'mubiaopianzhi2','Î´ÌîÐ´',  'mubiaopianzhi3','Î´ÌîÐ´',   'mubiaopianzhi4','Î´ÌîÐ´',...
           'shijipianzhi1','Î´ÌîÐ´',  'shijipianzhi2','Î´ÌîÐ´',   'shijipianzhi3','Î´ÌîÐ´',    'shijipianzhi4','Î´ÌîÐ´',...
           'pianzhimazhi1','Î´ÌîÐ´',  'pianzhimazhi2','Î´ÌîÐ´',   'pianzhimazhi3','Î´ÌîÐ´',    'pianzhimazhi4','Î´ÌîÐ´',...
           'DNL_MAX1','Î´ÌîÐ´',       'DNL_MAX2','Î´ÌîÐ´',        'DNL_MAX3','Î´ÌîÐ´',         'DNL_MAX4','Î´ÌîÐ´',...
           'INL_MAX1','Î´ÌîÐ´',       'INL_MAX2','Î´ÌîÐ´',        'INL_MAX3','Î´ÌîÐ´',         'INL_MAX4','Î´ÌîÐ´',...
           'DACzhijieshuchu_11','Î´ÌîÐ´','DACzhijieshuchu_12','Î´ÌîÐ´','DACzhijieshuchu_13','Î´ÌîÐ´','DACzhijieshuchu_14','Î´ÌîÐ´',...
           'DACjiehouduan_11','Î´ÌîÐ´',  'DACjiehouduan_12','Î´ÌîÐ´',  'DACjiehouduan_13','Î´ÌîÐ´',   'DACjiehouduan_14','Î´ÌîÐ´',...
           'DACzhijieshuchu_21','Î´ÌîÐ´','DACzhijieshuchu_22','Î´ÌîÐ´','DACzhijieshuchu_23','Î´ÌîÐ´','DACzhijieshuchu_24','Î´ÌîÐ´',...
           'DACjiehouduan_21','Î´ÌîÐ´',  'DACjiehouduan_22','Î´ÌîÐ´',  'DACjiehouduan_23','Î´ÌîÐ´',   'DACjiehouduan_24','Î´ÌîÐ´',...
           'DACzhijieshuchu_31','Î´ÌîÐ´','DACzhijieshuchu_32','Î´ÌîÐ´','DACzhijieshuchu_33','Î´ÌîÐ´','DACzhijieshuchu_34','Î´ÌîÐ´',...
           'DACjiehouduan_31','Î´ÌîÐ´',  'DACjiehouduan_32','Î´ÌîÐ´',  'DACjiehouduan_33','Î´ÌîÐ´',   'DACjiehouduan_34','Î´ÌîÐ´',...
           'DACzhijieshuchu_41','Î´ÌîÐ´','DACzhijieshuchu_42','Î´ÌîÐ´','DACzhijieshuchu_43','Î´ÌîÐ´','DACzhijieshuchu_44','Î´ÌîÐ´',...
           'DACjiehouduan_41','Î´ÌîÐ´',  'DACjiehouduan_42','Î´ÌîÐ´',  'DACjiehouduan_43','Î´ÌîÐ´',   'DACjiehouduan_44','Î´ÌîÐ´',...
           'DACzhijieshuchu_51','Î´ÌîÐ´','DACzhijieshuchu_52','Î´ÌîÐ´','DACzhijieshuchu_53','Î´ÌîÐ´','DACzhijieshuchu_54','Î´ÌîÐ´',...
           'DACjiehouduan_51','Î´ÌîÐ´',  'DACjiehouduan_52','Î´ÌîÐ´',  'DACjiehouduan_53','Î´ÌîÐ´',   'DACjiehouduan_54','Î´ÌîÐ´',...
           'SNR1','Î´ÌîÐ´',   'SNR2','Î´ÌîÐ´',    'SNR3','Î´ÌîÐ´',    'SNR4','Î´ÌîÐ´',...
           'ENOB1','Î´ÌîÐ´',  'ENOB2','Î´ÌîÐ´',   'ENOB3','Î´ÌîÐ´',    'ENOB4','Î´ÌîÐ´',...
           'THD1','Î´ÌîÐ´',   'THD2','Î´ÌîÐ´',    'THD3','Î´ÌîÐ´',     'THD4','Î´ÌîÐ´',...
           'SINAD1','Î´ÌîÐ´', 'SINAD2','Î´ÌîÐ´',  'SINAD3','Î´ÌîÐ´',   'SINAD4','Î´ÌîÐ´'...
            );%È«²¿³õÊ¼»¯ÎªÎ´ÌîÐ´
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
        function savefile(obj,filename)%²»Ö§³Ö¾ø¶ÔÂ·¾¶,Ö»ÄÜ´æµ½dataÎÄ¼þ¼Ð
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
            datajson=savejson('data',data,[mpath,'data\',filename,'.json']);%#ok<PROPLC> %´Ë´¦´æµÄÊÇgbk±àÂë
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
            % ´ÓstructÖÐ¶ÁÊý¾Ý
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
            if ~strcmp(value,'Î´ÌîÐ´')
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
