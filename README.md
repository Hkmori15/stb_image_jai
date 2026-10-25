# Jai stb_image

Jai stb_image bindings with some modifications in file **module.jai**

## Build
Just:

```bash
jai generate.jai
```

And it's all :D

## API
```jai
load_image :: (path: string, desired_channels := Channel.default) -> Image, bool
load_image_from_memory :: (data: [] u8, desired_channels := Channel.default) -> Image, bool
load_image_16 :: (path: string, desired_channels := Channel.default) -> Image_16, bool
load_image_16_from_memory :: (data: [] u8, desired_channels := Channel.default) -> Image_16, bool
load_image_f32 :: (path: string, desired_channels := Channel.default) -> Image_F32, bool
load_image_f32_from_memory :: (data: [] u8, desired_channels := Channel.default) -> Image_F32, bool
load_gif_from_memory :: (data: [] u8, desired_channels := Channel.default) -> GIF, bool
get_image_info :: (path: string) -> Image_Info, bool
get_image_info_from_memory :: (data: [] u8) -> Image_Info, bool
set_flip_vertically_on_load :: (flip: bool)
set_unpremultiply_on_load :: (unpremultiply: bool)
convert_iphone_png_to_rgb :: (convert: bool)
set_flip_vertically_on_load_thread :: (flip: bool)
set_unpremultiply_on_load_thread :: (unpremultiply: bool)
convert_iphone_png_to_rgb_thread :: (convert: bool)
failure_reason :: () -> string // Borrowed view of `stb_image` static failure string. Do NOT free it
is_hdr :: (path: string) -> bool
is_hdr_from_memory :: (data: [] u8) -> bool
is_16_bit :: (path: string) -> bool
is_16_bit_from_memory :: (data: [] u8) -> bool
free_image :: (image: *$T)
```
