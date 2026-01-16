Return-Path: <linux-iio+bounces-27888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F0D3878B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D074A30024C9
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771D3A1E9B;
	Fri, 16 Jan 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3ZenQvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096C3054D8;
	Fri, 16 Jan 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595380; cv=none; b=FKkd+DzjU+qHz6o/GNJlkpeZjNrh7HmJtdupwEPdgQEZ0DxtP9wFUsBx4msw41J64e7VElg+yq/Rty8Nhx9Tr1MgrGw/MO+Wh2trBQzwbx6q/r2aqjCmbnX+F5Tcm/5BkYsrWuXjGo5HlLvlIYYIhMpX6WNlX8bUNGfauIjgjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595380; c=relaxed/simple;
	bh=PI5ctFnVJ60sPfGxv/jo5/c755ensZSp+0m+TNJPgxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPap6xIEtNOtCn/DSFxIubx0knwXEqaag6Qo0dBA+99Jl4qytNiezw1eiGdk0ZUuGKLCfj0fY6Z0yjLhsMJaIu5Sb1BfD2Hy0BnC75YK2Qz2xL52SPHbWM1OjHAmzRW/Fkw2kwmnNVMlJm8X/WewdfIwq/HfgT4PkCjcDy4qt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3ZenQvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0EFC19422;
	Fri, 16 Jan 2026 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768595380;
	bh=PI5ctFnVJ60sPfGxv/jo5/c755ensZSp+0m+TNJPgxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t3ZenQvzZduhLAwsGWwA0gAxWZCq4b06L5nh09o0xT2WkDMAKKC9B2v2G35umjmcu
	 1jUPQliWy2bLvuOvR4ha2jadRRuRO16tKcbwgEbwsHIhmdBOaGkBYP4zFPiYyDKiSQ
	 uYaNnxhUYlqsy0JnXqZd9h/3pcF+JeoGvzEn79If2phP+0W5+cKEaBbUp+5dB8I6OD
	 vzVjBIepHovGqQA9mswR2/NYseRoLcejsQMP0U8K9fm58E4OPyWDsYdNzmNHHLJGBo
	 PSSCaZqU/1hEB/5tB2tDnENIGshGqzYy+d87nXO2DTEcaHQjH07HDwo1bFoPHG68L0
	 /u2RewD4LilAg==
Date: Fri, 16 Jan 2026 20:29:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Message-ID: <20260116202928.6ec155ed@jic23-huawei>
In-Reply-To: <20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
	<20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2026 03:06:59 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add guard classes for iio_device_claim_*() conditional locks. This will
> aid drivers write safer and cleaner code when dealing with some common
> patterns.
> 
> These classes are not meant to be used directly by drivers (hence the
> __priv__ prefix). Instead, documented wrapper macros are provided to
> enforce the use of ACQUIRE() or guard() semantics and avoid the
> problematic scoped guard.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Very nice. Trivial comments inline.

J
> ---
>  include/linux/iio/iio.h | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index d8af0456f966..c795f731f2d8 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -10,6 +10,7 @@
>  #include <linux/align.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/cleanup.h>
>  #include <linux/compiler_types.h>
>  #include <linux/minmax.h>
>  #include <linux/slab.h>
> @@ -740,6 +741,76 @@ static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
>   */
>  #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock(indio_dev)
>  
> +/*
> + * These classes are not meant to be used directly by drivers (hence the
> + * __priv__ prefix). Instead, documented wrapper macros are provided bellow to

below

> + * enforce the use of ACQUIRE() or guard() semantics and avoid the problematic
> + * scoped guard variants.
> + */
> +DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
> +	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
> +DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
> +		  iio_device_claim_direct(_T));
> +
> +/**
> + * IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) - Tries to acquire the direct mode
> + *                                           lock with automatic release
> + * @dev: IIO device instance
> + * @claim: Variable identifier to store acquire result
> + *
> + * Tries to acquire the direct mode lock with cleanup ACQUIRE() semantics and
> + * automatically releases it at the end of the scope. It most be always paired
> + * with IIO_DEV_ACQUIRE_ERR(), for example::
> + *
> + *	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> + *	if (IIO_DEV_ACQUIRE_FAILED(&claim))
> + *		return -EBUSY;

I don't think we need two examples. I'd just go with the second one as
the braces is indeed something people get wrong with the other cleanup.h stuff.

> + *
> + * ...or a more common scenario (notice scope the braces)::
> + *
> + *	switch() {
> + *	case IIO_CHAN_INFO_RAW: {
> + *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> + *		if (IIO_DEV_ACQUIRE_FAILED(&claim))
> + *			return -EBUSY;
> + *
> + *		...
> + *	}
> + *	case IIO_CHAN_INFO_SCALE:
> + *		...
> + *	...
> + *	}
> + *
> + * Context: Can sleep
> + */
> +#define IIO_DEV_ACQUIRE_DIRECT_MODE(dev, claim) \
> +	ACQUIRE(__priv__iio_dev_mode_lock_try_direct, claim)(dev)
> +
> +/**
> + * IIO_DEV_ACQUIRE_FAILED() - ACQUIRE_ERR() wrapper
> + * @claim_ptr: Pointer to the claim variable passed to IIO_DEV_ACQUIRE_*_MODE()
> + *
> + * Return: true if acquired the mode failed, otherwise false.
> + */
> +#define IIO_DEV_ACQUIRE_FAILED(claim_ptr) \
> +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_direct, claim_ptr)
> +
> +/**
> + * IIO_DEV_GUARD_CURRENT_MODE - Acquires the mode lock with automatic release
> + * @_dev: IIO device instance
> + *
> + * Acquires the mode lock with cleanup guard() semantics. It is usually paired
> + * with iio_buffer_enabled().
> + *
> + * This should *not* be used to protect internal driver state and it's use in
> + * general is *strongly* discouraged. Use any of the IIO_DEV_ACQUIRE_*_MODE()
> + * variants.
> + *
> + * Context: Can sleep
> + */
> +#define IIO_DEV_GUARD_CURRENT_MODE(dev) \
> +	guard(__priv__iio_dev_mode_lock)(dev)
> +
>  extern const struct bus_type iio_bus_type;
>  
>  /**
> 


