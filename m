Return-Path: <linux-iio+bounces-20968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE7AE9525
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999116A007B
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 05:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C405A2135D7;
	Thu, 26 Jun 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcnmxyIb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E161BC9E2;
	Thu, 26 Jun 2025 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915487; cv=none; b=Vz3n0FujlcUHoEeoCCfSQ7KIbEpsc5IkJTRX2UlPTEuLOcQ0P7yfSr23hH8XyTXloDC6/zfxgLlGP7UdYzUYyQZrjt1JiRZfMDBC+KvGTqwUukDxGnQeADigOP2MzkvGsGmzGtGGh03PYLQi/WMz3+4n0ljDKeNdKKINWYdTpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915487; c=relaxed/simple;
	bh=iBQQwEBGxbk3afYSw03+fGXpz55h3dAShiAwQQQdpMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCJ5h5DsYZ9NKpbmyWoiJGAVgYvS1vaKpg8/LXkAnzEpZFHFkFTjvv4v6XISEmtnx8eIhbpDd593NVm8vSinOpdQ/uXarkOD7g4hLEAbEs/Ftasmp4Gj6B1etEPzwC+bXq33U7GJRhhf51xN2esbisOrjNzlEIOwHEFcTdjKztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcnmxyIb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553cf020383so589057e87.2;
        Wed, 25 Jun 2025 22:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750915484; x=1751520284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uu+PcA2M9xAN/Gp41c21x1ds5eVoC83exOsltc9gBIU=;
        b=WcnmxyIbLKDhFRmH3IDZrOMaqlbYDrdZsOrXYZLAfMT5MJ2OMmYZOrPPFIkyBAYsgh
         OsVcyP2O3MeOMHJyymnVd61UjqeThIzTKaYQy0NNtPDe7K0jMOQHaZoIWqdVjdCEpAXO
         XP5kz6lvafZTYKpOQq2qDPdg4jWUJ0jzyqW2ddShVJnOJoG6TN0MgA7wmcX8Hs9EERUA
         oRpa3QehUmdoe4rsqZGg9THhj2jYCWnlWcGJrTmBIe8TM95PNyCfB90FuvnHXeG3VCGv
         1NEPPjd7CzA69U1yoa9zLXGQY2oeI6tC5i+zu8K8x0GT4qXrpk9mm1FCCDzCK06B0U66
         dkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750915484; x=1751520284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu+PcA2M9xAN/Gp41c21x1ds5eVoC83exOsltc9gBIU=;
        b=pMy3MiyKIuO6dNKQzFO1mnJJ6j9JQp3O8yxJ+4WIX5+1dodd8VI+Rp9ayV/XdEUezZ
         ykNyb6XLZm/tYuGqdoO82Kz06as5m1nulYBh5Ilg0gNirzkGZCHb//WLgSyL+Ljgydcc
         C69OKGDlJXQuCCbbPfiqTvBI/ORilc0Q0iU24rQ0RhalnnKe+87EHyFjYSNM38U0NGh6
         NbVOhzJ7OaDxbavXEWS8Kot0/g58OzKA6IsBdMsBoAejfjO9yjfh9CYlEf7bMIZ1bFEP
         WVejWcacIwAjB7EdyB5CN0JOOgJc1sp93j4stmXG1vj6h9IaUtSOUKqzYqFvpWrR8J3T
         6WoA==
X-Forwarded-Encrypted: i=1; AJvYcCX4XhwTmC1jQBnWIfQYb67KGhEo1gcduArOUpeQi1W9c/qDRW8uq7LmTTKeT5bekklrwfSFqOTrdBOeKfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuO7EIJ5nFm08NlHrWWczR38Et9dDFvs72uHavIAnH8ao2nKq0
	mK3B2TKmq0BgFxxyKdEHf+GZ07WfXgPFYpHd6pNC47LNzno7uQf2h6ou
X-Gm-Gg: ASbGncvPh/PK6JEKujqWm/UC1ice/rSAujMb7AEXWVrkbuNaZZkXtA6W/WH2ZBEOI0P
	bFgRE3icnR2qHwOO1aru4MkPg+3mFbDafOgWWs05/Nfi5qMdMY4kRdjPermqqN6DxR8iYZAPrNW
	ThRNCuMcjVAxl9V/K604GC9GIacmhX0Y952BUy6pOFkVyuQAgCHaw9dyH+xaCJaOMbpyfC+zHjO
	wnILbYRoPsqW2BjNUvZcb8Xns9FkgCoGBT2jhwRHs89a97w1O0A+7bsyjOfZoLA2vDyDqusgKVo
	Q+kxugcNk5tQvGXRLW4dFwHyDBX/0QNMHF6J5GGGlnzucf/n6bT9faoHPO9DR8Y9movXs503/0w
	+Pi57Nv/7TH37NLs4U95K17De30vAMWzxLt6C1hlB664=
X-Google-Smtp-Source: AGHT+IEsC4rDc+64YF1sGfY3ai9vBnsupasxMmqopeBsQPAEa8G5eRWY5JWsJXLWwT60frnqoSpf3A==
X-Received: by 2002:a05:6512:1052:b0:553:2868:6357 with SMTP id 2adb3069b0e04-554fdfb7fd8mr1754864e87.50.1750915483663;
        Wed, 25 Jun 2025 22:24:43 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c300bsm2418337e87.158.2025.06.25.22.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 22:24:42 -0700 (PDT)
Message-ID: <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
Date: Thu, 26 Jun 2025 08:24:41 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
To: Lothar Rubusch <l.rubusch@gmail.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-2-l.rubusch@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250625170218.545654-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lothar,

On 25/06/2025 20:02, Lothar Rubusch wrote:
> Add support for the single channel variant(s) of this ADC.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Thanks for this addition. In principle, this looks good to me but I am 
afraid there is another colliding series being worked on:

https://lore.kernel.org/all/20250614091504.575685-3-sbellary@baylibre.com/

Maybe you can align the effort with Sukrut?

What I specifically like (and think is the right thing to do) in 
Sukrut's series is replacing the 'adc122s021_channels' -array with 
individual structures. In my opinion the array is just unnecessary 
complexity and individual structures are simpler.

Other than that, this looks good to me.

Yours,
	-- Matti


> ---
>   drivers/iio/adc/ti-adc128s052.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 1b46a8155803..cf271c39e663 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,7 @@
>    * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>    * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>    * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + * https://www.ti.com/lit/ds/symlink/adc121s021.pdf
>    */
>   
>   #include <linux/cleanup.h>
> @@ -110,6 +111,10 @@ static const struct iio_chan_spec adc128s052_channels[] = {
>   	ADC128_VOLTAGE_CHANNEL(7),
>   };
>   
> +static const struct iio_chan_spec adc121s021_channels[] = {
> +	ADC128_VOLTAGE_CHANNEL(0),
> +};
> +
>   static const struct iio_chan_spec adc122s021_channels[] = {
>   	ADC128_VOLTAGE_CHANNEL(0),
>   	ADC128_VOLTAGE_CHANNEL(1),
> @@ -143,6 +148,10 @@ static const struct adc128_configuration adc128_config[] = {
>   		.refname = "vdd",
>   		.other_regulators = &bd79104_regulators,
>   		.num_other_regulators = 1,
> +	}, {
> +		.channels = adc121s021_channels,
> +		.num_channels = ARRAY_SIZE(adc121s021_channels),
> +		.refname = "vref",
>   	},
>   };

I'd love seeing this array split to individual structs.

>   
> @@ -207,7 +216,10 @@ static const struct of_device_id adc128_of_match[] = {
>   	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
>   	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
>   	{ .compatible = "rohm,bd79104", .data = &adc128_config[3] },
> -	{ }
> +	{ .compatible = "ti,adc121s021", .data = &adc128_config[4] },
> +	{ .compatible = "ti,adc121s051", .data = &adc128_config[4] },
> +	{ .compatible = "ti,adc121s101", .data = &adc128_config[4] },
> +	{ },
>   };
>   MODULE_DEVICE_TABLE(of, adc128_of_match);
>   
> @@ -220,6 +232,9 @@ static const struct spi_device_id adc128_id[] = {
>   	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
>   	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
>   	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
> +	{ "adc121s021", (kernel_ulong_t)&adc128_config[4] },
> +	{ "adc121s051", (kernel_ulong_t)&adc128_config[4] },
> +	{ "adc121s101", (kernel_ulong_t)&adc128_config[4] },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, adc128_id);


