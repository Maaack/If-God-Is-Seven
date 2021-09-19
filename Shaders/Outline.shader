shader_type canvas_item;
render_mode unshaded;

uniform vec4 outline_color : hint_color;

void fragment() 
{
	vec4 final_color = texture(TEXTURE, UV);

	for(int x = -1; x <= 1; x += 1){
		for(int y = -1; y <= 1; y += 1){
				
			vec2 offset_uv = vec2(float(x) * TEXTURE_PIXEL_SIZE.x, float(y) * TEXTURE_PIXEL_SIZE.y);
			vec2 outline_uv = offset_uv + UV;

			vec4 outline_sample = texture(TEXTURE, outline_uv);
			if(outline_uv.x < 0.0 || outline_uv.x > 1.0 || outline_uv.y < 0.0 || outline_uv.y > 1.0){
				outline_sample = vec4(0);
			}
			
			if(outline_sample.a > final_color.a){
				final_color = outline_color;
			}
		}
	}
	COLOR = final_color;
}