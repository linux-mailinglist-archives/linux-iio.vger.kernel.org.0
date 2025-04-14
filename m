Return-Path: <linux-iio+bounces-18068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18267A877A1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 08:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5701890C54
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8671A2393;
	Mon, 14 Apr 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlXqQqtI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12B28F4;
	Mon, 14 Apr 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610441; cv=none; b=N+Ue5omNVH9vZbOVU2FJ2sRuv2XdeLTN+Hs9zmnNRFUZUK3OohsKofbo6eORbjVDpbID1+Qw6UAQPCaPEmC1BancykXqWJGfIomqRpudpe8M67rXbE82Ch/Myo5fBgoAuivvTpSWcqQelXA6LPukJ1VMVSil1cx9OqA9Qxu+tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610441; c=relaxed/simple;
	bh=rVZcTwDNqe0ZDhhksVpKMZmXPkNUspEtmilQLlgmpZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umMX19zqjw2JZ+zuu3UM8jIKPTndksIY+hIuiS763NaFb/4IQfp1vg+wbeT0BWKxTZzuwKDLHEV/iwsKcL+mOgThX5ANm+euL8SsJmoRwx3MY8Fh9EtGolVhSDWBSpMvPCCon56HwDh8B9Lv0gusLy+ePk9Z9jh42B/JivE2MXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlXqQqtI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499c5d9691so4168722e87.2;
        Sun, 13 Apr 2025 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610438; x=1745215238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcIn03qHBJHK9ZybMtH0fREfD8sLUUq68wtHGB9S3aU=;
        b=TlXqQqtIpRe7VSZoqqo08pCqRxinBk/sJLzCUNw1sCGE0ODH3zHgNDswFVObKs2CDN
         CdghX16cXwppnLizxoeKg+2FH7ipeRgfRJEANnktf6s27+pfqdyC3Y4APygkfzzhJgQH
         FZbZeYV0mGS+u+axYclK26RLMWPmMHFzN4GnNQt/zbWf6tYXwKd9NXLg1NNcDHqUWPf9
         6YAZW85MfaHTdD852nlBl1MDH8D6Y21BdmIXtDsQsBg2FYvyxuKB9glxg/iK/uQhl6AU
         HpoTRh7niIhhqQB+R2F/g1VJ9n84Xrztg4dVVOqNkWQxxDwYZL/lZc6342p+9AwbSMaX
         36yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610438; x=1745215238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcIn03qHBJHK9ZybMtH0fREfD8sLUUq68wtHGB9S3aU=;
        b=DQNTkCwP+t6+wLDW0kabBAZAboM9+Y92MYmShzIIxWI5lX5h+fC58pAOfN+2Y5DcZp
         tmYjH7aV5T2dczAgBFV5agesZ+gUHHoPiAvvtyndTeFckpFOmIm1sB55LpuTC/tc666a
         Qh9SY1QuqohDOylCyTHmlq0Q17scvZgSARiyHkZZDcQqVRUcAozIyrdq82NuvWjv2auO
         sRR/sChpfcyqQXah1Y18/MfsV6f5fCuGbaBZGd2KS+1kdL7l77fis9d8laS9ysJkLXVx
         ACr27SMK4fAI2FfB6ic9tu22VMuOuNbRAQA9jcVAKe4nMiyEkixDVtqCcdSF/xNtIOir
         GkJg==
X-Forwarded-Encrypted: i=1; AJvYcCUfEeCUQzEf6htz3QJh6EX8G65d3BUXKOJRdxk21OPYQJqXuMJ5EWG383wYgSQcWK3OCTkzPw741lqN@vger.kernel.org, AJvYcCVBDxTbdGeW2S1/XFYDp2rR2DMa5v01lvk3Odx3dS1cxi/wqtMIDhBJFkBNY7vh3QSQ5lujjqnDjJxSNGQW@vger.kernel.org, AJvYcCX3XRBcqYlhFDNK1yiiy9fCEsGktkcPediRqV6aPs80biG/vgaqPf8ObVIhxoz4npm+5YtTT71r8xSC@vger.kernel.org
X-Gm-Message-State: AOJu0Yytj84AmOnog9z9dlL5d6SikStnwqltHMfUKhEvRpaGIJlWoxFM
	c4H5zXE7asEO7yGGJD4uzlNfRqEpZeeUIluU0EWW5OhoZL+WNfh+GRdgFQ==
X-Gm-Gg: ASbGnctYq/8P/dZYvE56oMbSBHSU9rdhJjI6/bYPRzcer41UGcyl61rbKrSN77tvP1i
	AsmGyGxqwx+/p2uB/b56p55pRzTL4u69dBQzll1hoqZX5Zy179uaIZZIX/flCwiifXCxx0tN/It
	2L+6dIqPcdubIFWCKjs8eEzlkXI+aP6c9tU97UMbYkeAsXp4HRTwv70aTXIeAQ3EqcotoZNOSHh
	HZGwypCNiIvFlszu9hTp829zMhWBzdUh6Ts9zGLSdkefxotxv0v45q0ELNQRNqwdSDbh6rg0dR0
	6MyF3YtH0JAnDoxXuDZAXBq5m4MtGw1Ixw1M8ktd3UFzf9yHKGatsBVqthxnHr17doY5oUyu8ei
	giL1y0APwcbZ2ocdAfLRWFg==
X-Google-Smtp-Source: AGHT+IH0cUKTxL25iLjT2ZG9STnoFpV9gLLZyLsXwHIy6uY0/oJbxypUfloa/SLaEw0Worz/jhyBoQ==
X-Received: by 2002:a05:6512:3503:b0:549:8d07:ff13 with SMTP id 2adb3069b0e04-54d452d9b65mr3046591e87.51.1744610437469;
        Sun, 13 Apr 2025 23:00:37 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d52037bsm997934e87.241.2025.04.13.23.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 23:00:35 -0700 (PDT)
Message-ID: <ab0fa023-91b6-48de-a71d-95eb9aa70c01@gmail.com>
Date: Mon, 14 Apr 2025 09:00:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 8/8] iio: ti-adc128s052: Drop variable vref
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1744022065.git.mazziesaccount@gmail.com>
 <db5cb2e1543e03d5a9953faa3934d66f4621cd12.1744022065.git.mazziesaccount@gmail.com>
 <78d17b05-3f0d-4903-afe3-8051d4bd051d@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <78d17b05-3f0d-4903-afe3-8051d4bd051d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 16:34, David Lechner wrote:
> On 4/7/25 6:37 AM, Matti Vaittinen wrote:
>> According to Jonathan, variable reference voltages are very rare. It is
>> unlikely it is needed, and supporting it makes the code a bit more
>> complex.
>>
>> Simplify the driver and drop the variable vref support.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
> 
> ...
> 
>>   static int adc128_probe(struct spi_device *spi)
>>   {
>>   	const struct adc128_configuration *config;
>> @@ -183,17 +173,12 @@ static int adc128_probe(struct spi_device *spi)
>>   	indio_dev->channels = config->channels;
>>   	indio_dev->num_channels = config->num_channels;
>>   
>> -	adc->reg = devm_regulator_get(&spi->dev, config->refname);
>> -	if (IS_ERR(adc->reg))
>> -		return PTR_ERR(adc->reg);
>> +	adc->vref_mv = devm_regulator_get_enable_read_voltage(&spi->dev,
>> +							   config->refname);
>> +	if (adc->vref_mv < 0)
>> +		return adc->vref_mv;
>>   
>> -	ret = regulator_enable(adc->reg);
>> -	if (ret < 0)
>> -		return ret;
>> -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
>> -				       adc->reg);
>> -	if (ret)
>> -		return ret;
>> +	adc->vref_mv /= 1000;
> 
> In other drivers, we've been doing:
> 
> ret = devm_regulator_get_enable_read_voltage(...);
> if (ret < 0)
> 	return dev_err_probe(dev, ret, "failed to read '%s' voltage, ...);
> 
> adc->vref_mv = ret / 1000;
> 
> It can be easy to make a typo or forget to specify the voltage when creating
> a .dts, so I think the error message is helpful to catch that.

Good idea. Thanks.

> And we use ret to avoid having adc->vref_mv temporarily holding a
> value with the wrong units (and can make it have an unsigned type).

I'm not convinced about the benefits. The "temporary holding" is not 
really an issue as it is only held unmodified for the duration of the 
error check. Furthermore, converting the voltage unsigned does not add 
much as the regulator framework does any way return the voltage as integer.

Still, even if I am not convinced about the benefits, I don't really see 
any downsides in your suggestions either :)

>>   
>>   	if (config->num_other_regulators) {
>>   		ret = devm_regulator_bulk_get_enable(&spi->dev,
> 

Yours,
	-- Matti

