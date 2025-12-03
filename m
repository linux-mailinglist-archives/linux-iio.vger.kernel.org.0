Return-Path: <linux-iio+bounces-26715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D59CA1CD9
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA93E3007944
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125512D12ED;
	Wed,  3 Dec 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zDWSnCz5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037E2C0281
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800346; cv=none; b=Pa3nPIKoKqjgzOOtTridAwV1fL/cAug7jA0GmEsHuT1u98ljiuWU+/OaT5GVbwhyVO5+SeTKyyCSRsMtXvyI/ez5nbIK12loxmT/R03ISPllK+yOArg3VPhguNT6YiPTOTXoOmnhfkTd0Bz94STbo9bERjU/416uR2mKQWNM2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800346; c=relaxed/simple;
	bh=/A8SutLmf2Q2imzqCQUE3XZdtGNiq13pGzvVdsPO5K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iO3WAxYbisVy/0oCNMuB0CdhWQyHjL86wEtyZWxqhl4Csyq19wiPrefamW0NyjW+t4a9o71zq7A9I7xZhdAnWpN0zoFGQ+oTxP7bHpomsJ5H2e3o5Lfsk2UPTFKfUjc2Og/XjwKkbZ+FXx5c9aTvdLgry1VwP9cJbkYgJZhtNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zDWSnCz5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6d3676455so148656a34.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 14:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764800343; x=1765405143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAPxaKKcC1USyEphOzVRjJP6Se/Bpb7jNM6YYf1MCzs=;
        b=zDWSnCz5Xjy76l1nV55htjmrTTjdCLtf4U9xfYVEo3fsKU50oXLmmS/uWEZmPwRWsk
         2EN63Kj7RLJs4oPPWNWW+fusoRlTGug6zQLt1C+1N2vNmJf5Cus0QHOIku4/Kt1PA55O
         bSNaE1hlmY5OztExWha+KfCmzQhon010UU76vopoVBoICL/GREFNme+CAN3hyfT3Pit8
         bqKwnGedK5jfgOOHsyf4UxkIvJXTs6CE7Kb3KXRrdC88sWjHz9U9J4oCy6Aquzjugw3l
         UVYmJ05FsumasAlL5p8cSC6xZyGCiS1VdqYONEV8AQ7UhII/l4qc8kY2h7fZ2ScLnLIB
         hYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764800343; x=1765405143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAPxaKKcC1USyEphOzVRjJP6Se/Bpb7jNM6YYf1MCzs=;
        b=hhDJcMja+hZpPGyziIqP+Y+nPaw+HbEW34VNL+MDtASeTCvakSlbZ88nufuNHRYrZb
         VytthifmMHqobOlA0YMCS/Yg/OjyUiOFwTCNQQb/jqkfR3tBrFxmpIm5zRCabG2EDLIG
         hVBThV0VuJJfSx42jfmV+6IB7ZF3jnPaGgZaVyVps3GbQ/moCn7d4hjuKChAVxAQPRTh
         JdJK6inzkdqDaQBCRAP5nS1NgKAWuOKfo349Q8QX2ht/5RY0RcKAY+Ru30keyB9BTNqw
         glfltEya+6M+FmLE8qUVRpdiKp1zXSOyrQPxSox1kunJarmdbJA6BlcV+khnc9p1KHi4
         6v1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqmgeVmv6xrNHg2CImSX6x8SsXDV1NiSiBD8NTo60R10nyAWW6zWzvCkslJvf9BcdcbgouegfiMno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdw3sUUsVbzzHqMeTI9gbMD1tEN7SwOIr1H1IOCQA2G1o3pghP
	VRzFoFx32W3fXy3KYGd7TBrWDI/Dx6+A8F57M1ftWL6jsotYAnMAjY0FKTPalHld9A0=
X-Gm-Gg: ASbGncsOj9eWl92uq+aOWf+7kbFV8NvBnEyXdYcK81F+PkcE6ADWSeu9rz45RmyxYcP
	bYAM1f9fhduPEFgmsK5Mo/JykMQfM7JmJKogmcP3wuOfQmRRUtjOk7E6UMKYnJXHNhcBzy4FFrN
	FUDw0PWVddZPapvo9maix1RJy3oRUW5o8DwXS54DzpBOhbS05xFu2DyhSHLCOEMKNanqz8o31mJ
	q+T9bZ88Ld8JCIJYjxuLQhXclJ7Do2ZhzB/aEJ5OWVOpN+0GJwIRK3Pp69vmFok9Q3ixi5ZwgHW
	w5wOXjG/0Bnu0mQKYodYufX77l2GYvErFFdQtU6CUVjtJGIX01daiKUTB/tBToJCJIc7nX42AR7
	rdgqCAUS5HmqQDieoMA4r1ZbgOE7nyy6fBLNnjx7msatDA83s0JsZ0sbKFCndqHnT26bUDpu4A+
	gSYFKGEbRHwwrUZDi22w==
X-Google-Smtp-Source: AGHT+IF5slHx5Bd2B94CXXmhObw9UK5qoL62ZWpeXd1Z6+SRzywIRLzzipQNQCozh6c/1RDA7X0iAw==
X-Received: by 2002:a05:6830:2b09:b0:7c7:6c4e:ad2 with SMTP id 46e09a7af769-7c94db3e9a7mr3598489a34.11.1764800343451;
        Wed, 03 Dec 2025 14:19:03 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:25f4:78dc:7b9e:e7a4? ([2600:8803:e7e4:500:25f4:78dc:7b9e:e7a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0f49esm9495223a34.22.2025.12.03.14.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:19:02 -0800 (PST)
Message-ID: <5e8e3ff7-09e2-48c3-a9c4-cd7e5d6b850c@baylibre.com>
Date: Wed, 3 Dec 2025 16:19:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/6] iio: light: vcnl4000: Use cleanup.h for IIO locks
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
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-4-b4a1fd639423@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-lock-impr-v1-4-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 1:18 PM, Kurt Borja wrote:
> Use ACQUIRE() for iio_device_claim_direct().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/light/vcnl4000.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 4dbb2294a843..55e5060ce337 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -25,6 +25,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/interrupt.h>
>  #include <linux/units.h>
> +#include <linux/cleanup.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> @@ -1148,36 +1149,27 @@ static int vcnl4010_write_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long mask)
>  {
> -	int ret;
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
>  
> -	if (!iio_device_claim_direct(indio_dev))
> +	ACQUIRE(iio_device_claim_direct, busy)(indio_dev);
> +	if (ACQUIRE_ERR(iio_device_claim_direct, &busy))

Calling the cleanup variable `busy` seems odd to me since if
we successfully make the claim, busy will be non-null and
therefore `if (busy)` would evaluate as true even though
it wasn't "busy". I would call it `claim` to match
iio_device_claim_direct().


