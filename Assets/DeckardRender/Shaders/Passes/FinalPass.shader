// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Deckard/FinalPass"
{
	Properties
	{
		[IntRange]_Directions("Directions", Range( 1 , 50)) = 0
		_saturation1("saturation1", Float) = 1
		_saturation("saturation", Float) = 1
		[IntRange]_Quality("Quality", Range( 1 , 50)) = 0
		_HalationSize("HalationSize", Range( 0 , 30)) = 0
		_Size("Size", Range( 0 , 10)) = 0
		_expose("expose", Float) = 1
		_dLUT("_dLUT", 3D) = "white" {}
		_exposure("exposure", Float) = 1
		_Temp("Temp", Range( -1 , 1)) = 0
		_Sharpen("Sharpen", Range( 0 , 1)) = 0
		_SharpenRadius("SharpenRadius", Range( 0 , 5)) = 1
		_CTint("CTint", Range( -0.2 , 0.2)) = 0
		_letterboxing("letterboxing", Range( 0 , 1)) = 0.54
		_ColorOffset("ColorOffset", Float) = 0.4
		_CContrast("CContrast", Float) = 0
		_CMidpoint("CMidpoint", Float) = 0
		_noiseScale("noiseScale", Float) = 1
		_zebras("zebras", Float) = 1
		_DeckardDepthTestEdges("_DeckardDepthTestEdges", Float) = 1
		_PreFinalPAss("PreFinalPAss", Float) = 1
		_NoiseD_A_Amount("NoiseD_A_Amount", Float) = 0
		_ContrVec("ContrVec", Vector) = (0,0,0,0)
		_HalationIntensity("HalationIntensity", Float) = 0
		_NoiseAmount("NoiseAmount", Range( 0 , 1)) = 0
		_NoiseResponse("NoiseResponse", Vector) = (0,0,0,0)
		_CMidPointVec("CMidPointVec", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _finalStep;
			uniform sampler2D _AperturePass;
			uniform float4 _AperturePass_ST;
			uniform float _Directions;
			uniform float _PreFinalPAss;
			uniform float _Quality;
			uniform float _Size;
			float4 _AperturePass_TexelSize;
			uniform float _HalationSize;
			uniform float _HalationIntensity;
			uniform float _SharpenRadius;
			uniform float _Sharpen;
			uniform float3 _CMidPointVec;
			uniform float3 _ContrVec;
			uniform float _saturation;
			uniform float _exposure;
			uniform float _DeckardDepthTestEdges;
			uniform float _ColorOffset;
			uniform float _CMidpoint;
			uniform float _CContrast;
			uniform float _noiseScale;
			uniform float2 _NoiseResponse;
			uniform float _NoiseAmount;
			uniform float _NoiseD_A_Amount;
			uniform float _Temp;
			uniform float _CTint;
			uniform float _zebras;
			uniform float _saturation1;
			uniform float _expose;
			uniform sampler3D _dLUT;
			uniform float _filmResponseValue;
			uniform float _letterboxing;
			float4 GaussianBlur205( sampler2D tex, float Directions, float Quality, float Size, float2 iResolution, float2 UV0, out float4 Col )
			{
				float Pi = 6.28318530718; 
				    
				   
				    float2 Radius = Size/iResolution.xy;
				    
				    float2 UW;
				UW = UV0;
				   // float4 Col;
				Col;
				    
				    // Blur calculations
				    for( float d=0.0; d<Pi; d+=Pi/Directions)
				    {
						for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
				        {
							Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i);		
				        }
				    }
				    
				    Col /= Quality * Directions ;
				    return  Col;
			}
			
			float4 GaussianBlur227( sampler2D tex, float Directions, float Quality, float Size, float2 iResolution, float2 UV0, out float4 Col )
			{
				float Pi = 6.28318530718; 
				    
				   
				    float2 Radius = Size/iResolution.xy;
				    
				    float2 UW;
				UW = UV0;
				   // float4 Col;
				Col;
				    
				    // Blur calculations
				    for( float d=0.0; d<Pi; d+=Pi/Directions)
				    {
						for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
				        {
							Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i);		
				        }
				    }
				    
				    Col /= Quality * Directions ;
				    return  Col;
			}
			
			float4 GaussianBlur215( sampler2D tex, float Directions, float Quality, float Size, float2 iResolution, float2 UV0, out float4 Col )
			{
				float Pi = 6.28318530718; 
				    
				   
				    float2 Radius = Size/iResolution.xy;
				    
				    float2 UW;
				UW = UV0;
				   // float4 Col;
				Col;
				    
				    // Blur calculations
				    for( float d=0.0; d<Pi; d+=Pi/Directions)
				    {
						for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
				        {
							Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i);		
				        }
				    }
				    
				    Col /= Quality * Directions ;
				    return  Col;
			}
			
			float4 GaussianBlur264( sampler2D tex, float Directions, float Quality, float Size, float2 iResolution, float2 UV0, out float4 Col )
			{
				float Pi = 6.28318530718; 
				    
				   
				    float2 Radius = Size/iResolution.xy;
				    
				    float2 UW;
				UW = UV0;
				   // float4 Col;
				Col;
				    
				    // Blur calculations
				    for( float d=0.0; d<Pi; d+=Pi/Directions)
				    {
						for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
				        {
							Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i);		
				        }
				    }
				    
				    Col /= Quality * Directions ;
				    return  Col;
			}
			
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float3 RGBToHSV(float3 c)
			{
				float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
				float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
				float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
				float d = q.x - min( q.w, q.y );
				float e = 1.0e-10;
				return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			float3 MyCustomExpression1_g2( float Midpoint, float Contrast, float3 In )
			{
				float midpoint = pow(Midpoint, 2.2);
				    return  (In - midpoint) * Contrast + midpoint;
			}
			
			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			
			float3 MyCustomExpression1_g32( float Midpoint, float Contrast, float3 In )
			{
				float midpoint = pow(Midpoint, 2.2);
				    return  (In - midpoint) * Contrast + midpoint;
			}
			
			float3 MyCustomExpression1_g29( float Midpoint, float Contrast, float3 In )
			{
				float midpoint = pow(Midpoint, 2.2);
				    return  (In - midpoint) * Contrast + midpoint;
			}
			
			float3 MyCustomExpression1_g31( float Midpoint, float Contrast, float3 In )
			{
				float midpoint = pow(Midpoint, 2.2);
				    return  (In - midpoint) * Contrast + midpoint;
			}
			
			float3 temperature_Deckard1_g33( float3 In, float Temperature, float Tint )
			{
				 float t1 = Temperature * 10 / 6;
				    float t2 = Tint * 10 / 6;
				    // Get the CIE xy chromaticity of the reference white point.
				    // Note: 0.31271 = x value on the D65 white point
				    float x = 0.31271 - t1 * (t1 < 0 ? 0.1 : 0.05);
				    float standardIlluminantY = 2.87 * x - 3 * x * x - 0.27509507;
				    float y = standardIlluminantY + t2 * 0.05;
				    // Calculate the coefficients in the LMS space.
				    float3 w1 = float3(0.949237, 1.03542, 1.08728); // D65 white point
				    // CIExyToLMS
				    float Y = 1;
				    float X = Y * x / y;
				    float Z = Y * (1 - x - y) / y;
				    float L = (0.7328 * X + 0.4296 * Y - 0.1624 * Z);
				    float M = -0.7036 * X + 1.6975 * Y + 0.0061 * Z;
				    float S = 0.0030 * X + 0.0136 * Y + 0.9834 * Z;
				    float3 w2 = float3(L, M, S);
				    float3 balance = float3(w1.x / w2.x, w1.y / w2.y, w1.z / w2.z);
				    float3x3 LIN_2_LMS_MAT = {
				        3.90405e-1, 5.49941e-1, 8.92632e-3,
				        7.08416e-2, 9.63172e-1, 1.35775e-3,
				        2.31082e-2, 1.28021e-1, 9.36245e-1
				    };
				    float3x3 LMS_2_LIN_MAT = {
				        2.85847e+0, -1.62879e+0, -2.48910e-2,
				        -2.10182e-1,  1.15820e+0,  3.24281e-4,
				        -4.18120e-2, -1.18169e-1,  1.06867e+0
				    };
				    float3 lms = mul(LIN_2_LMS_MAT, In);
				    lms *= balance;
				    return mul(LMS_2_LIN_MAT, lms);
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 uv_AperturePass = i.ase_texcoord1.xy * _AperturePass_ST.xy + _AperturePass_ST.zw;
				float4 tex2DNode11 = tex2D( _AperturePass, uv_AperturePass );
				sampler2D tex205 = _AperturePass;
				float PreFinalPassValue181 = _PreFinalPAss;
				float lerpResult248 = lerp( 1.0 , _Directions , PreFinalPassValue181);
				float Directions205 = lerpResult248;
				float lerpResult250 = lerp( 1.0 , _Quality , PreFinalPassValue181);
				float Quality205 = lerpResult250;
				float lerpResult252 = lerp( 1.0 , _Size , PreFinalPassValue181);
				float Size205 = lerpResult252;
				float2 appendResult212 = (float2(_AperturePass_TexelSize.z , _AperturePass_TexelSize.w));
				float2 iResolution205 = appendResult212;
				float2 texCoord204 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0205 = texCoord204;
				float4 Col205 = float4( 0,0,0,0 );
				float4 localGaussianBlur205 = GaussianBlur205( tex205 , Directions205 , Quality205 , Size205 , iResolution205 , UV0205 , Col205 );
				sampler2D tex227 = _AperturePass;
				float Directions227 = ( lerpResult248 * 16.0 );
				float Quality227 = ( 10.0 * lerpResult250 );
				float lerpResult251 = lerp( 1.0 , _HalationSize , PreFinalPassValue181);
				float Size227 = lerpResult251;
				float2 iResolution227 = appendResult212;
				float2 UV0227 = texCoord204;
				float4 Col227 = float4( 0,0,0,0 );
				float4 localGaussianBlur227 = GaussianBlur227( tex227 , Directions227 , Quality227 , Size227 , iResolution227 , UV0227 , Col227 );
				float lerpResult259 = lerp( Col205.x , Col227.x , _HalationIntensity);
				sampler2D tex215 = _AperturePass;
				float Directions215 = lerpResult248;
				float Quality215 = lerpResult250;
				float Size215 = ( lerpResult252 * 0.5 );
				float2 iResolution215 = appendResult212;
				float2 UV0215 = texCoord204;
				float4 Col215 = float4( 0,0,0,0 );
				float4 localGaussianBlur215 = GaussianBlur215( tex215 , Directions215 , Quality215 , Size215 , iResolution215 , UV0215 , Col215 );
				float4 appendResult211 = (float4(lerpResult259 , Col215.y , tex2DNode11.b , 0.0));
				sampler2D tex264 = _AperturePass;
				float Directions264 = 8.0;
				float Quality264 = 4.0;
				float Size264 = _SharpenRadius;
				float2 iResolution264 = appendResult212;
				float2 UV0264 = texCoord204;
				float4 Col264 = float4( 0,0,0,0 );
				float4 localGaussianBlur264 = GaussianBlur264( tex264 , Directions264 , Quality264 , Size264 , iResolution264 , UV0264 , Col264 );
				float4 temp_output_266_0 = ( tex2DNode11 - Col264 );
				float4 lerpResult253 = lerp( tex2DNode11 , ( appendResult211 + ( temp_output_266_0 * _Sharpen ) ) , PreFinalPassValue181);
				float4 lerpResult160 = lerp( float4( 0,0,0,0 ) , lerpResult253 , float4( 1,1,1,1 ));
				float3 temp_cast_3 = (step( frac( ( ( uv_AperturePass.x + ( uv_AperturePass.y * 0.2 ) ) * 200.0 ) ) , 0.6 )).xxx;
				float Midpoint1_g32 = _CMidPointVec.x;
				float Contrast1_g32 = _ContrVec.x;
				float3 hsvTorgb37 = RGBToHSV( lerpResult253.xyz );
				float lerpResult182 = lerp( hsvTorgb37.y , ( hsvTorgb37.y * _saturation ) , PreFinalPassValue181);
				float temp_output_39_0 = ( hsvTorgb37.z * _exposure );
				float3 hsvTorgb40 = HSVToRGB( float3(hsvTorgb37.x,lerpResult182,temp_output_39_0) );
				float3 temp_output_46_0 = ( hsvTorgb40 * float3( 1,1,1 ) );
				float3 break83 = ( saturate( ( ddx( temp_output_46_0 ) + ddy( temp_output_46_0 ) ) ) * 1.0 );
				float ifLocalVar90 = 0;
				if( ( break83.x + break83.y + break83.z ) > 0.4 )
				ifLocalVar90 = 1.0;
				else if( ( break83.x + break83.y + break83.z ) == 0.4 )
				ifLocalVar90 = 0.0;
				else if( ( break83.x + break83.y + break83.z ) < 0.4 )
				ifLocalVar90 = 0.0;
				float3 lerpResult88 = lerp( temp_output_46_0 , float3( 0,1,0 ) , ifLocalVar90);
				float3 lerpResult94 = lerp( temp_output_46_0 , lerpResult88 , _DeckardDepthTestEdges);
				float3 hsvTorgb107 = RGBToHSV( lerpResult94 );
				float Midpoint1_g2 = _CMidpoint;
				float Contrast1_g2 = _CContrast;
				float3 temp_cast_5 = (hsvTorgb107.z).xxx;
				float3 In1_g2 = temp_cast_5;
				float3 localMyCustomExpression1_g2 = MyCustomExpression1_g2( Midpoint1_g2 , Contrast1_g2 , In1_g2 );
				float3 hsvTorgb120 = HSVToRGB( float3(( hsvTorgb107.x + _ColorOffset ),hsvTorgb107.y,localMyCustomExpression1_g2.x) );
				float2 texCoord100 = i.ase_texcoord1.xy * float2( 1222.1,724.2 ) + float2( 0.06,0 );
				float temp_output_103_0 = ( frac( _Time.y ) * 2000.0 );
				float2 appendResult186 = (float2(_AperturePass_TexelSize.x , _AperturePass_TexelSize.y));
				float2 temp_output_187_0 = ( _noiseScale * appendResult186 );
				float2 appendResult222 = (float2(_AperturePass_TexelSize.z , _AperturePass_TexelSize.w));
				float simplePerlin3D119 = snoise( float3( ( ( texCoord100 + temp_output_103_0 ) * temp_output_187_0 * appendResult222 ) ,  0.0 ) );
				float smoothstepResult263 = smoothstep( _NoiseResponse.x , _NoiseResponse.y , hsvTorgb107.z);
				float temp_output_261_0 = ( smoothstepResult263 * _NoiseAmount );
				float temp_output_129_0 = ( simplePerlin3D119 * temp_output_261_0 * 1.0 * ( 1.0 - hsvTorgb120.x ) );
				float3 temp_cast_8 = (( hsvTorgb120.x - temp_output_129_0 )).xxx;
				float3 In1_g32 = temp_cast_8;
				float3 localMyCustomExpression1_g32 = MyCustomExpression1_g32( Midpoint1_g32 , Contrast1_g32 , In1_g32 );
				float Midpoint1_g29 = _CMidPointVec.y;
				float Contrast1_g29 = _ContrVec.y;
				float2 texCoord99 = i.ase_texcoord1.xy * float2( 1048.7,517.25 ) + float2( 1.52,1.47 );
				float simplePerlin3D117 = snoise( float3( ( ( texCoord99 + temp_output_103_0 ) * temp_output_187_0 * appendResult222 ) ,  0.0 ) );
				float temp_output_128_0 = ( simplePerlin3D117 * temp_output_261_0 * 1.0 * ( 1.0 - hsvTorgb120.y ) );
				float3 temp_cast_11 = (( hsvTorgb120.y - temp_output_128_0 )).xxx;
				float3 In1_g29 = temp_cast_11;
				float3 localMyCustomExpression1_g29 = MyCustomExpression1_g29( Midpoint1_g29 , Contrast1_g29 , In1_g29 );
				float Midpoint1_g31 = _CMidPointVec.z;
				float Contrast1_g31 = _ContrVec.z;
				float2 texCoord101 = i.ase_texcoord1.xy * float2( 980.5,503.22 ) + float2( 1.11,1.89 );
				float simplePerlin3D118 = snoise( float3( ( ( texCoord101 + temp_output_103_0 ) * temp_output_187_0 * appendResult222 ) ,  0.0 ) );
				float3 temp_cast_14 = (( hsvTorgb120.z - ( simplePerlin3D118 * temp_output_261_0 * 1.0 * ( 1.0 - hsvTorgb120.z ) ) )).xxx;
				float3 In1_g31 = temp_cast_14;
				float3 localMyCustomExpression1_g31 = MyCustomExpression1_g31( Midpoint1_g31 , Contrast1_g31 , In1_g31 );
				float3 appendResult141 = (float3(localMyCustomExpression1_g32.x , localMyCustomExpression1_g29.x , localMyCustomExpression1_g31.x));
				float3 lerpResult143 = lerp( appendResult141 , hsvTorgb120 , ( _NoiseD_A_Amount + 1.0 ));
				float3 hsvTorgb144 = RGBToHSV( lerpResult143 );
				float3 hsvTorgb147 = HSVToRGB( float3(( hsvTorgb144.x - _ColorOffset ),hsvTorgb144.y,hsvTorgb144.z) );
				float3 In1_g33 = hsvTorgb147;
				float Temperature1_g33 = _Temp;
				float Tint1_g33 = _CTint;
				float3 localtemperature_Deckard1_g33 = temperature_Deckard1_g33( In1_g33 , Temperature1_g33 , Tint1_g33 );
				float ifLocalVar162 = 0;
				if( temp_output_39_0 > 0.8 )
				ifLocalVar162 = 0.0;
				else if( temp_output_39_0 < 0.8 )
				ifLocalVar162 = 1.0;
				float lerpResult176 = lerp( ifLocalVar162 , 1.0 , _zebras);
				float3 lerpResult166 = lerp( temp_cast_3 , localtemperature_Deckard1_g33 , lerpResult176);
				float3 hsvTorgb191 = RGBToHSV( lerpResult166 );
				float3 hsvTorgb196 = HSVToRGB( float3(hsvTorgb191.x,( hsvTorgb191.y * _saturation1 ),( hsvTorgb191.z * _expose )) );
				float3 temp_output_197_0 = ( hsvTorgb196 * float3( 1,1,1 ) );
				half3 linearToGamma198 = temp_output_197_0;
				linearToGamma198 = half3( LinearToGammaSpaceExact(linearToGamma198.r), LinearToGammaSpaceExact(linearToGamma198.g), LinearToGammaSpaceExact(linearToGamma198.b) );
				half3 gammaToLinear201 = tex3D( _dLUT, linearToGamma198 ).rgb;
				gammaToLinear201 = half3( GammaToLinearSpaceExact(gammaToLinear201.r), GammaToLinearSpaceExact(gammaToLinear201.g), GammaToLinearSpaceExact(gammaToLinear201.b) );
				float3 lerpResult203 = lerp( temp_output_197_0 , gammaToLinear201 , _filmResponseValue);
				float4 lerpResult158 = lerp( lerpResult160 , float4( lerpResult203 , 0.0 ) , _PreFinalPAss);
				float4 appendResult53 = (float4(( (lerpResult158).xyz * step( abs( (-1.0 + (uv_AperturePass.y - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) , _letterboxing ) ) , 1.0));
				
				
				finalColor = appendResult53;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18809
618;545;1725;778;-4059.119;2263.481;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;159;5269.412,17.94507;Float;False;Property;_PreFinalPAss;PreFinalPAss;25;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;10;-1551.179,76.68861;Float;True;Global;_AperturePass;_AperturePass;13;1;[HDR];Create;True;0;0;0;True;0;False;None;;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;5428.638,228.7079;Inherit;False;PreFinalPassValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;249;-1717.034,-1035.866;Inherit;False;181;PreFinalPassValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;174;-746.8013,406.3787;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;208;-1593.626,-1113.704;Inherit;False;Property;_Directions;Directions;3;1;[IntRange];Create;True;0;0;0;False;0;False;0;16;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;-1810.557,-921.9975;Inherit;False;Property;_Quality;Quality;6;1;[IntRange];Create;True;0;0;0;False;0;False;0;7;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexelSizeNode;14;-1333.099,602.9695;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;248;-1253.733,-1104.863;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;206;-1886.578,-604.7081;Inherit;False;Property;_Size;Size;8;0;Create;True;0;0;0;False;0;False;0;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;250;-1322.74,-965.0145;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;228;-1375.276,-1262.887;Inherit;False;Property;_HalationSize;HalationSize;7;0;Create;True;0;0;0;False;0;False;0;13;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;251;-1032.956,-1255.15;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;212;-1002.432,400.3086;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;233;-1077.853,-1027.799;Inherit;False;2;2;0;FLOAT;10;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-1027.867,-1122.472;Inherit;False;2;2;0;FLOAT;10;False;1;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;252;-1564.677,-574.9321;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;204;-1434.094,-716.0598;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;-1330.911,-522.9578;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;205;-1000.856,-907.962;Inherit;False;float Pi = 6.28318530718@ $    $$   $    float2 Radius = Size/iResolution.xy@$    $$    float2 UW@$UW = UV0@$   // float4 Col@$Col@$    $    // Blur calculations$    for( float d=0.0@ d<Pi@ d+=Pi/Directions)$    {$		for(float i=1.0/Quality@ i<=1.0@ i+=1.0/Quality)$        {$			Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i)@		$        }$    }$    $$    Col /= Quality * Directions @$    return  Col@;4;False;7;True;tex;SAMPLER2D;;In;;Float;False;True;Directions;FLOAT;16;In;;Float;False;True;Quality;FLOAT;4;In;;Float;False;True;Size;FLOAT;10;In;;Float;False;True;iResolution;FLOAT2;1,1;In;;Float;False;True;UV0;FLOAT2;0,0;In;;Float;False;True;Col;FLOAT4;0,0,0,0;Out;;Float;False;GaussianBlur;True;False;0;7;0;SAMPLER2D;;False;1;FLOAT;16;False;2;FLOAT;4;False;3;FLOAT;10;False;4;FLOAT2;1,1;False;5;FLOAT2;0,0;False;6;FLOAT4;0,0,0,0;False;2;FLOAT4;0;FLOAT4;7
Node;AmplifyShaderEditor.RangedFloatNode;36;-1243.805,847.745;Float;False;Property;_SharpenRadius;SharpenRadius;16;0;Create;True;0;0;0;False;0;False;1;1.32;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;227;-783.7073,-1292.03;Inherit;False;float Pi = 6.28318530718@ $    $$   $    float2 Radius = Size/iResolution.xy@$    $$    float2 UW@$UW = UV0@$   // float4 Col@$Col@$    $    // Blur calculations$    for( float d=0.0@ d<Pi@ d+=Pi/Directions)$    {$		for(float i=1.0/Quality@ i<=1.0@ i+=1.0/Quality)$        {$			Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i)@		$        }$    }$    $$    Col /= Quality * Directions @$    return  Col@;4;False;7;True;tex;SAMPLER2D;;In;;Float;False;True;Directions;FLOAT;16;In;;Float;False;True;Quality;FLOAT;4;In;;Float;False;True;Size;FLOAT;10;In;;Float;False;True;iResolution;FLOAT2;1,1;In;;Float;False;True;UV0;FLOAT2;0,0;In;;Float;False;True;Col;FLOAT4;0,0,0,0;Out;;Float;False;GaussianBlur;True;False;0;7;0;SAMPLER2D;;False;1;FLOAT;16;False;2;FLOAT;4;False;3;FLOAT;10;False;4;FLOAT2;1,1;False;5;FLOAT2;0,0;False;6;FLOAT4;0,0,0,0;False;2;FLOAT4;0;FLOAT4;7
Node;AmplifyShaderEditor.BreakToComponentsNode;230;-512.6018,-1234.403;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CustomExpressionNode;215;-1058.616,-679.0978;Inherit;False;float Pi = 6.28318530718@ $    $$   $    float2 Radius = Size/iResolution.xy@$    $$    float2 UW@$UW = UV0@$   // float4 Col@$Col@$    $    // Blur calculations$    for( float d=0.0@ d<Pi@ d+=Pi/Directions)$    {$		for(float i=1.0/Quality@ i<=1.0@ i+=1.0/Quality)$        {$			Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i)@		$        }$    }$    $$    Col /= Quality * Directions @$    return  Col@;4;False;7;True;tex;SAMPLER2D;;In;;Float;False;True;Directions;FLOAT;16;In;;Float;False;True;Quality;FLOAT;4;In;;Float;False;True;Size;FLOAT;10;In;;Float;False;True;iResolution;FLOAT2;1,1;In;;Float;False;True;UV0;FLOAT2;0,0;In;;Float;False;True;Col;FLOAT4;0,0,0,0;Out;;Float;False;GaussianBlur;True;False;0;7;0;SAMPLER2D;;False;1;FLOAT;16;False;2;FLOAT;4;False;3;FLOAT;10;False;4;FLOAT2;1,1;False;5;FLOAT2;0,0;False;6;FLOAT4;0,0,0,0;False;2;FLOAT4;0;FLOAT4;7
Node;AmplifyShaderEditor.RangedFloatNode;232;-344.461,-1025.609;Inherit;False;Property;_HalationIntensity;HalationIntensity;30;0;Create;True;0;0;0;False;0;False;0;0.69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;264;-806.6852,807.6984;Inherit;False;float Pi = 6.28318530718@ $    $$   $    float2 Radius = Size/iResolution.xy@$    $$    float2 UW@$UW = UV0@$   // float4 Col@$Col@$    $    // Blur calculations$    for( float d=0.0@ d<Pi@ d+=Pi/Directions)$    {$		for(float i=1.0/Quality@ i<=1.0@ i+=1.0/Quality)$        {$			Col += tex2D( tex, UW+float2(cos(d),sin(d))*Radius*i)@		$        }$    }$    $$    Col /= Quality * Directions @$    return  Col@;4;False;7;True;tex;SAMPLER2D;;In;;Float;False;True;Directions;FLOAT;8;In;;Float;False;True;Quality;FLOAT;4;In;;Float;False;True;Size;FLOAT;10;In;;Float;False;True;iResolution;FLOAT2;1,1;In;;Float;False;True;UV0;FLOAT2;0,0;In;;Float;False;True;Col;FLOAT4;0,0,0,0;Out;;Float;False;GaussianBlur;True;False;0;7;0;SAMPLER2D;;False;1;FLOAT;8;False;2;FLOAT;4;False;3;FLOAT;10;False;4;FLOAT2;1,1;False;5;FLOAT2;0,0;False;6;FLOAT4;0,0,0,0;False;2;FLOAT4;0;FLOAT4;7
Node;AmplifyShaderEditor.SamplerNode;11;-922.1038,4.032749;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;210;-682.0567,-897.2161;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;214;-740.1926,-646.0288;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;266;-123.5437,562.0286;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;232.3406,332.0312;Float;False;Property;_Sharpen;Sharpen;15;0;Create;True;0;0;0;False;0;False;0;1.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;259;-295.0109,-693.533;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;211;-503.2619,-103.2074;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;209.9933,465.7985;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-828.7491,263.6957;Inherit;False;181;PreFinalPassValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;268;-105.8489,270.4323;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;253;-224.5904,68.68179;Inherit;False;3;0;FLOAT4;1,0,0,0;False;1;FLOAT4;1,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RelayNode;209;-29.15738,83.03094;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;180;1140.773,281.4803;Float;False;Property;_saturation;saturation;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;37;927.3719,147.6165;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;1341.767,233.3661;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1170.944,383.0688;Float;False;Property;_exposure;exposure;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;1163.21,121.0815;Inherit;False;181;PreFinalPassValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1441.005,363.4773;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;182;1487.21,155.0815;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;40;1722.273,171.7955;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;2465.88,-13.61557;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DdxOpNode;78;2836.314,60.37604;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DdyOpNode;80;2804.834,156.2867;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;2972.944,126.6174;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;86;3107.214,291.9802;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;87;3109.473,172.5506;Float;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;3258.968,153.8531;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;50;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;83;3322.462,191.3094;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;91;3184.13,326.8914;Float;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;3287.17,316.7702;Float;False;Constant;_Float6;Float 6;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;3303.697,377.3676;Float;False;Constant;_Float7;Float 7;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;3561.152,361.8638;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;90;3614.778,195.8235;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0.4;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;3354.229,-243.5342;Float;False;Property;_DeckardDepthTestEdges;_DeckardDepthTestEdges;24;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;96;3059.301,-2841.816;Inherit;False;4673.171;1957.566;Comment;62;149;148;147;146;145;144;143;142;141;140;139;138;137;136;135;134;133;132;131;130;129;128;127;124;123;122;120;119;118;117;116;115;114;113;112;111;110;109;108;107;106;105;104;103;101;100;99;98;97;178;185;187;184;222;223;224;225;226;261;262;263;265;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;88;3486.464,25.47193;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;97;3418.108,-1601.044;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;94;3762.2,-240.2897;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FractNode;98;3642.588,-1684.034;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;186;-917.1144,563.0802;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RelayNode;102;4044.515,-373.9061;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RGBToHSVNode;107;4328.094,-1683.667;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;104;4869.029,-1560.931;Float;False;Property;_CMidpoint;CMidpoint;21;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;5140.45,-1574.093;Float;False;Property;_ColorOffset;ColorOffset;19;0;Create;True;0;0;0;False;0;False;0.4;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;185;3768.112,-1773.397;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;3996.588,-1774.034;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2000;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;99;3546.538,-2243.925;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1048.7,517.25;False;1;FLOAT2;1.52,1.47;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;3576.656,-2601.602;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;980.5,503.22;False;1;FLOAT2;1.11,1.89;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;105;4747.729,-1453.129;Float;False;Property;_CContrast;CContrast;20;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;3625.401,-1903.532;Float;False;Property;_noiseScale;noiseScale;22;0;Create;True;0;0;0;False;0;False;1;0.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;100;3577.301,-2411.892;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1222.1,724.2;False;1;FLOAT2;0.06,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexelSizeNode;184;3355.04,-2085.864;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;108;4093.408,-2462.844;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;265;4512.002,-1497.696;Inherit;False;Property;_NoiseResponse;NoiseResponse;32;0;Create;True;0;0;0;False;0;False;0,0;-0.28,1.32;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;106;4093.308,-1937.543;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;116;5072.625,-1354.96;Inherit;False;ContrastMidpoint;-1;;2;82fa6eec51a71ba41a3d531aa7afcea5;0;3;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;222;3761.463,-2065.087;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;4168.999,-2277.838;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;3852.711,-1914.122;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;5082.382,-1891.277;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;262;4567.107,-2708.119;Inherit;False;Property;_NoiseAmount;NoiseAmount;31;0;Create;True;0;0;0;False;0;False;0;0.18;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;4320.408,-2272.444;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;263;4666.176,-1804.481;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-0.15;False;2;FLOAT;1.27;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;4194.108,-2055.044;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;4289.408,-2519.944;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.HSVToRGBNode;120;4826.094,-1718.638;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;4837.502,-2563.819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;123;4911.136,-2007.776;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;117;4515.981,-2066.355;Inherit;False;Simplex3D;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;118;4553.203,-2516.632;Inherit;False;Simplex3D;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;124;4916.046,-2162.261;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;122;4818.659,-2376.792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;4532.217,-1861.721;Inherit;False;Constant;_Float10;Float 10;30;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;119;4525.387,-2279.622;Inherit;False;Simplex3D;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;5086.705,-2513.102;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0.05;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;5180.05,-2092.091;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0.02;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;5167.929,-2280.675;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0.03;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;136;5626.166,-1517.338;Float;False;Property;_ContrVec;ContrVec;28;0;Create;True;0;0;0;False;0;False;0,0,0;1.1,1.02,1.3;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;135;5804.151,-2304.482;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;137;5739.554,-2555.563;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;134;5701.693,-1269.296;Float;False;Property;_CMidPointVec;CMidPointVec;34;0;Create;True;0;0;0;False;0;False;0,0,0;0.59,0.61,0.49;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;133;5771.352,-2108.789;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;139;6041.824,-1994.524;Inherit;False;ContrastMidpoint;-1;;29;82fa6eec51a71ba41a3d531aa7afcea5;0;3;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;138;6128.147,-2285.84;Inherit;False;ContrastMidpoint;-1;;32;82fa6eec51a71ba41a3d531aa7afcea5;0;3;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;142;6039.217,-1547.057;Float;False;Property;_NoiseD_A_Amount;NoiseD_A_Amount;27;0;Create;True;0;0;0;False;0;False;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;140;6017.461,-1771.862;Inherit;False;ContrastMidpoint;-1;;31;82fa6eec51a71ba41a3d531aa7afcea5;0;3;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;141;6291.164,-1782.121;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;178;6322.79,-1625.303;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;143;6509.52,-1976.757;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-429.9399,887.2871;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RGBToHSVNode;144;6503.067,-1641.514;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;3220.562,-323.0385;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;169;3304.962,-434.5052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;145;6705.635,-1787.476;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;3597.126,551.5016;Float;False;Constant;_1;1;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;6197.91,-1427.261;Float;False;Property;_Temp;Temp;14;0;Create;True;0;0;0;False;0;False;0;0.33;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;147;6873.848,-1734.103;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;164;3638.845,669.8471;Float;False;Constant;_Float9;Float 9;21;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;6366.69,-1326.606;Float;False;Property;_CTint;CTint;17;0;Create;True;0;0;0;False;0;False;0;0;-0.2;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;3523.964,-452.9807;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;200;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;167;3723.227,-447.5341;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;149;7172.088,-1702.565;Inherit;False;ColorTemperature;0;;33;fccce2e41bca18a41863dccc23edb3ef;0;3;2;FLOAT3;0,0,0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;175;4166.896,1107.766;Float;False;Property;_zebras;zebras;23;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;162;3849.144,467.1;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;176;4410.999,972.1728;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;150;4580.393,517.7131;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;170;4452.755,-150.1605;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;166;4903.762,611.3968;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;1,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RGBToHSVNode;191;4403.456,1503.814;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;194;4355.979,1815.652;Float;False;Property;_saturation1;saturation1;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;195;4422.958,1917.871;Float;False;Property;_expose;expose;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;192;4640.973,1677.538;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;4707.953,1779.757;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;196;4785.456,1517.814;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;5017.667,1729.466;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;200;5192.066,1975.345;Float;True;Property;_dLUT;_dLUT;10;0;Create;True;0;0;0;False;0;False;81fc6d79243b09b459232b9cec81fa5e;a242548039c60d547b9f651725d01440;False;white;LockedToTexture3D;Texture3D;-1;0;2;SAMPLER3D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LinearToGammaNode;198;5181.155,1834.483;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;199;5499.089,1894.471;Inherit;True;Property;_TextureSample9;Texture Sample 9;7;0;Create;True;0;0;0;False;0;False;-1;81fc6d79243b09b459232b9cec81fa5e;81fc6d79243b09b459232b9cec81fa5e;True;0;False;white;Auto;False;Object;-1;Auto;Texture3D;8;0;SAMPLER3D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;202;5675.559,1755.966;Float;False;Global;_filmResponseValue;_filmResponseValue;15;0;Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;160;565.4205,-307.8559;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;1,1,1,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GammaToLinearNode;201;5898.824,2011.525;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;48;1687.666,-82.77901;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;258;5148.809,-86.16304;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;203;5973.145,1664.703;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;41;2000.923,-509.0124;Float;False;Property;_letterboxing;letterboxing;18;0;Create;True;0;0;0;False;0;False;0.54;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;45;2002.641,-132.9744;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;158;5495.358,-71.21899;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;173;5768.979,53.1659;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;51;2356.316,-177.1693;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;6405.647,129.5321;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;74;7613.791,644.6335;Float;False;Constant;_Float2;Float 2;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-611.3036,297.7228;Inherit;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;241;-287.6677,-1334.334;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.67;False;2;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;50;2764.409,-569.5506;Inherit;False;Midtones Control;-1;;34;1862d12003a80d24ab048da83dc4e4d5;0;4;25;SAMPLER2D;0.0;False;26;FLOAT;0;False;27;FLOAT;0;False;28;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;165;4154.278,-163.4268;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;271;-182.3671,753.9634;Inherit;False;Property;_SharpenTreshold;SharpenTreshold;33;0;Create;True;0;0;0;False;0;False;0;3.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LinearToGammaNode;156;5272.532,-490.7907;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-271.265,525.5231;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;132;6023.832,-1338.394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;3927.784,-2383.336;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;53;7896.6,506.8306;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;75;4816.3,-530.0585;Float;True;Global;_AlphaPass;_AlphaPass;26;0;Create;True;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-772.3964,671.695;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;130;5377.043,-2356.944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;267;-354.1039,730.3848;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;270;68.35266,597.6706;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT4;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;245;5544.655,-180.0251;Inherit;False;Property;_ToggleSwitch0;Toggle Switch0;29;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;153;5344.308,-185.5074;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GammaToLinearNode;155;5478.718,-506.0597;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-556.0757,628.7969;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-257.958,-863.1724;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;272;19.51112,727.9146;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;3946.975,-2213.817;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;-80.75902,-1052.028;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;2094.018,-271.5621;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;131;5493.228,-2039.958;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;3986.477,124.3893;Float;False;Constant;_Float8;Float 8;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;246;5982.148,-482.5149;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;288.3196,-93.66443;Float;False;Global;_finalStep;_finalStep;1;0;Create;True;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;77;4026.568,646.5963;Inherit;True;Property;_TextureSample8;Texture Sample 8;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;2454.561,170.7326;Float;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;257;-142.3166,-557.2937;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;226;4655.083,-2149.906;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;55;8680.978,321.7581;Float;False;True;-1;2;ASEMaterialInspector;0;1;Deckard/FinalPass;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;0;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;181;0;159;0
WireConnection;174;0;10;0
WireConnection;14;0;174;0
WireConnection;248;1;208;0
WireConnection;248;2;249;0
WireConnection;250;1;207;0
WireConnection;250;2;249;0
WireConnection;251;1;228;0
WireConnection;251;2;249;0
WireConnection;212;0;14;3
WireConnection;212;1;14;4
WireConnection;233;1;250;0
WireConnection;237;0;248;0
WireConnection;252;1;206;0
WireConnection;252;2;249;0
WireConnection;216;0;252;0
WireConnection;205;0;10;0
WireConnection;205;1;248;0
WireConnection;205;2;250;0
WireConnection;205;3;252;0
WireConnection;205;4;212;0
WireConnection;205;5;204;0
WireConnection;227;0;10;0
WireConnection;227;1;237;0
WireConnection;227;2;233;0
WireConnection;227;3;251;0
WireConnection;227;4;212;0
WireConnection;227;5;204;0
WireConnection;230;0;227;7
WireConnection;215;0;10;0
WireConnection;215;1;248;0
WireConnection;215;2;250;0
WireConnection;215;3;216;0
WireConnection;215;4;212;0
WireConnection;215;5;204;0
WireConnection;264;0;10;0
WireConnection;264;3;36;0
WireConnection;264;4;212;0
WireConnection;264;5;204;0
WireConnection;11;0;10;0
WireConnection;210;0;205;7
WireConnection;214;0;215;7
WireConnection;266;0;11;0
WireConnection;266;1;264;7
WireConnection;259;0;210;0
WireConnection;259;1;230;0
WireConnection;259;2;232;0
WireConnection;211;0;259;0
WireConnection;211;1;214;1
WireConnection;211;2;11;3
WireConnection;269;0;266;0
WireConnection;269;1;33;0
WireConnection;268;0;211;0
WireConnection;268;1;269;0
WireConnection;253;0;11;0
WireConnection;253;1;268;0
WireConnection;253;2;254;0
WireConnection;209;0;253;0
WireConnection;37;0;209;0
WireConnection;179;0;37;2
WireConnection;179;1;180;0
WireConnection;39;0;37;3
WireConnection;39;1;38;0
WireConnection;182;0;37;2
WireConnection;182;1;179;0
WireConnection;182;2;183;0
WireConnection;40;0;37;1
WireConnection;40;1;182;0
WireConnection;40;2;39;0
WireConnection;46;0;40;0
WireConnection;78;0;46;0
WireConnection;80;0;46;0
WireConnection;81;0;78;0
WireConnection;81;1;80;0
WireConnection;86;0;81;0
WireConnection;79;0;86;0
WireConnection;79;1;87;0
WireConnection;83;0;79;0
WireConnection;82;0;83;0
WireConnection;82;1;83;1
WireConnection;82;2;83;2
WireConnection;90;0;82;0
WireConnection;90;2;91;0
WireConnection;90;3;92;0
WireConnection;90;4;93;0
WireConnection;88;0;46;0
WireConnection;88;2;90;0
WireConnection;94;0;46;0
WireConnection;94;1;88;0
WireConnection;94;2;95;0
WireConnection;98;0;97;0
WireConnection;186;0;14;1
WireConnection;186;1;14;2
WireConnection;102;0;94;0
WireConnection;107;0;102;0
WireConnection;185;0;186;0
WireConnection;103;0;98;0
WireConnection;184;0;10;0
WireConnection;108;0;101;0
WireConnection;108;1;103;0
WireConnection;106;0;99;0
WireConnection;106;1;103;0
WireConnection;116;2;104;0
WireConnection;116;3;105;0
WireConnection;116;4;107;3
WireConnection;222;0;184;3
WireConnection;222;1;184;4
WireConnection;109;0;100;0
WireConnection;109;1;103;0
WireConnection;187;0;110;0
WireConnection;187;1;185;0
WireConnection;115;0;107;1
WireConnection;115;1;111;0
WireConnection;113;0;109;0
WireConnection;113;1;187;0
WireConnection;113;2;222;0
WireConnection;263;0;107;3
WireConnection;263;1;265;1
WireConnection;263;2;265;2
WireConnection;112;0;106;0
WireConnection;112;1;187;0
WireConnection;112;2;222;0
WireConnection;114;0;108;0
WireConnection;114;1;187;0
WireConnection;114;2;222;0
WireConnection;120;0;115;0
WireConnection;120;1;107;2
WireConnection;120;2;116;0
WireConnection;261;0;263;0
WireConnection;261;1;262;0
WireConnection;123;0;120;2
WireConnection;117;0;112;0
WireConnection;118;0;114;0
WireConnection;124;0;120;1
WireConnection;122;0;120;3
WireConnection;119;0;113;0
WireConnection;127;0;118;0
WireConnection;127;1;261;0
WireConnection;127;2;225;0
WireConnection;127;3;122;0
WireConnection;128;0;117;0
WireConnection;128;1;261;0
WireConnection;128;2;225;0
WireConnection;128;3;123;0
WireConnection;129;0;119;0
WireConnection;129;1;261;0
WireConnection;129;2;225;0
WireConnection;129;3;124;0
WireConnection;135;0;120;1
WireConnection;135;1;129;0
WireConnection;137;0;120;3
WireConnection;137;1;127;0
WireConnection;133;0;120;2
WireConnection;133;1;128;0
WireConnection;139;2;134;2
WireConnection;139;3;136;2
WireConnection;139;4;133;0
WireConnection;138;2;134;1
WireConnection;138;3;136;1
WireConnection;138;4;135;0
WireConnection;140;2;134;3
WireConnection;140;3;136;3
WireConnection;140;4;137;0
WireConnection;141;0;138;0
WireConnection;141;1;139;0
WireConnection;141;2;140;0
WireConnection;178;0;142;0
WireConnection;143;0;141;0
WireConnection;143;1;120;0
WireConnection;143;2;178;0
WireConnection;13;2;174;0
WireConnection;144;0;143;0
WireConnection;171;0;13;2
WireConnection;169;0;13;1
WireConnection;169;1;171;0
WireConnection;145;0;144;1
WireConnection;145;1;111;0
WireConnection;147;0;145;0
WireConnection;147;1;144;2
WireConnection;147;2;144;3
WireConnection;168;0;169;0
WireConnection;167;0;168;0
WireConnection;149;2;147;0
WireConnection;149;5;148;0
WireConnection;149;6;146;0
WireConnection;162;0;39;0
WireConnection;162;2;163;0
WireConnection;162;4;164;0
WireConnection;176;0;162;0
WireConnection;176;2;175;0
WireConnection;150;0;149;0
WireConnection;170;0;167;0
WireConnection;166;0;170;0
WireConnection;166;1;150;0
WireConnection;166;2;176;0
WireConnection;191;0;166;0
WireConnection;192;0;191;2
WireConnection;192;1;194;0
WireConnection;193;0;191;3
WireConnection;193;1;195;0
WireConnection;196;0;191;1
WireConnection;196;1;192;0
WireConnection;196;2;193;0
WireConnection;197;0;196;0
WireConnection;198;0;197;0
WireConnection;199;0;200;0
WireConnection;199;1;198;0
WireConnection;160;1;209;0
WireConnection;201;0;199;0
WireConnection;48;0;13;2
WireConnection;258;0;160;0
WireConnection;203;0;197;0
WireConnection;203;1;201;0
WireConnection;203;2;202;0
WireConnection;45;0;48;0
WireConnection;158;0;258;0
WireConnection;158;1;203;0
WireConnection;158;2;159;0
WireConnection;173;0;158;0
WireConnection;51;0;45;0
WireConnection;51;1;41;0
WireConnection;172;0;173;0
WireConnection;172;1;51;0
WireConnection;18;0;174;0
WireConnection;18;1;17;0
WireConnection;241;0;230;0
WireConnection;17;0;13;0
WireConnection;17;1;16;0
WireConnection;223;0;100;0
WireConnection;223;1;222;0
WireConnection;53;0;172;0
WireConnection;53;3;74;0
WireConnection;34;0;14;1
WireConnection;34;1;36;0
WireConnection;130;0;129;0
WireConnection;267;0;264;7
WireConnection;270;0;266;0
WireConnection;270;1;272;0
WireConnection;153;0;156;0
WireConnection;16;0;34;0
WireConnection;231;0;210;0
WireConnection;231;1;229;0
WireConnection;272;0;271;0
WireConnection;272;1;271;0
WireConnection;272;2;271;0
WireConnection;224;0;99;0
WireConnection;224;1;222;0
WireConnection;229;0;230;0
WireConnection;229;1;232;0
WireConnection;131;0;128;0
WireConnection;226;0;107;3
WireConnection;55;0;53;0
ASEEND*/
//CHKSM=DEC134DB6D6F8E693A247F33D1CD6E5A7729D834