function [x,y,z] = my_fun_fitness(v)%
dist =  (100);

t = (dist/v);

 x = (0.5*t)-(30/t)*(exp(-(t/20)))+ (0.3 * v * v *t);
 y = t;
 z = dist;
end
 
