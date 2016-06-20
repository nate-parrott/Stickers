precision lowp float;

varying vec2 centerTextureCoordinate;
varying vec2 oneStepPositiveTextureCoordinate;
varying vec2 oneStepNegativeTextureCoordinate;
varying vec2 twoStepsPositiveTextureCoordinate;
varying vec2 twoStepsNegativeTextureCoordinate;
varying vec2 threeStepsPositiveTextureCoordinate;
varying vec2 threeStepsNegativeTextureCoordinate;
varying vec2 fourStepsPositiveTextureCoordinate;
varying vec2 fourStepsNegativeTextureCoordinate;

uniform sampler2D inputImageTexture;

lowp vec4 alphaBlend(lowp vec4 a, lowp vec4 b) {
    lowp vec3 newColor = (a.rgb * a.a + b.rgb * b.a * (1.0 - a.a)) / (a.a + b.a * (1.0 - a.a));
    lowp float newAlpha = a.a + b.a * (1.0 - a.a);
    return vec4(newColor, newAlpha);
}

void main()
{
    lowp vec4 center = texture2D(inputImageTexture, centerTextureCoordinate);
    float centerIntensity = center.a;
    float oneStepPositiveIntensity = texture2D(inputImageTexture, oneStepPositiveTextureCoordinate).a;
    float oneStepNegativeIntensity = texture2D(inputImageTexture, oneStepNegativeTextureCoordinate).a;
    float twoStepsPositiveIntensity = texture2D(inputImageTexture, twoStepsPositiveTextureCoordinate).a;
    float twoStepsNegativeIntensity = texture2D(inputImageTexture, twoStepsNegativeTextureCoordinate).a;
    float threeStepsPositiveIntensity = texture2D(inputImageTexture, threeStepsPositiveTextureCoordinate).a;
    float threeStepsNegativeIntensity = texture2D(inputImageTexture, threeStepsNegativeTextureCoordinate).a;
    float fourStepsPositiveIntensity = texture2D(inputImageTexture, fourStepsPositiveTextureCoordinate).a;
    float fourStepsNegativeIntensity = texture2D(inputImageTexture, fourStepsNegativeTextureCoordinate).a;
    
    lowp float maxValue = max(centerIntensity, oneStepPositiveIntensity);
    maxValue = max(maxValue, oneStepNegativeIntensity);
    maxValue = max(maxValue, twoStepsPositiveIntensity);
    maxValue = max(maxValue, twoStepsNegativeIntensity);
    maxValue = max(maxValue, threeStepsPositiveIntensity);
    maxValue = max(maxValue, threeStepsNegativeIntensity);
    maxValue = max(maxValue, fourStepsPositiveIntensity);
    maxValue = max(maxValue, fourStepsNegativeIntensity);
    
    // lowp vec4 backdrop = vec4(vec3(1.0), maxValue);
    // gl_FragColor = alphaBlend(backdrop, center);
    gl_FragColor = center;
}
