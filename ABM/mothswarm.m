clear all
close all

n = 20;
z = randn(1,n)+1i*randn(1,n);
p = 6;
q = 2;
t = 0;
dt = 0.1;
noise_param = 0.1;

q_repulsion = 10;
q_attraction = 2;
repulsion_range = 4;
attraction_range = 6;


while (1 > 0)
  t=t+dt;
  dz=z*0;

  for j=1:n
    k = [1:j-1,j+1:n];
    r = abs(z(j)-z(k));

    % F = 1./r.^p - 1./r.^q;
    F = q_repulsion*(r<repulsion_range)-q_attraction*(r<attraction_range).*(r>repulsion_range);

    dz(j) = 1/n*sum(F.*(z(j)-z(k))./r);
  end

  z = z + dz*dt + noise_param*(randn(1,n)+1i*randn(1,n));

  plot(z,'o')
  % ylim([-2,2])
  % xlim([-2,2])
  axis equal
  title(sprintf('t=%g',t))
  drawnow
end
