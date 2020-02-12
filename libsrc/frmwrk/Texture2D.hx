package frmwrk;

import bgfx.TextureHandle;
import bimg.ImageContainer;
import cpp.Star;
import haxe.io.Bytes;

@:headerCode('
	#include <bgfx/bgfx.h>
	#include <bx/bx.h>
	#include <bx/allocator.h>
	#include <bimg/decode.h>
')
@:headerClassCode('
	bimg::ImageContainer *container = nullptr;
	bgfx::TextureHandle handle;
')
@:cppNamespaceCode('
	void imageReleaseCb(void* _ptr, void* _userData) {
		BX_UNUSED(_ptr);
		bimg::ImageContainer* imageContainer = (bimg::ImageContainer*)_userData;
		bimg::imageFree(imageContainer);
	}
')
class Texture2D {
	extern var handle:TextureHandle;
	extern var container:Star<ImageContainer>;

	@:allow(frmwrk.Res)
	function new(data:Bytes) {
		untyped __cpp__('

		', data.getData(), data.length, container);

		untyped __cpp__('
			bx::DefaultAllocator allocator;
			{2} = bimg::imageParse(&allocator, (const void*)&({0}[0]), (uint32_t){1});

			const bgfx::Memory* mem = bgfx::makeRef(
				{2}->m_data
			, {2}->m_size
			//, imageReleaseCb
			//, {2}
			);

			{3} = bgfx::createTexture2D(
				uint16_t({2}->m_width)
			, uint16_t({2}->m_height)
			, 1 < {2}->m_numMips
			, {2}->m_numLayers
			, bgfx::TextureFormat::Enum({2}->m_format)
			, BGFX_TEXTURE_NONE|BGFX_SAMPLER_NONE
			, mem
			)
		', data.getData(), data.length, container, handle);

	}

	public function dispose():Void {
		untyped __cpp__('bimg::imageFree({0})', container);
	}
}