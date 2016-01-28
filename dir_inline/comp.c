int32_t comp (int64_t i64) {
    int32_t v;
    int a,b;

    a = (int32_t)((i64<<32)>>32);
    b = (int32_t)(i64>>32);

    v = a + b;
    if (a > b)
        v = v + 42;
    return v * 3;
}

