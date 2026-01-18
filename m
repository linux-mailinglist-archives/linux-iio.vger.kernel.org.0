Return-Path: <linux-iio+bounces-27929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B34D39974
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7B983001824
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5027055D;
	Sun, 18 Jan 2026 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eRtVkqHo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB2279DB1
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768764945; cv=none; b=CBbv8DfAimvEjR2eV9IAq2gxN5p6v1yb/bNAPQL1CTJOGxU1HIfJdDv5B0YMVuQ4oiUiqFWPWo2nA92uaGAEvd07dsoDtIcedqNxIruztHjIrsVmMQXQABB50d4NCEzzbmNACVGBI3iPieMdDaqOKT+jC7aCIBiEHPGs/Gn98hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768764945; c=relaxed/simple;
	bh=ZrkbSSR7SPbk0sXpHbnHk+xR9V/NadYrGwGl0W6n57s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emk9lyefh8phuLzcAcJUdkIJVCfli8/lx+KATOyu+I0tr3nuiHLkWmPEeedyaU/jq7HfHqVRswJgiEushn1liqHOYysUbqHsaYQ6eWe5wBzVtc1nGuop2KhBkbgXBj5Ok4TYpe8R2rD/pacTLc/IMk3d9AHwpPty8MNnWoCfKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eRtVkqHo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c93313721so2071923b6e.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768764941; x=1769369741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js92nL0F9mZGARPs875T0z11qnkMg6IzGWXmj5+ZqzY=;
        b=eRtVkqHoknami+JmYHI/j9eDdJwl65pnJTZwys0lKc6PYSVJccNGgVuX3lOf51vU4E
         ZhbqvgM37INnlpizdVkq7mJxV+SP4osL39WSP4sPL3SWBLItab2j4FajRgX2YRBBgNun
         ogScFZHCSyoWdNx3WdymEiQkuctNXHI6G4b1Y8vHt6lQdcUEnDR49+cZSFUQhzp71Sem
         AOmrKN3IqPcN/e/h2r6d2iXLZP7f0l3N9i+uML6zkPonTRLpZ4FPH0PT7934KhOBsbXv
         bXgjRs/QBb+9q+4wTbO+5+uGiidxAWb7/TiGvUDm8055WA+9IHD0bZDAPRZsDkztmkCC
         0VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768764941; x=1769369741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js92nL0F9mZGARPs875T0z11qnkMg6IzGWXmj5+ZqzY=;
        b=dLIq+Jt6mKR98a5nZ4ELglgVp+1i7YpR3cdKjzWJ30dDHZ2SiLLbMb49YvyfiSTIec
         lzAaTxSUtHKt5pZowZ6NxSteJ1Ar70z7qPy+67tYK1NB3wjhBBiGEOTJ3LDUQKmcezx6
         DKMDUW52H7jodI87CV4jIxf3uXvm1g4GM185mcC0TNrunKis2sjHeC+rCj4sng7PNa1+
         ctDGDz5dl8IWqmGvyOCWk44fy0o54re1osqpBJjs96ArI/RVq5i3Z8+zaY0N9bpbLQiR
         qQ9CnJVDwZBMuD7KrfYkYnVN46uFUkK/LYRu/CXmhJ2X0wBX9RO3TI+VERx7xRxNCCoj
         NBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVUVsp7VbL1WEqKj8qlD4ArzLKFGPxPsAbXMZwe6oxCFx5jvXRj2FX/PoHHatLnMwRZKem39Tz2lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlnkpBWg8LobNy1dzKXORdgU8UJwjj41o8qjabmUpwrjcaPV+
	+3oHZcXtwxSrAmnHDVxSKy6ChTnJLzOumH8KHsul8ze5iWR2/RJNPsPR/yb/Iyd4mbQ=
X-Gm-Gg: AY/fxX6qpVi6J33yCemyhBPjVrNSEKIzzho+4oDpaK/GLHsxxgRDQ+NUlWLUOX+BGS3
	6gMxMMSzltWbOVWjpq3w/vqMjgQ0TgEoT2mVHGcjDCMWQ8q1Tfqp9Ni0VZbH69b/FkxqJRXvVNq
	d+AJatIsljcHgYXHYwHj/NzPum0cJe5mPWmclUiaUnFViDpSRxgCH8XIcWx2AkM3PKNZzVqWqrc
	I47qxohylkeTzMcPk6sUdTvqVwFNWXTrrvfOG4l63IE8Nke7ZZVz5gNXt4ITdrMTCwNWFFiKvH3
	tXRU22sjq1jjdLKl1MOy0W1eNDn+ODABX1lEPKa/wPdyYy7kbWvBQemTV3LImzr6TqxA4tku9oI
	p+GU0PG9Tz0RFbbI1o+GsEckLI1THUSZi2F9rmpP0KmVsyI9fePs6jpPXi4gk1+pugSZmyncBPf
	QobaOL2kFdl4Kfubmx+S1y7rzQq4iptLNn4bfAkj8eyJBhf69kCPPmjKwOdqPa
X-Received: by 2002:a05:6808:198b:b0:44f:e931:38c2 with SMTP id 5614622812f47-45c9bf514c2mr4148232b6e.15.1768764941468;
        Sun, 18 Jan 2026 11:35:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d542:af69:64b6:f7df? ([2600:8803:e7e4:500:d542:af69:64b6:f7df])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e0086a4sm4522900b6e.12.2026.01.18.11.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 11:35:40 -0800 (PST)
Message-ID: <fef660dc-8c81-420c-95b6-cc8649971894@baylibre.com>
Date: Sun, 18 Jan 2026 13:35:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] iio: core: Add cleanup.h support for
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
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
 <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/18/26 9:44 AM, Kurt Borja wrote:
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
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  include/linux/iio/iio.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index fa671e120e95..4a0a77fcfa8d 100644
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
> @@ -740,6 +741,70 @@ static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
>   */
>  #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock(indio_dev)
>  
> +/*
> + * These classes are not meant to be used directly by drivers (hence the
> + * __priv__ prefix). Instead, documented wrapper macros are provided below to
> + * enforce the use of ACQUIRE() or guard() semantics and avoid the problematic
> + * scoped guard variants.
> + */
> +DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
> +	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
> +DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
> +		  iio_device_claim_direct(_T));
> +
> +/**
> + * IIO_DEV_ACQUIRE_DIRECT_MODE(dev, var) - Tries to acquire the direct mode
> + *					   lock with automatic release

Should be just IIO_DEV_ACQUIRE_DIRECT_MODE()

> + * @dev: IIO device instance
> + * @claim: Variable identifier to store acquire result
> + *
> + * Tries to acquire the direct mode lock with cleanup ACQUIRE() semantics and
> + * automatically releases it at the end of the scope. It most be always paired
> + * with IIO_DEV_ACQUIRE_ERR(), for example (notice the scope braces)::
> + *
> + *	switch() {
> + *	case IIO_CHAN_INFO_RAW: {
> + *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> + *		if (IIO_DEV_ACQUIRE_FAILED(claim))
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

This one is correct style.

> + * @claim: The claim variable passed to IIO_DEV_ACQUIRE_*_MODE()
> + *
> + * Return: true if failed to acquire the mode, otherwise false.
> + */
> +#define IIO_DEV_ACQUIRE_FAILED(claim) \
> +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_direct, &(claim))
> +
> +/**
> + * IIO_DEV_GUARD_CURRENT_MODE - Acquires the mode lock with automatic release

Missing ()

> + * @dev: IIO device instance
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


