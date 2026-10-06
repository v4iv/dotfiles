// CRT phosphor glow for ghostty — Shadertoy-style fragment shader.
// Subtle by design: text stays readable. Tune the constants below.

const vec3  PHOSPHOR_TINT   = vec3(0.78, 1.0, 0.85); // green phosphor bias
const float TINT_STRENGTH   = 0.32;  // 0 = neutral colors, 1 = full tint
const float GLOW_RADIUS     = 2.5;   // px — bloom tap distance
const float GLOW_STRENGTH   = 0.8;  // 0 = no glow
const float SCANLINE_PERIOD = 2.5;   // px per scanline half-period
const float SCANLINE_DARK   = 0.10;  // 0..1 line darkening
const float ABERRATION      = 0.45;  // px — chromatic fringing
const float VIGNETTE        = 0.20;  // corner darkening
const float FLICKER         = 0.00;  // brightness dip depth (needs animation)

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 res = iResolution.xy;
    vec2 uv  = fragCoord / res;
    vec2 px  = 1.0 / res;

    // Slight chromatic aberration: sample R/B a hair off-center
    vec2 off = vec2(ABERRATION * px.x, 0.0);
    vec3 col;
    col.r = texture(iChannel0, uv - off).r;
    col.g = texture(iChannel0, uv).g;
    col.b = texture(iChannel0, uv + off).b;

    // Cheap bloom: 4-tap cross blur added back as phosphor glow
    vec3 glow = texture(iChannel0, uv + vec2( GLOW_RADIUS, 0.0) * px).rgb
              + texture(iChannel0, uv + vec2(-GLOW_RADIUS, 0.0) * px).rgb
              + texture(iChannel0, uv + vec2(0.0,  GLOW_RADIUS) * px).rgb
              + texture(iChannel0, uv + vec2(0.0, -GLOW_RADIUS) * px).rgb;
    col += glow * (0.25 * GLOW_STRENGTH);

    // Phosphor tint
    col = mix(col, col * PHOSPHOR_TINT, TINT_STRENGTH);

    // Scanlines: darken between "phosphor rows"
    float scan = sin(fragCoord.y * 3.14159265359 / SCANLINE_PERIOD);
    col *= 1.0 - SCANLINE_DARK * (0.5 - 0.5 * scan);

    // Vignette: gentle falloff toward the corners
    vec2 c = uv - 0.5;
    col *= 1.0 - VIGNETTE * dot(c, c) * 2.2;

    // CRT flicker: fast flutter whose depth drifts slowly (iTime only
    // animates while custom-shader-animation = true)
    float slow = sin(iTime * 0.9) * sin(iTime * 0.53 + 1.3);
    float fast = sin(iTime * 12.0) * 0.7 + sin(iTime * 7.7) * 0.3;
    col *= 1.0 - FLICKER * (0.75 + 0.25 * slow) * (0.5 + 0.5 * fast);

    fragColor = vec4(col, 1.0);
}
