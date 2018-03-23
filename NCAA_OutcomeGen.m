% NCAA_OutcomeGen.m
%   Calculate the chance of a bracket winning the pool starting at the 
%   Sweet 16. This includes ties for first. Assumption is all game outcomes
%   are equally likely. Challenging part of the code was determining all 
%   possible outcomes. Recursion since wins depend on previous round.
 
clear;
%% User Input
entry_name={'The Krzyzewskinator';'ZoeYeo';'Grayson''s Anatomy';'ESPNFAN0712522401 1';'d00k sucks';...
    'espn39369641 1';'Where''s Wisconsin??';'JHDasinger 1';'Court Mandate';'mwcurtis1';...
    'Optimistic appraisal';'MBrunner 1';'Marquette Still Sucks Ben';'Hoops there it is';'Herbie7';...
    'PUKE on Duke';'Brains but no game';'Where are the Badgers?';'broken bracket';'Jabaisbattad';...
    'Shockers and Awe';'Marq > Madison';'Airball so hard';'Arizona''s 100K investment';'Northwestern would''ve won';'no win, only lose'};

initialScore=[450,430,420,420,410,400,390,390,380,370,370,360,360,260,350,350,340,340,320,320,310,310,310,280,270,250]; % scores at start of Sweet 16

% Key: 
%     1: Win Sweet 16
%     2: Win Elite 8
%     3: Win Final 4
%     4: Win Championship

% User Entries: 
       %  KS UK LC NV | VN WV TT PU | FS GZ MI TA | KU CL SY DK
UserPred=[ 0, 0, 0, 0,   1, 0, 2, 0,   0, 0, 2, 0,   1, 0, 0, 4;  ... User 1 The Krzyzewskinator 
           0, 0, 0, 0,   2, 0, 0, 1,   0, 0, 0, 0,   3, 0, 0, 1;  ... User 2 ZoeYeo
           0, 0, 0, 0,   4, 0, 0, 0,   0, 1, 0, 0,   0, 1, 0, 2;  ... User 3 Grayson's Anatomy
           0, 0, 0, 0,   2, 0, 0, 0,   0, 2, 0, 0,   0, 1, 0, 3;  ... User 4 ESPNFAN0712522401 1
           0, 0, 0, 0,   3, 0, 0, 1,   0, 0, 0, 0,   1, 0, 0, 2;  ... User 5 d00k sucks
           0, 0, 0, 0,   4, 0, 0, 1,   0, 1, 0, 0,   1, 0, 0, 2;  ... User 6 espn39369641 1
           0, 0, 0, 0,   4, 0, 0, 1,   0, 2, 1, 0,   2, 0, 0, 1;  ... User 7 Where's Wisconsin??
           0, 0, 0, 0,   2, 0, 0, 1,   0, 1, 0, 0,   1, 0, 0, 0;  ... User 8 JHDasinger 1
           0, 0, 0, 0,   2, 0, 0, 1,   0, 1, 0, 0,   4, 0, 0, 1;  ... User 9 Court Mandate
           0, 0, 0, 0,   1, 0, 0, 2,   0, 0, 0, 0,   4, 0, 0, 0;  ... User 10 mwcurtis1
           0, 0, 0, 0,   4, 0, 0, 0,   0, 1, 0, 0,   1, 0, 0, 0;  ... User 11 Optimistic appraisal
           0, 0, 0, 0,   4, 0, 0, 0,   0, 3, 0, 0,   0, 0, 0, 0;  ... User 12 MBrunner 1
           0, 0, 0, 0,   3, 0, 0, 1,   0, 1, 0, 0,   1, 0, 0, 2;  ... User 13 Marquette Still Sucks Ben
           0, 0, 0, 0,   1, 0, 0, 2,   0, 0, 0, 0,   1, 0, 0, 3;  ... User 14 Hoops there it is
           0, 0, 0, 0,   0, 2, 0, 1,   0, 1, 0, 0,   0, 0, 0, 4;  ... User 15 Herbie7
           0, 0, 0, 0,   2, 0, 0, 1,   0, 0, 0, 0,   0, 0, 0, 0;  ... User 16 PUKE on Duke
           0, 0, 0, 0,   4, 0, 0, 0,   0, 0, 0, 0,   1, 0, 0, 2;  ... User 17 Brains but no game
           0, 0, 0, 0,   1, 0, 0, 2,   0, 0, 1, 0,   1, 0, 0, 3;  ... User 18 Where are the Badgers?
           0, 0, 0, 0,   0, 2, 1, 0,   0, 0, 0, 0,   4, 0, 0, 0;  ... User 19 broken bracket
           0, 1, 0, 0,   2, 0, 0, 0,   0, 0, 0, 0,   3, 0, 0, 1;  ... User 20 Jabaisbattad
           0, 0, 0, 0,   1, 0, 0, 2,   0, 2, 1, 0,   1, 0, 0, 4;  ... User 21 Shockers and Awe
           0, 0, 0, 0,   1, 0, 0, 0,   0, 1, 0, 0,   0, 0, 0, 4;  ... User 22 Marq > Madison
           0, 0, 0, 0,   3, 0, 0, 1,   0, 0, 1, 0,   1, 0, 0, 0;  ... User 23 Airball so hard
           0, 0, 0, 0,   2, 0, 0, 1,   0, 0, 0, 0,   1, 0, 0, 4;  ... User 24 Arizona's 100K investment
           0, 0, 0, 0,   1, 0, 0, 4,   0, 0, 0, 0,   1, 0, 0, 0;  ... User 25 Northwestern would've won
           0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   1, 0, 0, 0;  ... User 26 no win, only lose
          ]; 

%% Calculate prediction table
% 1 where predict winner, 0 elsewhere
pred=zeros(4,16,size(UserPred,1));
for entry=1:size(UserPred,1)
    for team=1:size(UserPred,2)
        if UserPred(entry,team)>0
            pred(1:UserPred(entry,team),team,entry)=1;
        end
    end
end

%% Generate all possible tournament outcomes
S16table= dec2bin(0:(2^8-1)) - '0'; % Binary table
S16(:,1:2:16)=S16table; % Set odd columns
S16(:,2:2:16)=abs(S16table-1); % Set even columns to opposite of their pair

E8table=dec2bin(0:(2^4-1)) - '0';
E8(:,1:2:8)=E8table;
E8(:,2:2:8)=abs(E8table-1);

F4table=dec2bin(0:(2^2-1)) - '0';
F4(:,1:2:4)=F4table;
F4(:,2:2:4)=abs(F4table-1);

C1=[0,1;1,0];

% calculate step sizes
e_jump=size(S16,1);
f_jump=size(E8,1)*size(S16,1);
c_jump=size(F4,1)*size(E8,1)*size(S16,1);

outcome=zeros(4,16,2^15);

for c_ind=1:size(C1,1)
    for f_ind=1:size(F4,1)
        for e_ind=1:size(E8,1)
            for s_ind=1:size(S16,1)
                outcome(1,:,s_ind:e_jump:size(outcome,3))=repmat(S16(s_ind,:),[1 1 size(outcome,3)/e_jump]);
                outcome(2,outcome(1,:,s_ind+(e_ind-1)*e_jump)==1,s_ind+(e_ind-1)*e_jump:f_jump:end)=repmat(E8(e_ind,:),[1 1 size(outcome,3)/f_jump]);
                outcome(3,outcome(2,:,s_ind+(e_ind-1)*e_jump+(f_ind-1)*f_jump)==1,s_ind+(e_ind-1)*e_jump+(f_ind-1)*f_jump:c_jump:end)=repmat(F4(f_ind,:),[1 1 size(outcome,3)/c_jump]);
                outcome(4,outcome(3,:,s_ind+(e_ind-1)*e_jump+(f_ind-1)*f_jump+(c_ind-1)*c_jump)==1,s_ind+(e_ind-1)*e_jump+(f_ind-1)*f_jump+(c_ind-1)*c_jump)=C1(c_ind,:);
            end
        end
    end
end
    
%% Calc the points for each outcome
round_weight=repmat([40;80;160;320],[1 16 size(outcome,3)]); % points for each round (S16 win = 40pts, etc)
score=zeros(2^15,size(pred,3));
for entry=1:size(pred,3)
    pred_tmp=repmat(pred(:,:,entry),[1 1 size(outcome,3)]);
    score(:,entry)=sum(sum(pred_tmp.*outcome.*round_weight))+initialScore(entry);
end

%% Compare scores of different brackets
max_score=max(score,[],2); % Best score for each tourney outcome

total_out=zeros(1,size(pred,3)); % Total wins

for i=1:size(score,1)
    winners=find(score(i,:)==max_score(i)); % find brackets that have best score
    total_out(winners)=total_out(winners)+1; % +1 to the winning brackets
end

%% Calculate probabilities
prob=zeros(size(pred,3),1);

for i=1:size(pred,3)
    prob(i,1)=round(total_out(i)/size(max_score,1)*100,2);
end

%% Output results: 
Result=table(entry_name,prob)


