Return-Path: <linux-iio+bounces-19264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321AAAECA2
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2197BE019
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE01C84B8;
	Wed,  7 May 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcX6uh3H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF952F43;
	Wed,  7 May 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648169; cv=none; b=k811OijwnrEmOgVkpBhxrlmPm/OPcnodUVYesy+p/3yckVRn208ZnIRZBFdYM1nUTPFhJb1dPZJWqiKFDHX09zbA5pt3y6AtNt9DvV4s/iahXDcWeX/c0wsDupLs2ONpWv0f9mMi6F8H4PDe6D5qqWMJqEX6dY35yYQfpjm12T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648169; c=relaxed/simple;
	bh=q+4Vm1PYBH6CIdNM0Gw2b0w1O7TXzA+u8T153cPkbyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRV9ZJ7Wk30ccXIwPa84zCXKubvXEp2zyNG0ux30iPI/WpUuljAn/qplJKSKhfaxWaYIHO0mwiPJMliRn+UtDf0goTiTPzJcc2jdOqxZGujxAxwZjIsHWWtNgj1kK3bx9lKGAaPcHIBRQb0uCxW0heUPEuaek93rQT74WEs6miI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcX6uh3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473DFC4CEE2;
	Wed,  7 May 2025 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648168;
	bh=q+4Vm1PYBH6CIdNM0Gw2b0w1O7TXzA+u8T153cPkbyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcX6uh3HhrZUHz+qYg8oXuS0Ko0agKZkUuL1RFxiOAO3blr43KaqIGb2+eI/jY+tl
	 h+bcuT4qABfWls3iQ4+lYNE7mJrE6WTb+oIo3VI40QbjUc7ZxHe7841+jZUYERDbp7
	 ZJ/xiCMwKUKPC8lIuH7YI71oNj/akff4FMmQzfT8tWY1ktMCV0M/aqAutxqn3rv0jB
	 41qMsriP5NiAXQcScDxm90Pb8PIpx51gWQbGpKupwa0mdDHKP8/glTmCjte/ST1byj
	 muPicNCBuvzJ+xpzeXocCuFQJrAUH29Qv5TL7C1l1raxOhovKwqHLXY8HUzeUOcOvT
	 TVGw+GqphxaPQ==
Date: Wed, 7 May 2025 21:02:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/7] iio: make IIO_DMA_MINALIGN minimum of 8 bytes
Message-ID: <20250507210239.138b3e0a@jic23-huawei>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-1-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
	<20250505-iio-introduce-iio_declare_buffer_with_ts-v5-1-814b72b1cae3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 May 2025 11:31:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a condition to ensure that IIO_DMA_MINALIGN is at least 8 bytes.
> On some 32-bit architectures, IIO_DMA_MINALIGN is 4. In many cases,
> drivers are using this alignment for buffers that include a 64-bit
> timestamp that is used with iio_push_to_buffers_with_ts(), which expects
> the timestamp to be aligned to 8 bytes. To handle this, we can just make
> IIO_DMA_MINALIGN at least 8 bytes.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Dropped again...

In file included from drivers/input/touchscreen/tsc2007_iio.c:8:
./include/linux/iio/iio.h:784:5: warning: '__alignof__' is not defined, evaluates to 0 [-Wundef]
  784 | #if ARCH_DMA_MINALIGN < sizeof(s64)
      |     ^
./include/linux/cache.h:181:27: note: expanded from macro 'ARCH_DMA_MINALIGN'
  181 | #define ARCH_DMAmake[3]: *** [scripts/Makefile.build:461: drivers/hid] Error 2
_MINALIGN __alignof__(unsigned long long)
      |                           ^
In file included from drivers/input/touchscreen/tsc2007_iio.c:8:
./include/linux/iio/iio.h:784:5: error: function-like macro '__alignof__' is not defined
./include/linux/cache.h:181:27: note: expanded from macro 'ARCH_DMA_MINALIGN'
  181 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
      |   

With an LLVM build on x86.

> ---
>  include/linux/iio/iio.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..7e1e3739328d103262071bd34ba5f6631163c122 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -775,8 +775,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>   * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
>   * must not share  cachelines with the rest of the structure, thus making
>   * them safe for use with non-coherent DMA.
> + *
> + * A number of drivers also use this on buffers that include a 64-bit timestamp
> + * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
> + * DMA alignment is not sufficient for proper timestamp alignment, we align to
> + * 8 bytes instead.
>   */
> +#if ARCH_DMA_MINALIGN < sizeof(s64)
> +#define IIO_DMA_MINALIGN sizeof(s64)
> +#else
>  #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
> +#endif
> +
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
>  
>  /* The information at the returned address is guaranteed to be cacheline aligned */
> 


