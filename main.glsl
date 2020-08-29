//vec4 iMouse = vec4(MouseXY*RENDERSIZE, MouseClick, MouseClick);

#define 	twpi  	6.283185307179586  	// two pi, 2*pi
#define 	pi   	3.141592653589793 	// pi


vec4 renderPattern(vec4 fragColor, vec2 fragCoord) {
    vec2 uv = floor(10.0 * fragCoord.xy * vec2(RENDERSIZE.x / RENDERSIZE.y, 1) / RENDERSIZE.xy);
    fragColor = vec4(vec3(mod(uv.x + uv.y, 2.)), 1);
    return fragColor;
}

vec4 renderMainImage() {
	vec4 fragColor = vec4(0.0);
	vec2 fragCoord = _xy;

    vec2 uv = (fragCoord.xy / RENDERSIZE.xy);
    vec2 uvc = (fragCoord.xy / RENDERSIZE.y - vec2(RENDERSIZE.x / RENDERSIZE.y / 2.0, 0.5));
    vec2 v = (uv.xy + RENDERSIZE.y);
    v.y -= 0.5;
    v.x -= 0.5;

    //vec2 uvc = _uvc;
    /*float th = v.y * PI,
    ph = v.x * twpi;
    vec3 sp = vec3( sin(ph) * cos(th), sin(th), cos(ph) * cos(th) );
    vec3 pos = vec3( PI, perspective * PI, 0);

    pos *= (texture_zoom * 0.1);
    sp = mix(sp, normalize(vec3(uvc, 1.0)), perspective);
    sp.yz = _rotate(sp.yz, lookXY.y*PI);
    sp.xy = _rotate(sp.xy, lookXY.x*PI);

    float c = 0.0;
    float d = length(uv);
    c = (1.0-d);
    c = pow(c, 1.0);
    fragColor = vec4(c);

    vec2 nUv = vec2(dot(pos, sp.zxy), dot(pos.yzx, sp.zxy));
    nUv -= 0.5;
    nUv += positionXY;
    fragColor = texture(syn_UserImage, mod(nUv, 1.0));*/

    float position_time = bass_time*4.0;
    float perspective_time = bass_time*4.0;
    float th = v.y * pi,
        ph = v.x * twpi;
    vec3 sp = vec3( sin(ph) * cos(th), sin(th), cos(ph) * cos(th) );
    vec3 pos = vec3( pi, perspective * PI, 0);
    pos *= (zoom * 0.1);
    sp = mix(sp, normalize(vec3(uvc, 1.0)), perspective);

    if (position_momentum != 0.0) {
        sp.z +=  (position_momentum.x)*position_time;
        sp.y += (position_momentum.y)*position_time;
    }

    sp.yz = _rotate(sp.yz, lookXY.y*pi);
    sp.xy = _rotate(sp.xy, lookXY.x*pi);

    vec2 nUv = vec2(dot(pos, sp.zxy), dot(pos.yzx, sp.zxy));
    nUv -= 0.5;
    nUv += (positionXY);
    fragColor = texture(_exists(syn_UserImage) ? syn_UserImage : image1, mod(nUv, 1.0));


    return fragColor;
}
vec4 renderMain(){
	if(PASSINDEX == 0){
		return renderMainImage();
	}
}
