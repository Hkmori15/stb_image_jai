#run {
    set_build_options_dc(.{ do_output = false });
    set_working_directory(#filepath);

    build_dir := "build";
    ensure_dir := make_directory_if_it_does_not_exist(build_dir, recursive = true);
    assert(ensure_dir, "Cannot create build dir");

    impl_source := tprint("%/stb_image_impl.c", build_dir);
    impl_lib := tprint("%/libstb_image", build_dir);
    impl_text := "#define STB_IMAGE_IMPLEMENTATION\n#include \"../include/stb_image.h\"\n";
    assert(write_entire_file(impl_source, impl_text));

    // Build static lib for native build and shared one for `jaic -interp` that can load foreign symbols too
    assert(build_cpp_static_lib(impl_lib, impl_source));
    assert(build_cpp_dynamic_lib(impl_lib, impl_source));

    opt: B.Generate_Bindings_Options;

    array_add(*opt.source_files, "include/stb_image.h");
    array_add(*opt.libraries, B.Library.{ "build/libstb_image", "stb_image" });

    opt.generate_compile_time_struct_checks = false;
    opt.add_generator_command = false;
    opt.header = "// Generated bindings for stb_image. Regenerate with: jai [jaic] generate.jai\n\n// Opaque stdio stream type used by the *_from_file entry points.\nFILE :: struct {};\n\n";
    assert(B.generate_bindings(opt, "bindings.jai"));

    // `generate_bindings` can be successfull while stripping every procedure (func) if it cannot inspect native lib
    // Make that failure loud
    bindings, read_ok := read_entire_file("bindings.jai");
    assert(read_ok);

    defer free(bindings);
    assert(contains(bindings, "stbi_load ::"));
    assert(contains(bindings, "stbi_load_from_memory ::"));
    assert(contains(bindings, "stbi_io_callbacks ::"));
    assert(contains(bindings, "STBI :: enum"));
    print("Gen bindings.jai and stb_image lib\n");
}

#import "Basic";
#import "BuildCpp";
#import "Compiler";
#import "File";
#import "String";
B :: #import "Bindings_Generator";
