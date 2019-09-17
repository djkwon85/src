list = readtable('list.txt');
names = table2cell(list)';
length(names);
for i=1:length(names)
    dta = readtable(names{i});
    x_lines = table2array(dta(:,1));
    if iscell(table2array((dta(1,5))))
        Storage_ACFT = str2double(table2array(dta(:,5)));
    else
        Storage_ACFT = table2array(dta(:,5));
    end
    if iscell(table2array((dta(1,7))))
        Storage_ACFT_OT = str2double(table2array(dta(:,7)));
    else
        Storage_ACFT_OT = table2array(dta(:,7));
    end
        
    figure(i)
    plot(Storage_ACFT);hold on;
    plot(Storage_ACFT_OT);
    set(gcf,'position',[0,0,800,200])
    title(names{i});
    
end
