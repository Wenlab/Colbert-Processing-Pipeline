function str_af=GetFileUpperLevelDirectory(str_bf)
%=\.
  backslash_num=findstr(str_bf,'\');
  str_af=str_bf(1:backslash_num(end));

end
