function[Pk] = productionPressureStrain(u1mean, y, uv1f2_avg, v1f2_avg,u1f, v1f, p1f, dx )

[dudy] = gradient(u1mean, y);
Pk = -1.*uv1f2_avg.*dudy;

end