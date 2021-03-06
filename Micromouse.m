% Stage 4 Micromouse Project
% Modified Flood Fill Algorithm
% Last updated 23/02/2005
% Clear memory and screen
clear
clc
% Define initial variables
% Built in test maze
testmazen=[1,1,1,1,1,1,1,1,1,1,1,1,1;
1,1,1,1,1,1,1,1,0,0,0,1,0;
0,1,1,1,1,1,1,1,0,0,1,1,0;
0,0,1,1,1,1,1,0,0,0,1,0,0;
0,1,0,1,1,1,1,0,0,1,0,1,0;
1,1,0,1,1,1,1,1,0,0,1,1,0;
0,0,0,1,1,0,0,0,1,0,0,0,0;
0,0,0,0,1,1,0,1,0,1,0,0,0;
0,1,0,0,0,0,1,1,1,0,1,0,0;
0,0,1,0,0,1,1,1,1,1,0,0,0;
0,1,0,0,0,0,1,1,1,1,1,0,0;
0,1,1,0,0,0,1,1,1,1,0,0,0;
0,1,1,1,0,1,1,1,1,1,1,1,0];

testmazee=[0,0,0,0,0,0,0,0,0,1,0,0,1;
0,0,0,0,0,0,0,0,1,1,0,1,1;
1,0,0,0,0,0,0,1,1,0,0,1,1;
1,1,0,0,0,0,0,1,1,1,0,0,1;
0,0,1,0,0,0,0,1,1,0,0,1,1;
0,1,0,0,1,0,1,0,1,1,0,1,1;
1,1,1,0,0,0,1,1,0,1,1,1,1;
1,1,1,1,0,1,0,0,1,0,1,1,1;
1,0,1,1,1,0,0,0,0,1,0,1,1;
0,1,1,1,1,0,0,0,0,0,1,1,1;
0,0,1,1,1,0,0,0,0,0,1,1,1;
0,0,0,1,1,0,0,0,0,0,0,1,1;
1,0,0,0,0,0,0,0,0,0,0,0,1];

% Initial Floodfill Values
ffv=[10,9,8,7,6,5,5,6,7,8,9,10,11;
      9,8,7,6,5,4,4,5,6,7,8,9,10;
      8,7,6,5,4,3,3,4,5,6,7,8,9;
      7,6,5,4,3,2,2,3,4,5,6,7,8;
      6,5,4,3,2,1,1,2,3,4,5,6,7;
      5,4,3,2,1,0,0,1,2,3,4,5,6;
      5,4,3,2,1,0,0,1,2,3,4,5,6;
      6,5,4,3,2,1,1,2,3,4,5,6,7;
      7,6,5,4,3,2,2,3,4,5,6,7,8;
      8,7,6,5,4,3,3,4,5,6,7,8,9;
      9,8,7,6,5,4,4,5,6,7,8,9,10;
     10,9,8,7,6,5,5,6,7,8,9,10,11;
    11,10,9,8,7,6,6,7,8,9,10,11,12];

x=1; %Start x value
y=13; %Start y value
middle=0; %In middle? 0-no 1-yes
no=1; %Initial count of times around main loop
visited=zeros(13,13); %Define all cells as unvisited
examine=zeros(13,13); %Define no cells for floodfill analysis
flag=zeros(13,13); %Define no cells to be initially flagged
orientation=00; %Orientation 00-North, 01-East, 11-South, 10-West
graphy(no)=1; %Y component for graph
graphx(no)=1; %X component for graph
clean=zeros(13,13);

% Choose input method
select=0;
while select~=1 & select~=2
select=input('Enter wall data manually-1, or use test maze-2? ');
end

% Start main programme
while middle~=1 %While the middle has not been found
no=no+1; %Count number of times around loop

% Output current cell
disp('-----------------------------------------------------------------')
disp('x = ')
disp(x)
disp('y = ')
disp(y)
disp('Current floodfill = ')
disp(ffv(y,x))

%Enter wall data 1= wall, 0= no wall from sensors
if y==1 %If next to north boundry
n=1; %Set north wall as 1
elseif orientation==11 %If travveling south ie from north
n=0; %Set north wall as 0
elseif visited(y,x)==1 %if the cell to be examined has already been visited
n=northwall(y,x); %Look up wall map from memory
else
if select==2 %If test maze is being used
n=testmazen(y,x); %Retrieve n from test maze
elseif select==1 %If manual data input
n=2;
while n~=0 & n~=1
n=input('North wall, 0 or 1 = '); %If the wall is not known enter it here
end
end
end

if y==13
s=1;
elseif orientation==00
s=0;
elseif visited(y,x)==1
s=southwall(y,x);
else
if select==2
s=testmazen(y+1,x);
elseif select==1
s=2;
while s~=0 & s~=1
s=input('South wall, 0 or 1 = ');
end
end
end

if x==13
e=1;
elseif orientation==10
e=0;
elseif visited(y,x)==1
e=eastwall(y,x);
else
if select==2
e=testmazee(y,x);
elseif select==1
e=2;
while e~=0 & e~=1
e=input('East wall, 0 or 1 = ');
end
end
end

if x==1
w=1;
elseif orientation==01
w=0;
elseif visited(y,x)==1
w=westwall(y,x);
else
if select==2
w=testmazee(y,x-1);
elseif select==1
w=2;
while w~=0 & w~=1
w=input('West wall, 0 or 1 = ');
end
end
end

% Mark current cell as visited
visited(y,x)=1;

% Records the walls into the map
northwall(y,x)= n;
eastwall(y,x)=e;
southwall(y,x)=s;
westwall(y,x)=w;

% Examine the walls and determine the way to go
waytogo=[200 200 200 200]; %Inital surrounding floodfill values set high
if n==0 %If there is no noth wall
waytogo(1)=ffv(y-1,x); %Set a posible way to go as the floodfill value to the north
if ffv(y-1,x)==0 %If the northern fllodfill is 0
middle=1; %Middle found
end
end
if e==0
waytogo(2)=ffv(y,x+1);
if ffv(y,x+1)==0
middle=1;
end
end
if s==0
waytogo(3)=ffv(y+1,x);
if ffv(y+1,x)==0
middle=1;
end
end
if w==0
waytogo(4)=ffv(y,x-1);
if ffv(y,x-1)==0
middle=1;
end
end

% This section counts the possible unvisited ways to move from the
% current cell
wayuv=0;
if n==0 & visited(y-1,x)==0
wayuv=wayuv+1;
end
if e==0 & visited(y,x+1)==0
wayuv=wayuv+1;
end
if s==0 & visited(y+1,x)==0
wayuv=wayuv+1;
end
if w==0 & visited(y,x-1)==0
wayuv=wayuv+1;
end

% If there is more than one unvisited way to go the cell has multiple
% paths emerging from it and a flag is set
if wayuv>1
flag(y,x)=1;
disp('Cell flag set because it has more than one unvisited path')
end

% If a currently flagged cell is revisited the number of unvisited
% paths will reduce therefore the flag is removed
if wayuv<=1 & flag(y,x)==1
flag(y,x)=0;
disp('Cell flag removed')
end

% This section counts the number of ways possible to move whether
% visited or not
way=0;
if n==0
way=way+1;
end
if e==0
way=way+1;
end
if s==0
way=way+1;
end
if w==0
way=way+1;
end

% This section moves the mouse inbetween cells
% Define no initial movement
movenorth=0;
moveeast=0;
movesouth=0;
movewest=0;

m=min(waytogo); %Determine minimum flood fill value

% If there is only one way out of the current cell it is a dead end
deadend=0;
if way==1
if x~=1 | y~=13 %If not in starting cell
disp('Dead end')
deadend=1;
end
% If in a dead end set movement to only way yo go
if n==0
movenorth=1;
elseif e==0
moveeast=1;
elseif s==0
movesouth=1;
elseif w==0
movewest=1;
end
end

% Set ways to move
if y~=1 %If not on northern boundry of maze
if ffv(y-1,x)==m & n==0 %If the north floodfill value is the lowest set it as a possible way to move
movenorth=1;
end
end

if x~=13
if ffv(y,x+1)==m & e==0
moveeast=1;
end
end

if y~=13
if ffv(y+1,x)==m & s==0
movesouth=1;
end
end

if x~=1
if ffv(y,x-1)==m & w==0
movewest=1;
end
end


% If there is more than one way to go this section selects the current
% direction to avoid cornering if possible
if (movenorth+moveeast+movesouth+movewest)>1
disp('More than one way to go')

if orientation==00 & movenorth==1
movenorth=1;
moveeast=0;
movesouth=0;
movewest=0;
end

if orientation==01 & moveeast==1
movenorth=0;
moveeast=1;
movesouth=0;
movewest=0;
end

if orientation==11 & movesouth==1
movenorth=0;
moveeast=0;
movesouth=1;
movewest=0;
end

if orientation==10 & movewest==1
movenorth=0;
moveeast=0;
movesouth=0;
movewest=1;
end
end

% If the previous section is unsucessfull do this one, sets the way to
% go as any unvisited way
if (movenorth+moveeast+movesouth+movewest)~=1
if n==0
if visited(y-1,x)==0 & movenorth==1
movenorth=1;
moveeast=0;
movesouth=0;
movewest=0;
end
end

if e==0
if visited(y,x+1)==0 & moveeast==1
movenorth=0;
moveeast=1;
movesouth=0;
movewest=0;
end
end

if s==0
if visited(y+1,x)==0 & movesouth==1
movenorth=0;
moveeast=0;
movesouth=1;
movewest=0;
end
end

if w==0
if visited(y,x-1)==0 & movewest==1
movenorth=0;
moveeast=0;
movesouth=0;
movewest=1;
end
end
end

% If the previous section is unsucessfull do this one, sets the way to
% go as any possible
if (movenorth+moveeast+movesouth+movewest)~=1
if n==0
if visited(y-1,x)==1 & movenorth==1
movenorth=1;
moveeast=0;
movesouth=0;
movewest=0;
end
end

if e==0
if visited(y,x+1)==1 & moveeast==1
movenorth=0;
moveeast=1;
movesouth=0;
movewest=0;
end
end

if s==0
if visited(y+1,x)==1 & movesouth==1
movenorth=0;
moveeast=0;
movesouth=1;
movewest=0;
end
end

if w==0
if visited(y,x-1)==1 & movewest==1
movenorth=0;
moveeast=0;
movesouth=0;
movewest=1;
end
end
end

if m>=ffv(y,x) %If minimum flood fill value is greater than or equal to current
ffv(y,x)=m+1; %Update current floodfill value to 1+minimum surrounding
examine(y,x)=1; %Set cell to be examined in the update floodfills section
if deadend==1 %If
examine(y,x)=0;
end
end

if wayuv==0 %If there is no unvisited ways to go
examine(y,x)=0; %The current cell doesn't require examination
end

% This section updates the flood fills if the current flood fill is
% required to change
if middle==1
flag=zeros(13,13);
examine(y,x)=1;
end
examined=zeros(13,13); %Set all cells as unexamined
if examine(y,x)==1 | deadend==1
for jm=1:200
for yy=1:13
for xx=1:13
if examine(yy,xx)==1 | flag(yy,xx)==1
if examined(yy,xx)==0
if northwall(yy,xx)==0
if visited(yy-1,xx)==1 & examined(yy-1,xx)==0 & flag(yy-1,xx)==0
ffv(yy-1,xx)=ffv(yy,xx)+1;
examine(yy-1,xx)=1;
end
end

if eastwall(yy,xx)==0
if visited(yy,xx+1)==1 & examined(yy,xx+1)==0 & flag(yy,xx+1)==0
ffv(yy,xx+1)=ffv(yy,xx)+1;
examine(yy,xx+1)=1;
end
end

if southwall(yy,xx)==0
if visited(yy+1,xx)==1 & examined(yy+1,xx)==0 & flag(yy+1,xx)==0
ffv(yy+1,xx)=ffv(yy,xx)+1;
examine(yy+1,xx)=1;
end
end

if westwall(yy,xx)==0
if visited(yy,xx-1)==1 & examined(yy,xx-1)==0 & flag(yy,xx-1)==0
ffv(yy,xx-1)=ffv(yy,xx)+1;
examine(yy,xx-1)=1;
end
end
end
examined(yy,xx)=1;
examine(yy,xx)=0;
end
end
end
end
end

% This section moves the mouse into the next cell and updates x and y
if movenorth==1
disp('Moving North to floodfill')
disp(ffv(y-1,x))
y=y-1;
%Update the values to plot the graph
graphy(no)=graphy(no-1)+1;
graphx(no)=graphx(no-1);
%Update orientation
orientation=00;
end

if moveeast==1
disp('Moving east to floodfill')
disp(ffv(y,x+1))
x=x+1;
graphy(no)=graphy(no-1);
graphx(no)=graphx(no-1)+1;
orientation=01;
end

if movesouth==1
disp('Moving South to floodfill')
disp(ffv(y+1,x))
y=y+1;
graphy(no)=graphy(no-1)-1;
graphx(no)=graphx(no-1);
orientation=11;
end

if movewest==1
disp('Moving West to floodfill')
disp(ffv(y,x-1))
x=x-1;
graphy(no)=graphy(no-1);
graphx(no)=graphx(no-1)-1;
orientation=10;
end

% If the middle is found output a message
if middle==1
disp('Middle found!')
end
end


% Take fastest route to middle
x=1;
y=13;
middle=0;
visited(6,6)=1;
visited(6,7)=1;
visited(7,7)=1;
visited(7,6)=1;
nof=1;
graphyf(nof)=1;
graphxf(nof)=1;
while middle==0
nof=nof+1;
clean(y,x)=1;
waytogo=[200 200 200 200];
if northwall(y,x)==0
if visited(y-1,x)==1
waytogo(1)=ffv(y-1,x);
if ffv(y-1,x)==0
middle=1;
end
end
end
if eastwall(y,x)==0
if visited(y,x+1)==1
waytogo(2)=ffv(y,x+1);
if ffv(y,x+1)==0
middle=1;
end
end
end
if southwall(y,x)==0
if visited(y+1,x)==1
waytogo(3)=ffv(y+1,x);
if ffv(y+1,x)==0
middle=1;
end
end
end
if westwall(y,x)==0
if visited(y,x-1)==1
waytogo(4)=ffv(y,x-1);
if ffv(y,x-1)==0
middle=1;
end
end
end

m=min(waytogo);

% Set ways to move
movenorth=0;
moveeast=0;
movesouth=0;
movewest=0;
if y~=1 %If not on northern boundry of maze
if ffv(y-1,x)==m & northwall(y,x)==0 %If the north floodfill value is the lowest set it as a possible way to move
movenorth=1;
end
end

if x~=13
if ffv(y,x+1)==m & eastwall(y,x)==0
moveeast=1;
end
end

if y~=13
if ffv(y+1,x)==m & southwall(y,x)==0
movesouth=1;
end
end

if x~=1
if ffv(y,x-1)==m & westwall(y,x)==0
movewest=1;
end
end

% This section moves the mouse into the next cell and updates x and y
if movenorth==1
disp('Moving North to floodfill')
disp(ffv(y-1,x))
y=y-1;
%Update the values to plot the graph
graphyf(nof)=graphyf(nof-1)+1;
graphxf(nof)=graphxf(nof-1);
end

if moveeast==1
disp('Moving east to floodfill')
disp(ffv(y,x+1))
x=x+1;
graphyf(nof)=graphyf(nof-1);
graphxf(nof)=graphxf(nof-1)+1;
end

if movesouth==1
disp('Moving South to floodfill')
disp(ffv(y+1,x))
y=y+1;
graphyf(nof)=graphyf(nof-1)-1;
graphxf(nof)=graphxf(nof-1);
end

if movewest==1
disp('Moving West to floodfill')
disp(ffv(y,x-1))
x=x-1;
graphyf(nof)=graphyf(nof-1);
graphxf(nof)=graphxf(nof-1)-1;
end

%sams bit
if middle==1
disp('Middle found!')
end
end

middle
pause




while middle==1 & ((y~=13) | (x~=1))
% visited(y,x)=2;

if x>=2 & x<=12 & y<=12 & y>=2
%visited(y,x)=2;
if clean(y-1,x)==1 & visited(y-1,x)==1 & northwall(y,x)==0
y=y-1;
disp('moving north home')
visited(y,x)=2;
end

if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end

if clean(y,x+1)==1 & visited(y,x+1)==1 & eastwall(y,x)==0
x=x+1;
disp('moving east home')
visited(y,x)=2;
end

if clean(y,x-1)==1 & visited(y,x-1)==1 & westwall(y,x)==0
x=x-1;
disp('moving west home')
visited(y,x)=2;
end
end
%end

if x==1 & y~=13 & y~=1
if clean(y-1,x)==1 & visited(y-1,x)==1 & northwall(y,x)==0
y=y-1;
disp('moving north home')
visited(y,x)=2;
end

if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end

if clean(y,x+1)==1 & visited(y,x+1)==1 & eastwall(y,x)==0
x=x+1;
disp('moving east home')
visited(y,x)=2;
end
end

if x==13 & y~=13 & y~=1
if clean(y-1,x)==1 & visited(y-1,x)==1 & northwall(y,x)==0
y=y-1;
disp('moving north home')
visited(y,x)=2;
end

if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end
if clean(y,x-1)==1 & visited(y,x-1)==1 & westwall(y,x)==0
x=x-1;
disp('moving west home')
visited(y,x)=2;
end
end

if y==1 & x~=1 & x~=13
if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end

if clean(y,x+1)==1 & visited(y,x+1)==1 & eastwall(y,x)==0
x=x+1;
disp('moving east home')
visited(y,x)=2;
end

if clean(y,x-1)==1 & visited(y,x-1)==1 & westwall(y,x)==0
x=x-1;
disp('moving west home')
visited(y,x)=2;
end
end

if y==13 & x~=1 & x~=13
if clean(y-1,x)==1 & visited(y-1,x)==1 & northwall(y,x)==0
y=y-1;
disp('moving north home')
visited(y,x)=2;
end

if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end
if clean(y,x-1)==1 & visited(y,x-1)==1 & westwall(y,x)==0
x=x-1;
disp('moving west home')
visited(y,x)=2;
end
end

if x==1 & y==1
if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end

if clean(y,x+1)==1 & visited(y,x+1)==1 & eastwall(y,x)==0
x=x+1;
disp('moving east home')
visited(y,x)=2;
end
end

if x==13 & y==13
if clean(y,x-1)==1 & visited(y,x-1)==1 & westwall(y,x)==0
x=x-1;
disp('moving west home')
visited(y,x)=2;
end
if clean(y-1,x)==1 & visited(y-1,x)==1 & northwall(y,x)==0
y=y-1;
disp('moving north home')
visited(y,x)=2;
end
end

if x==13 & y==1
if clean(y,x-1)==1 & visited(y,x-1)==1 & westwall(y,x)==0
x=x-1;
disp('moving west home')
visited(y,x)=2;
end
if clean(y+1,x)==1 & visited(y+1,x)==1 & southwall(y,x)==0
y=y+1;
disp('moving south home')
visited(y,x)=2;
end
end




end

if y==13 & x==1
disp('done')
end









% Plot map
midx=[6 7 7 6 6];
midy=[7 7 8 8 7];
plot(graphx,graphy,'x-.',midx,midy,'r*-',graphxf,graphyf,'gd:')

% Display statistics
disp('Statistics:- ')
total=sum(sum(visited));
coverage=(total/169)*100;
% disp('Percentage of maze expored:- ')
% disp(coverage)
disp('Number of steps:- ')
disp(no)
disp('Highest floodfill value:- ')
high=max(max(ffv));
disp(high)