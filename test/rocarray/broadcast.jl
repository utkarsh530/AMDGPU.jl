@testset "broadcast" begin
  @test testf((x)       -> fill!(x, 1),  rand(3,3))
  @test testf((x, y)    -> map(+, x, y), rand(2, 3), rand(2, 3))
  @test testf((x)       -> sin.(x),      rand(2, 3))
  @test testf((x)       -> log.(x) .+ 1, rand(2, 3))
  @test testf((x)       -> 2x,           rand(2, 3))
  @test testf((x)       -> x .^ 0,      rand(2, 3))
  @test testf((x)       -> x .^ 1,      rand(2, 3))
  @test testf((x)       -> x .^ 2,      rand(2, 3))
  @test testf((x)       -> x .^ 3,      rand(2, 3))
  @test testf((x)       -> x .^ 5,      rand(2, 3))
  @test testf((x)       -> (z = Int32(5); x .^ z),      rand(2, 3))
  @test testf((x)       -> (z = Float64(π); x .^ z),      rand(2, 3))
  @test testf((x)       -> (z = Float32(π); x .^ z),      rand(Float32, 2, 3))
  @test testf((x, y)    -> x .+ y,       rand(2, 3), rand(1, 3))
  @test testf((z, x, y) -> z .= x .+ y,  rand(2, 3), rand(2, 3), rand(2))
  @test (ROCArray{Ptr{Cvoid}}(undef, 1) .= C_NULL) == ROCArray([C_NULL])
  @test ROCArray([1,2,3]) .+ ROCArray([1.0,2.0,3.0]) == ROCArray([2,4,6])

  @eval struct Whatever{T}
      x::Int
  end
  @test Array(Whatever{Int}.(ROCArray([1]))) == Whatever{Int}.([1])
end

# https://github.com/JuliaGPU/CUDA.jl/issues/223
@testset "Ref Broadcast" begin
  foobar(idx, A) = A[idx]
  @test ROCArray([42]) == foobar.(ROCArray([1]), Base.RefValue(ROCArray([42])))
end

@testset "Broadcast Fix" begin
  @test testf(x -> log.(x), rand(3,3))
  @test testf((x,xs) -> log.(x.+xs), Ref(1), rand(3,3))
end

# https://github.com/JuliaGPU/CUDA.jl/issues/261
@testset "Broadcast Ref{<:Type}" begin
  A = ROCArray{ComplexF64}(undef, (2,2))
  @test eltype(convert.(ComplexF32, A)) == ComplexF32
end
