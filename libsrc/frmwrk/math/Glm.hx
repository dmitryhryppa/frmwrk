package frmwrk.math;

import cpp.ConstCharStar;
import cpp.Star;
import cpp.Void;

@:unreflective
@:include('./GlmHeaders.h')
@:native('glm')
extern class Glm {
	@:overload(function(v1:Vec2f, v2:Vec2f):Vec2f {})
	@:native('glm::cross') public static function cross(v1:Vec3f, v2:Vec3f):Vec3f;

	@:overload(function(v:Vec2f):Vec2f {})
	@:native('glm::normalize') public static function normalize(v:Vec3f):Vec3f;

	@:native('glm::radians') public static function radians(degrees:Single):Single;
	@:native('glm::perspective') public static function perspective(fovy:Single, aspect:Single, zNear:Single, zFar:Single):Mat4;
	@:native('glm::lookAt') public static function lookAt(eye:Vec3f, center:Vec3f, up:Vec3f):Mat4;
	@:native('glm::scale') public static function scale(m:Mat4, v:Vec3f):Mat4;
	@:native('glm::translate') public static function translate(m:Mat4, v:Vec3f):Mat4;
	@:native('glm::rotate') public static function rotate(m:Mat4, radians:Single, v:Vec3f):Mat4;
	@:native('glm::value_ptr') public static function valuePtr(m:Mat4):Star<Void>;
	@:native('glm::pi<float>') public static function pi():Single;

	public static inline function matToString(m:Mat4):String {
		final chars:ConstCharStar = untyped __cpp__('glm::to_string({0}).c_str()', m);
		return chars.toString();
	}
}
