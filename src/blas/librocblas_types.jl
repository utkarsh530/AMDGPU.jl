# generated by hand ;(

using CEnum

# HACK: a shim
const hipStream_t = Ptr{Cvoid}

const rocblas_int = Int32
const rocblas_long = Int64
const rocblas_float_complex = ComplexF32
const rocblas_double_complex = ComplexF64
const rocblas_half = Float16
const rocblas_half_complex = ComplexF32 # wtf???
const rocblas_handle = Ptr{Nothing}

const ROCBLASFloat = Union{Float32,Float64}
const ROCBLASReal = Union{Float32,Float64}
const ROCBLASComplex = Union{ComplexF32,ComplexF64}

@cenum(rocblas_operation_t,
    ROCBLAS_OPERATION_NONE = 111,
    ROCBLAS_OPERATION_TRANSPOSE = 112,
    ROCBLAS_OPERATION_CONJUGATE_TRANSPOSE = 113,
)

@cenum(rocblas_fill_t,
    ROCBLAS_FILL_UPPER = 121,
    ROCBLAS_FILL_LOWER = 122,
    ROCBLAS_FILL_FULL = 123,
)

@cenum(rocblas_diagonal_t,
    ROCBLAS_DIAGONAL_NON_UNIT = 131,
    ROCBLAS_DIAGONAL_UNIT = 132,
)

@cenum(rocblas_side_t,
    ROCBLAS_SIDE_LEFT = 141,
    ROCBLAS_SIDE_RIGHT = 142,
    ROCBLAS_SIDE_BOTH = 143,
)

@cenum(rocblas_status_t,
    ROCBLAS_STATUS_SUCCESS = 0,
    ROCBLAS_STATUS_INVALID_HANDLE = 1,
    ROCBLAS_STATUS_NOT_IMPLEMENTED = 2,
    ROCBLAS_STATUS_INVALID_POINTER = 3,
    ROCBLAS_STATUS_INVALID_SIZE = 4,
    ROCBLAS_STATUS_MEMORY_ERROR = 5,
    ROCBLAS_STATUS_INTERNAL_ERROR = 6,
)

@cenum(rocblas_datatype_t,
    ROCBLAS_DATATYPE_F16_R = 150, # 16 bit floating point, real
    ROCBLAS_DATATYPE_F32_R = 151, # 32 bit floating point, real
    ROCBLAS_DATATYPE_F64_R = 152, # 64 bit floating point, real
    ROCBLAS_DATATYPE_F16_C = 153, # 16 bit floating point, complex
    ROCBLAS_DATATYPE_F32_C = 154, # 32 bit floating point, complex
    ROCBLAS_DATATYPE_F64_C = 155, # 64 bit floating point, complex
    ROCBLAS_DATATYPE_I8_R = 160, # 8 bit signed integer, real
    ROCBLAS_DATATYPE_U8_R = 161, # 8 bit unsigned integer, real
    ROCBLAS_DATATYPE_I32_R = 162, # 32 bit signed integer, real
    ROCBLAS_DATATYPE_U32_R = 163, # 32 bit unsigned integer, real
    ROCBLAS_DATATYPE_I8_C = 164, # 8 bit signed integer, complex
    ROCBLAS_DATATYPE_U8_C = 165, # 8 bit unsigned integer, complex
    ROCBLAS_DATATYPE_I32_C = 166, # 32 bit signed integer, complex
    ROCBLAS_DATATYPE_U32_C = 167, # 32 bit unsigned integer, complex
)

@cenum(rocblas_pointer_mode_t,
    ROCBLAS_POINTER_MODE_HOST = 0,
    ROCBLAS_POINTER_MODE_DEVICE = 1,
)

@cenum(rocblas_layer_mode_t,
    ROCBLAS_LAYER_MODE_NONE = 0b0000000000,
    ROCBLAS_LAYER_MODE_LOG_TRACE = 0b0000000001,
    ROCBLAS_LAYER_MODE_LOG_BENCH = 0b0000000010,
    ROCBLAS_LAYER_MODE_LOG_PROFILE = 0b0000000100,
)

@cenum(rocblas_gemm_algo,
    ROCBLAS_GEMM_ALGO_STANDARD = 0b0000000000,
)
