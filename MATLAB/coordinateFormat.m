function [r, c, v] = coordinateFormat(A)
[~,n] = size(A);
pos = 1;
for i = 1:n %Move over the rows (top to bottom)
    for j = i:n %Move over the columns (keeping above the main diagonal)
        if(A(i,j) ~= 0) 
            r(pos) = i;
            c(pos) = j;
            v(pos) = A(i,j);
            pos = pos + 1;
        end
    end 
end

end