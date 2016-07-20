function D = straightline(x, choice)

f=im2double(x);

H=[-1 -1 -1; 2 2 2;-1 -1 -1]; % Filter to find horizontal lines
V=[-1 2 -1;-1 2 -1;-1 2 -1];  % Filter to find vertical lines

switch choice
    case 1
        D=imfilter(f,H);
    case 2
        D=imfilter(f,V);
    otherwise
        display('\nWrong Choice\n');
end
