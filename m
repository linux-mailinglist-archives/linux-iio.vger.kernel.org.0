Return-Path: <linux-iio+bounces-23983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA2B532D7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF361C885A7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B556324B22;
	Thu, 11 Sep 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0HYpqA9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C767322DAA
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595306; cv=none; b=lgcLy+CjlVXAf9m/kSXm8JtN1ggC2Q6xSX/DdC0eLuVTpvKtf9QoCk7+G1Cf+mkm1Qg42F9J/wBlklQdXJjg+wnfxmYlVvCT6q2PUwaJ9tcRzEls/Me0ZejJBEloo3VtlV4uSz/fAMdSvQixixXpmHFKe36lrO1Zd5fel/W2zzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595306; c=relaxed/simple;
	bh=2oSOqVZN2yEJdOr1yjJzjaX0EOiSKgZ7QouF6tLg8hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAh/cOgCJASGNN9Dw9Lb97XwLbh+LP7CNguc0fuAQgXI1031UdWBFVdsPYazGifF0Jsd/vrvgz11c1lkTcTog+r5kVhSIeX3oZtpBvcev4dwPts5BUy48jOsNyjFlHBlKywr0T1x1xK2uHStSC0ydYm4XWr2ZqbOroS7B6n/vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0HYpqA9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e7643b0ab4so6542f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757595302; x=1758200102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzHYWAUSXTU099HyzOJQWZd7CmwZnR6rVbbpZB00I6A=;
        b=i0HYpqA9pIZnYpH66vlaiYOoUVo2UcmMd8R1bZO1Br3fDvHP+XPLOWDweEnV9BG28l
         KMKIHIzqJVThkhBxjoonazAog5ojh8jILz2Ho5p9H+2irfGIsTAq0VF6jqSvTTlWl01g
         daNCOngDBz+dKWsV76O8rk3udNhCD1QFVtAgU6K3NgDa5iwuwjL7rUAeKgeDyixhotbb
         6/Zj08lQJtTUQJXRd2ABrbVpg/boX6pgUxdq32ovPgeZVfgE1iS/GGFX9vbhi6mks5Ae
         cwksYUyX966LFxtasKaaA4ifA+3ZkJLpg8IGObzFFsaohT04aIjla/ZJP0AxSMcBUMxk
         tDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595302; x=1758200102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzHYWAUSXTU099HyzOJQWZd7CmwZnR6rVbbpZB00I6A=;
        b=rECPz4vUr8Sq2Sr9xoqY5dBGQzCithUvOwQSm3/TT3IPihUDa+chTW9mPF/st3butH
         fRNrk7QQD5YLNP5IlbKPsqnuuDTMq2xn9r6KCg7tdIl/ore4TqvR8DH6w4VRuiLoa5xD
         CY3b7z/LT6WEP/FDFQ2VFxLPqYb8GxUWTR1QM+2KADAwQ8DCGXmJByh193e60/+ZV0kM
         lHLvugeaEQOPQVxypI+K/ZPK6xoOpxLW5uqVUODm60r1XrLLlmSJoqBGucHkHhKRV7ft
         2nuhceY9cI49xBx69oDYg24+SOrQ1+XM13c2roZD1FlrNr7wTkvZKaKdar1S19Qv+1aR
         JorQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtixBbmVsy22HNb+cA3e66Xc1h4gDrDmMzxEf2lSkIXX+a6tSAbuy1xQkqn8h0A1bfx4KRE/3L+Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywei+fBaYLcge4HVKHZwM49rnrLUVNRmPgt0and0l5MKdrQQcs2
	RCi2ZAF9K+BlSuXA2J3tslMDbKLPdmLIGy+0GjMGgKCJCtQ5t56dZjnrAnVLmmriuAw=
X-Gm-Gg: ASbGncvQFTWlrgAzKgcsE6Dr7zeZ3PJw81IouD120+xk/6HydJqVjYv/hrE0YweWGP2
	MwJx+GvGwDfXYMyfMD51Ryh+AmFXMJew3nWAefhD6lULC7aiQZfT6Egj5/RDn/qirCwbEHiH28/
	dnp5kJR4hf5Hj5r4e5JAa7zOjPt2d3XGYge4hNHiAGKVuYnsR2kDPCRuQvsHQY8wCgq3VMx3W/S
	qe3o3FFLoxVAINqc6hq1ix3VbjxWMll0LF3HYCaye6C2+EegkkI2rBgYU0VNFCOFRY9v4ahGBUG
	7aeT9HNA1my47HlE5WAHwL3XUHRoZlAOcR0S0NP1TXaQZmLodDomjSCBcTPwbGsucMjoKX1Bxej
	J4xIGi+OSFaNUp9YGGGRbuTqcS8rEeDd5e4omJ/Ud9JSp1LP4J31Wykq7fwrLnwO3T5EAj/8ePc
	nLsW5jdQFs7jKRdZnPX7iPykI=
X-Google-Smtp-Source: AGHT+IEebi/zE5XDYf831iEgQZ391cMJunsa1tiSBIWMBmOGscKQgCSQqBnDSCMdT7jr02fwbzNWdQ==
X-Received: by 2002:a05:6000:2003:b0:3e4:bb5f:ee6d with SMTP id ffacd0b85a97d-3e641a6015bmr16847418f8f.15.1757595301674;
        Thu, 11 Sep 2025 05:55:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d521:838e:7c69:f457? ([2a05:6e02:1041:c10:d521:838e:7c69:f457])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7607d7593sm2360205f8f.43.2025.09.11.05.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 05:55:01 -0700 (PDT)
Message-ID: <b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
Date: Thu, 11 Sep 2025 14:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
 <20250910155759.75380-3-daniel.lezcano@linaro.org>
 <20250910183212.6640e662@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250910183212.6640e662@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Jonathan,

thanks for the review

On 10/09/2025 19:32, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 17:57:56 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>> +/* Main Configuration Register */
>> +#define REG_ADC_MCR(__base)		((__base) + 0x00)
> 
> I'm not really convinced these macros help over just having
> readl(info->regs + NXP_SADC_MCR_REG);

That is really a matter of taste :)

I used to create this format in order to stick the macros with the 
debugfs register code which is not part of these changes. There is a 
similar format in drivers/clocksource/timer-nxp-stm.c or 
driver/thermal/mediatek/lvts.c IMHO is less prone to error than base + 
REG all around the code.

Do you want me to convert all the macros to info->__base + MACRO ?

[ ... ]

>> +static const struct iio_chan_spec nxp_sar_adc_iio_channels[] = {
>> +	ADC_CHAN(0, IIO_VOLTAGE),
>> +	ADC_CHAN(1, IIO_VOLTAGE),
>> +	ADC_CHAN(2, IIO_VOLTAGE),
>> +	ADC_CHAN(3, IIO_VOLTAGE),
>> +	ADC_CHAN(4, IIO_VOLTAGE),
>> +	ADC_CHAN(5, IIO_VOLTAGE),
>> +	ADC_CHAN(6, IIO_VOLTAGE),
>> +	ADC_CHAN(7, IIO_VOLTAGE),
>> +	IIO_CHAN_SOFT_TIMESTAMP(32),
> 
> Whilst we only insist on monotonic numbering, putting it all the way down
> at 32 seems excessive. Why not 8?  Perhaps a comment if this is to avoid
> moving it for some future feature.

The ADC has 8 channels for external acquisition however others channels 
8->31 are described as reserved. They may evolve in the future to more 
channels. That is probably the reason why 32 is used here.

[ ... ]

>> +	indio_dev->name = dev_name(dev);
> 
> This should be the 'part number'.  That is a little ill defined
> for a SoC integrated ADC, but generally not what we get from dev_name()
> on the platform_device.

Sorry, I don't get the comment. If I refer to the different drivers 
there is not consistency with the iio_dev->name.

rtq6056.c:      indio_dev->name = "rtq6056";
rzg2l_adc.c:    indio_dev->name = DRIVER_NAME;
sc27xx_adc.c:   indio_dev->name = dev_name(dev);
mt6359-auxadc.c:  indio_dev->name = adc_dev->chip_info->model_name;
mcp3911.c:      indio_dev->name = spi_get_device_id(spi)->name;

Are you suggesting to use the compatible part number ?

	indio->name = "s32g2-sar-adc";




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

