void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  vec3 color = vec3(0.0);

  vec2 spread = vec2(2.0) / iResolution.xy;
  for(int i = -2; i <= 2; i++)
  for(int j = -2; j <= 2; j++)
  {
    vec3 pcolor = texture(iChannel0, uv + vec2(i, j) * spread).rgb;
    color += pcolor / 25.0;
  }
  fragColor = vec4(color, 1.0);
}