function varargout=GetLastFilenameWithoutExtension(str_bf)
%output:str_af or [str_af w_num]

str = split(str_bf,'\');
str = str(end);
str = split(str,'.');
str_af = str{1};

w_num=regexp(str_af, 'w(\d*)', 'tokens');
w_num=str2num(w_num{1}{1});%only output the first matching result

varargout{1}=str_af;

if nargout>1

    varargout{2}=w_num;

end

end
