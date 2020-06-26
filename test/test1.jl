using Test

try
@testset "Testing solution to Q1" begin
   @test (q1_root1 == 1 && q1_root2 == 2) || (q1_root1 == 2 && q1_root2 == 1)
end; # Q1
catch
end

try
@testset "Testing solution to Q2" begin
   @test vertex(1,-3,2).x ≈ 1.5
   @test vertex(1,-3,2).y ≈ -0.25
   @test vertex(1,-3,4).x ≈ 1.5
   @test vertex(1,-3,4).y ≈ 1.75
   @test vertex(2,-3,2.125).x ≈ 0.75
   @test vertex(2,-3,2.125).y ≈ 1.0
end; # Exercise 2
catch
end

