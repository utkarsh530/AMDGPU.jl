# generated by hand ;(

function rocblas_get_version_string()
    vec = zeros(UInt8, 64)
    str = reinterpret(Cstring, pointer(vec))
    ccall((:rocblas_get_version_string, librocblas), rocblas_status_t, (Cstring, Csize_t), str, 64)
    return unsafe_string(str)
end
function rocblas_pointer_to_mode(ptr)
    ccall((:rocblas_pointer_to_mode, librocblas), rocblas_pointer_mode_t, (Ptr{Cvoid},), ptr)
end
function rocblas_create_handle()
    handle = Ref{rocblas_handle}()
    ccall((:rocblas_create_handle, librocblas), rocblas_status_t, (Ptr{rocblas_handle},), handle)
    return handle[]
end
function rocblas_destroy_handle(handle)
    ccall((:rocblas_destroy_handle, librocblas), rocblas_status_t, (rocblas_handle,), handle)
end
function rocblas_add_stream(handle, stream)
    ccall((:rocblas_add_stream, librocblas), rocblas_status_t, (rocblas_handle, hipStream_t), handle, stream)
end
function rocblas_set_stream(handle, stream)
    ccall((:rocblas_set_stream, librocblas), rocblas_status_t, (rocblas_handle, hipStream_t), handle, stream)
end
function rocblas_get_stream(handle)
    stream = Ref{hipStream_t}()
    ccall((:rocblas_get_stream, librocblas), rocblas_status_t, (rocblas_handle, Ptr{hipStream_t}), handle, stream)
    return stream[]
end
function rocblas_set_pointer_mode(handle, pointer_mode)
    ccall((:rocblas_set_pointer_mode, librocblas), rocblas_status_t, (rocblas_handle, rocblas_pointer_mode_t), handle, pointer_mode)
end
function rocblas_get_pointer_mode(handle)
    pointer_mode = Ref{rocblas_pointer_mode_t}()
    ccall((:rocblas_get_pointer_mode, librocblas), rocblas_status_t, (rocblas_handle, Ptr{rocblas_pointer_mode_t}), handle, pointer_mode)
    return pointer_mode[]
end

#= TODO: I don't know if these are really important...
function rocblas_set_vector()
    ccall((:rocblas_set_vector, librocblas), rocblas_status_t, n::rocblas_int_t, elem_size::rocblas_int_t, x::Ptr{Cvoid}, incx::rocblas_int_t, y::Ptr{Cvoid}, incy::rocblas_int_t)
end
function rocblas_get_vector()
    ccall((:rocblas_get_vector, librocblas), rocblas_status_t, n::rocblas_int_t, elem_size::rocblas_int_t, x::Ptr{Cvoid}, incx::rocblas_int_t, y::Ptr{Cvoid}, incy::rocblas_int_t)
end
function rocblas_set_matrix()
    ccall((:rocblas_set_matrix, librocblas), rocblas_status_t, rows::rocblas_int_t, cols::rocblas_int_t, elem_size::rocblas_int_t, a::Ptr{Cvoid}, lda::rocblas_int_t, b::Ptr{Cvoid}, ldb::rocblas_int_t)
end
function rocblas_get_matrix()
    ccall((:rocblas_get_matrix, librocblas), rocblas_status_t, rows::rocblas_int_t, cols::rocblas_int_t, elem_size::rocblas_int_t, a::Ptr{Cvoid}, lda::rocblas_int_t, b::Ptr{Cvoid}, ldb::rocblas_int_t)
end
=#

## Level 1 BLAS
# TODO: Ensure ROCArray eltypes match BLAS call
# TODO: Complex

function rocblas_dscal(handle, n, alpha::Cdouble, x::ROCArray, incx)
    ref_alpha = Ref(alpha)
    GC.@preserve ref_alpha begin
        @check ccall((:rocblas_dscal, librocblas),
                     rocblas_status_t,
                     (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int),
                     handle, n, ref_alpha, pointer(x), incx)
    end
end
function rocblas_sscal(handle, n, alpha::Cfloat, x::ROCArray, incx)
    ref_alpha = Ref(alpha)
    GC.@preserve ref_alpha begin
        @check ccall((:rocblas_sscal, librocblas),
                     rocblas_status_t,
                     (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int),
                     handle, n, ref_alpha, pointer(x), incx)
    end
end

function rocblas_dcopy(handle, n, x::ROCArray, incx, y::ROCArray, incy)
    @check ccall((:rocblas_dcopy, librocblas),
                 rocblas_status_t,
                 (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int),
                 handle, n, pointer(x), incx, pointer(y), incy)
end
function rocblas_scopy(handle, n, x::ROCArray, incx, y::ROCArray, incy)
    @check ccall((:rocblas_scopy, librocblas),
                 rocblas_status_t,
                 (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int),
                 handle, n, pointer(x), incx, pointer(y), incy)
end

function rocblas_ddot(handle, n, x::ROCArray, incx, y::ROCArray, incy, result)
    @check ccall((:rocblas_ddot, librocblas),
                 rocblas_status_t,
                 (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}),
                 handle, n, pointer(x), incx, pointer(y), incy, result)
end
function rocblas_sdot(handle, n, x::ROCArray, incx, y::ROCArray, incy, result)
    @check ccall((:rocblas_sdot, librocblas),
                 rocblas_status_t,
                 (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}),
                 handle, n, pointer(x), incx, pointer(y), incy, result)
end

function rocblas_dswap(handle, n, x::ROCArray, incx, y::ROCArray, incy)
    @check ccall((:rocblas_dswap, librocblas),
                 rocblas_status_t,
                 (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int),
                 handle, n, pointer(x), incx, pointer(y), incy)
end
function rocblas_sswap(handle, n, x::ROCArray, incx, y::ROCArray, incy)
    @check ccall((:rocblas_sswap, librocblas),
                 rocblas_status_t,
                 (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int),
                 handle, n, pointer(x), incx, pointer(y), incy)
end

## Level 2 BLAS

function rocblas_dgemv(handle, trans::rocblas_operation_t, m::rocblas_int, n::rocblas_int, alpha::Cdouble, A::ROCMatrix, lda::rocblas_int, x::ROCVector, incx::rocblas_int, beta::Cdouble, y::ROCVector, incy::rocblas_int)
    ref_alpha = Ref(alpha)
    ref_beta = Ref(beta)
    GC.@preserve ref_alpha ref_beta begin
        @check ccall((:rocblas_dgemv, librocblas),
                     rocblas_status_t,
                     (rocblas_handle, rocblas_operation_t, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble},rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int),
                     handle, trans, m, n, ref_alpha, pointer(A), lda, pointer(x), incx, ref_beta, pointer(y), incy)
    end
end
function rocblas_sgemv(handle, trans::rocblas_operation_t, m::rocblas_int, n::rocblas_int, alpha::Cfloat, A::ROCMatrix, lda::rocblas_int, x::ROCVector, incx::rocblas_int, beta::Cfloat, y::ROCVector, incy::rocblas_int)
    ref_alpha = Ref(alpha)
    ref_beta = Ref(beta)
    GC.@preserve ref_alpha ref_beta begin
        @check ccall((:rocblas_sgemv, librocblas),
                     rocblas_status_t,
                     (rocblas_handle, rocblas_operation_t, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat},rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int),
                     handle, trans, m, n, ref_alpha, pointer(A), lda, pointer(x), incx, ref_beta, pointer(y), incy)
    end
end

function rocblas_sgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    @check ccall((:rocblas_sgemm, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_dgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    @check ccall((:rocblas_dgemm, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_hgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    @check ccall((:rocblas_hgemm, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_cgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    @check ccall((:rocblas_cgemm, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    @check ccall((:rocblas_zgemm, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_sgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    @check ccall((:rocblas_sgemm_batched, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_dgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    @check ccall((:rocblas_dgemm_batched, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_hgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    @check ccall((:rocblas_hgemm_batched, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_half}, Ptr{Ptr{rocblas_half}}, rocblas_int, Ptr{Ptr{rocblas_half}}, rocblas_int, Ptr{rocblas_half}, Ptr{Ptr{rocblas_half}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_cgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    @check ccall((:rocblas_cgemm_batched, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    @check ccall((:rocblas_zgemm_batched, librocblas), rocblas_status_t, (rocblas_handle, rocblas_operation_t, rocblas_operation_t, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end
