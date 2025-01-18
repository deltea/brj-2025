shader_type canvas_item;

uniform vec2 aspect_ratio = vec2(1,1);
uniform vec3 color = vec3(1,1,1);
uniform float scale_factor = 1;
uniform int amount_of_points = 1;
uniform vec2 points[1];

void fragment() {
	points = vec2[](vec2(0,0));
	//Moved the origin to the center
	vec2 uv = UV - 0.5;
	
	//Scaled by the aspect ratio
	uv.x *= aspect_ratio.x / aspect_ratio.y;
	
	float min_dist = length(points[0] - uv);
	//for(int i = 0; i<amount_of_points; i++){
		//vec2 point = points[i];
		//float dist_to_point = length(uv - point);
		//
		//if(dist_to_point < min_dist){
			//min_dist = dist_to_point;
		//}
	//}
	
	vec3 col = color * min_dist;
	COLOR = vec4(255.0, 1.0, 1.0, 1.0);
}
