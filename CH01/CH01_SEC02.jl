### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 044e23d8-921e-11eb-1aed-a38e702cb35f
begin
	using Plots
	using Images
	using LinearAlgebra
end

# ╔═╡ 404b698c-9236-11eb-08a4-733b54767e4b
md"# Chapter 1 Section 2"

# ╔═╡ b735edd8-9222-11eb-0e93-19364b40d89c
begin
	img = load("../data/dog.jpg")
	X = convert(Array{Float64}, Gray.(img))
	plot(img, axis=nothing)
end

# ╔═╡ bc4b9b00-9223-11eb-25c2-5b0c4163f1e6
begin
	(U, Σ, V) = svd(X, full=false)
	S = Diagonal(Σ)
	Vt = V'
	rs = [length(Σ), 5, 20, 100]
	p_1 = plot(layout=length(rs), size=(600, 600))
	for i ∈ 1:length(rs)
		r = rs[i]
		Xapprox = U[:, 1:r] * S[1:r, 1:r] * Vt[1:r, :]
		plot!(p_1[i], Gray.(Xapprox), axis=nothing)
		percentage = round(r*100/length(Σ), digits=2)
		title!(p_1[i], "r=$(r) $(percentage)%")
		
	end
	p_1
end

# ╔═╡ 34415a2c-922f-11eb-2664-f36e406821e4
md"## Chapter 1 Exercise 2/2"

# ╔═╡ 39c5ada8-9230-11eb-30c1-6de256945308
begin
	
	p_2 = plot(layout=2, legend=false)
	plot!(p_2[1], Σ, yaxis=:log)
	title!(p_2[1], "Singular Values")
	
	plot!(p_2[2], cumsum(Σ) ./ sum(Σ))
	title!(p_2[2], "Singular Values:\nCumulative Sum")
	p_2
end

# ╔═╡ Cell order:
# ╟─404b698c-9236-11eb-08a4-733b54767e4b
# ╠═044e23d8-921e-11eb-1aed-a38e702cb35f
# ╠═b735edd8-9222-11eb-0e93-19364b40d89c
# ╠═bc4b9b00-9223-11eb-25c2-5b0c4163f1e6
# ╟─34415a2c-922f-11eb-2664-f36e406821e4
# ╠═39c5ada8-9230-11eb-30c1-6de256945308
