### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ ee17db8a-925f-11eb-1108-79994eb6399d
begin
	using PyPlot
	using LinearAlgebra
end

# ╔═╡ 81030b78-925f-11eb-0994-a3619814b02b
md"# Chapter 1, Section 3: Rotation"

# ╔═╡ eeec95cc-93b4-11eb-14ea-5de72fcd2ff4
begin
	theta = [pi/15, -pi/9, -pi/20]
	Sigma = Diagonal([3, 1, 0.5]) # scale x, then y, then z

	# Rotation about x axis
	Rx = [1 0 0
		  0 cos(theta[1]) -sin(theta[1])
		  0 sin(theta[1]) cos(theta[1])]

	# Rotation about y axis
	Ry = [cos(theta[2]) 0 sin(theta[2])
		  0 1 0
		  -sin(theta[2]) 0 cos(theta[2])]

	# Rotation about z axis
	Rz = [cos(theta[3]) sin(theta[3]) 0
		  sin(theta[3]) cos(theta[3]) 0
		  0 0 1]

	# Rotate and scale
	X = Rz * Ry * Rx * Sigma
end

# ╔═╡ 6d1c0409-8a35-41b9-9f08-3b603d2c6e0e
function plot_surface(x, y, z, cz)
	fig = figure(1)
	clf()
	s = surf(x,y,z, cmap="jet", facecolors=plt.cm.jet(cz), alpha=0.9, linewidth=0.5, rcount=30, ccount=30)
	s[:set_edgecolor]("k")
	ax = gca()
	ax[:set_xlim3d]([-2, 2])
	ax[:set_ylim3d]([-2, 2])
	ax[:set_zlim3d]([-2, 2])
	fig
end

# ╔═╡ a6203bac-93b7-11eb-0b43-d5ab6c2b0eb5
begin
	N = 100
	u = range(-π, stop=π, length=N)
	v = range(0, stop=π, length=N)
	x = cos.(u) .* sin.(v)'
	y = sin.(u) .* sin.(v)'
	z = repeat(cos.(v)', outer=[N, 1])
	plot_surface(x, y, z, z)
end

# ╔═╡ b657eef2-a14a-434b-97e1-846b1fb0dfa5
begin
	xr = copy(x)
	yr = copy(y)
	zr = copy(z)

	for i ∈ 1:size(x)[1]
		for j ∈ 1:size(x)[2]
			vec = [x[i,j], y[i,j], z[i,j]]
			vecR = X * vec
			xr[i,j] = vecR[1]
			yr[i,j] = vecR[2]
			zr[i,j] = vecR[3]
		end
	end
	
	plot_surface(xr, yr, zr, z)
end

# ╔═╡ Cell order:
# ╟─81030b78-925f-11eb-0994-a3619814b02b
# ╠═ee17db8a-925f-11eb-1108-79994eb6399d
# ╠═eeec95cc-93b4-11eb-14ea-5de72fcd2ff4
# ╠═6d1c0409-8a35-41b9-9f08-3b603d2c6e0e
# ╠═a6203bac-93b7-11eb-0b43-d5ab6c2b0eb5
# ╠═b657eef2-a14a-434b-97e1-846b1fb0dfa5
