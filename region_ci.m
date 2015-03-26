prompt = sprintf([' \n What Subject ID is this ? ex. s01 \n \n ']);
subject_id = input(prompt,'s');

prompt = sprintf([' \n What channel are you analyzing \n \n ']);
channel = input(prompt,'s');


%% lici

type = 'P';
interval = [50 150];
get_ci
interval = [25 75];
get_ci
interval = [125 175];
get_ci

%% icf

type = 'I';
interval = [50 150];
get_ci
interval = [25 75];
get_ci
interval = [125 175];
get_ci

%% sici

type = 'C';
interval = [50 150];
get_ci
interval = [25 75];
get_ci
interval = [125 175];
get_ci