corps_mississippi_list = readtable('list.txt','ReadVariableNames',false);
reservoir_purpose = readtable('Reservoirs_purpose.csv');
NOAA_pmdi = readtable('Interpolation_NOAA_Palmer_pmdi.csv');
for i=1:height(corps_mississippi_list)
    resv_name = corps_mississippi_list(i,1);
    resv_name = table2array(resv_name);
    resv_name = erase(resv_name,".csv");
    idx = find(strcmp(resv_name,reservoir_purpose{:,2}));
    
    if length(idx) == 0
        msgbox('xxllll')
    else
        dta(i,1) = resv_name;
        %dta{i,2} = reservoir_purpose{idx,10:21};
        pp = reservoir_purpose{idx,11};
        if pp==1
            dta{i,2} = 'flood control';
        else
            dta{i,2} = 'others';
        end
        dta2 = readtable(table2array(corps_mississippi_list{i,1}));
        raw_date = dta2{:,1};
        y = year(raw_date);
        m = month(raw_date);
        d = day(raw_date);
        for_conv_date(:,1) = y;
        for_conv_date(:,2) = m;
        for_conv_date(:,3) = d;
        storage_acft = dta2{:,5};
        for_conv_date(:,4) = storage_acft;
        monthly_acft = daily2monthly(for_conv_date);
        st_idx = find(monthly_acft(:,1)==1990);
        st_idx = st_idx(1,1);
        monthly_dta = monthly_acft(st_idx:end,:);
    
        idx2 = find(strcmp(resv_name,NOAA_pmdi{:,2}));
        pmdi = NOAA_pmdi{idx,7:361}';
        monthly_dta(:,4) = pmdi(1:length(monthly_dta));
        Mississippi_monthly{1,i} = monthly_dta;
        Mississippi_monthly{2,i} = resv_name;
    end
    clear dta
    clear for_conv_date
    clear idx
end

%without label data
%for western reservoirs
%unsupervised classification
%using outflow pattern

%NLDAS-2
%Daymet-Daily
%https://daymet.ornl.gov/overview
%Inflow Outflow Storage
%Training: include water level (or Storage)
