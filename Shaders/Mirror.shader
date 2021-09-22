/* 
This shader is under MIT license.
*/
shader_type canvas_item;

uniform float x_mirror = 0.5;
uniform float x_offset = 0.0;

void fragment() 
{
	float x_mirror_offset = x_offset + (1.0 - x_offset) * x_mirror;
	vec2 screen_sample_uv = vec2(UV);
	if (screen_sample_uv.x > x_mirror_offset){
		screen_sample_uv.x = x_mirror_offset - (screen_sample_uv.x - x_mirror_offset);
	}
	vec3 screen_col = texture(TEXTURE, screen_sample_uv).rgb;
	COLOR.rgb = screen_col;
}