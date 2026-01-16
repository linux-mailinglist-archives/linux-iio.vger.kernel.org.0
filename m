Return-Path: <linux-iio+bounces-27892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3087D38913
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 23:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54C530B0DA3
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 22:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0822FDC22;
	Fri, 16 Jan 2026 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M7HQHeGn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2F2D780A
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768601043; cv=none; b=RDzSt8uKqPyKe4tfvXRQF9oHb05BYpMfixvT53N8KQDOJUr4VTftJEz/omK9pKqp370VtKTWYqsUi5+U4S6BNzS5LKDv5VPwMC3F3hk54hWDRhN70QtLmhnTCl9DOT5IwPDgSRITJCCwvztApsxDOOAdl9B515rgCHkEDm2dJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768601043; c=relaxed/simple;
	bh=6tyjTajdOQh6J57U/rMOsH8jV3xfmFKJ5YGgVVF1VoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrWy01JtGtzopBrTKLD/lqpSaBPCnidHqUxDIdMJERespg23IOVgTRwd/tsKl+1VWtEwaWmWDKn+VK/03xC6ODuIK8P8QAlF7No4ul15Deee8kCbMyEDjufrjXNskUeeCaq6Nnuonbs0r83m58tlAJNt0f4a8S7JaLptbaGwq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M7HQHeGn; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45ca0d06eddso720732b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 14:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768601038; x=1769205838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIt+ZzeCtP7pqDmlgpYUQhxXE3OKLmphYCyoYGAfb3I=;
        b=M7HQHeGnR/x/f/5HIdCcKrt/y9i/PxRJ3b1TUx6ox7f1ljkWFWRVxoD38motfGT7yz
         LIXe1HFwkFD1tsU9jgL23NwKH1Y4/uDytK3Yoj4RQpPBQ2++tYQjILz4jFzhBW91ve5q
         VDOAYvI9Y3DUyAp4sUBaB/qfIOLtwfBisTHTOGn7ddm3Upw5ItNaoJXGWe0R3sbmSMNM
         w5INf09pxfHP2a0+HS/vqHCkEr7LinXF/JIK/iPr1MqDlTzJ30NYSCs47NWPdKtGz6C4
         GyXyZqNU+lAfGiFJAobZDEnwoCF2XOFiZe1ToTnVtJUYXCh0XPFwJgXobTajHTND4P9E
         qjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768601038; x=1769205838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIt+ZzeCtP7pqDmlgpYUQhxXE3OKLmphYCyoYGAfb3I=;
        b=pqoMDm97woONE6ySkE8GDNx1MQYC2vUWo+DCvxfEKYFGRURNch38KQ4HpiMwcfT+ls
         1YOeHGvC3yNcnvEz021jQi63mMP9vqFV9/FkO1ih4D+A9XYCRKByNV5fqfXAEcuhz3Ee
         n9W4PZVROvD/veSJssiOkpau7d1/9Sz/nEHUN/CfXmw2RLSvXaoa8Z8HMbGoLFCE5zb5
         UWr1cj7s4kQrgLAtEKfjLLMg/xVtZGgGPlfSB0ADO4Ttd4X3ZZJQ7AzIIiSVTiTchaXL
         dAYvuQivmNU5coK9KVDqb5Jh5jFp283t5fW5tYOhBu//Sbu4sj/X/vvjimL69/SDIP1K
         Gwlw==
X-Forwarded-Encrypted: i=1; AJvYcCUZbOUqG+r98ASS8Qa3ZU2igoipsx+2ZRhggrWn8OuxlXpT4wWHAYE6fz99GpyFkjSyQLpIU5AN2Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGV1xipvFRLCisw62D8OKu/NDpibDUrsReM9wCij85pV7i/zCc
	6gD2ISR3MlRU7h4fy5m1p5yEw/M5FDW+8CWl2G+WIoLaSxhKSMi9x5D11FKeL+v8g9U=
X-Gm-Gg: AY/fxX4a7o6oxj+9YXgnP8mjY1WovB4Rwkd1baDLCBjheq4AVCMMM649SvyP/X+glly
	QPPUvqYAWqbqEWoE5u19yDxyVk/2lzYJ53Z7zcQ1ptjdKCDH7w4RhDIiDuq/uXF45lU3OV7hDaj
	ahklB8wyay52wnOxI/4mBSA0UktU4oi+UzhQX5m8RNfnVDbaJvWmEIm/GVCDXBZTpYp30quTZvX
	OdMJsjvqHLHXI/oy+u4Ik60QqRXCgmr7xtLwTDnfzLCB+AKQBhtQdRNVnuHHweua6vt5vRXrt0Y
	NMFyls7vLND47ofC2BnN5GRxiSnUpXgdRGLf7WBB/4Df9N+OwZG7W3+UTpy1HfDCg8VPETwseNg
	YWZt3o8le16P4bu6GTeCRaifPvDTXlpE1+RO9U1DzYYeN6oea2BI1JGO3v1CfpUq04NrKTJMg/l
	ksXO+OoQ5cjAJZJmyGmHztixoyoquyHa/NbKQs1bVPAcx6hOHhC7IuO+RhtMez
X-Received: by 2002:a05:6808:4f4e:b0:45c:7eba:576a with SMTP id 5614622812f47-45c9c1a732emr2028739b6e.64.1768601038648;
        Fri, 16 Jan 2026 14:03:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd14883sm2386316fac.12.2026.01.16.14.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 14:03:58 -0800 (PST)
Message-ID: <27cf1ec1-545b-4e44-8229-852f8bdae116@baylibre.com>
Date: Fri, 16 Jan 2026 16:03:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 2:06 AM, Kurt Borja wrote:
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

I don't think it is usual to put the function parameters in the
doc comment like this. They don't match the actual names anyway.

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

If we always have to add the & at the call site, could we just
put that in the macro instead? Then the parameter would just be
claim instead of claim_ptr.



