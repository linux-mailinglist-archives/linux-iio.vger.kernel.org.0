Return-Path: <linux-iio+bounces-18069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE39A877B8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 08:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAA316B54F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 06:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609A1A23A9;
	Mon, 14 Apr 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxVrLTrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92561FFE;
	Mon, 14 Apr 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610593; cv=none; b=VhcVLvKMUNthFOB72ZrsY6O8ufeOWi5w3MzSyrvFElv4OiEHBUNukckIph8Vu5Y8pEd6ZZqkYvUTDP5dYTR16VhwZMs7II5Wgd72IMTlADD/vMwOeSXlws9gLM9iD/5CxNLwTfuqQb2USCYPbG/KfEBQCwkMBORpwNHN32fc6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610593; c=relaxed/simple;
	bh=SsdIA1O3YXTMlpfoM2IIKBOt8pSw+qADOiX5He6NMNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq/sof45NKjRnuwah4R06THQ5scEm6j9crcEOCW25e658+8XpX5g2PBCBB3cDoK6RX5cPH1QijRVnflZ2wRFf85tbH+uTaE+H8+pQBB1Wp+X+qfNhJm6WG0rPGyUPWif3RzkF1rdg7HkxCnwfDsny9gkuUmPdWUxuF7GFXx0Vp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxVrLTrf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54298ec925bso1993174e87.3;
        Sun, 13 Apr 2025 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610590; x=1745215390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aTJ1oYIPlmKXpxMnt+hiXbL+Sq+ey35ei32jeHen5c=;
        b=CxVrLTrfr3/1tC1iqudXEZ+ooSVi5XH5U/I51LPT5jNz6ZlCnGIFf8afxzvwdzZlM7
         1NCGZYtQ31duOga2nPfCbMSTOmhu42fGhVHV1GjHdKsS8Kokwk9v3+yaNxN96EgAeYdz
         vSxJKZIK4L9+QRMyttoYC86HPyXgJ9OHob18L1Iv5aC/BUHsiNdzIw5+0hDcGOHE9aiM
         KFqPyrjB3W2PUv6a3aj/Qa2g2dx7iCdp06VpLSyA0SQJr5wwUOz6KhaGOUk9jkzghmOs
         ym4lmoGRni4VT6K7QP6oCQwLMfJbsj8veuhed3MbVpTMiPoULi1WzzmdpC/NTTBDlI7N
         JEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610590; x=1745215390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aTJ1oYIPlmKXpxMnt+hiXbL+Sq+ey35ei32jeHen5c=;
        b=DPkwJC/A5SoNzfv0O6pwXSUvbBmgNbOz1ohSYTAf1ZYX8ctEyA0Bd6ZyaaNeruWBhQ
         SQafOdYTk6r1t9A5Lf1ufT7c4ntgIqo2TBGKdL7poOLEzoj4H4zKE7Hk/LLUcfEMe/db
         /2/Z7I+Bu6XupZxscg6zt7ELG9ZLiW4ChGkKG6dVQV9T5KQ52nY14fBccPf6AdA5OwLu
         t57y0/UCTMVbC/2mIIx69B4AthJoBjevufOtklz4h8i+JP7Z5+9cjTiqx78mIESrPDsv
         B40jAdgCFCMH/JAfW7xBQJrBG4+0geuJpIkB5bfFTYER8iKTRIIOcweGeQcu5XHDofO4
         /hww==
X-Forwarded-Encrypted: i=1; AJvYcCUd8MZr4WeDuITpRmh68MUF4upQ1cqg48PwxPI2jCAKXcZfciMYeZ/XE8+eysaUz85MIoiG6sALdGyq0//f@vger.kernel.org, AJvYcCW9oUk8MnLhagj5kozCzL5PhcSDadgMOgPwza4RUBMn3RRzxo5zWI0p4LdqWZRxh8WOzwiiPh10SUyR@vger.kernel.org, AJvYcCXPnnKmcCINMMkywBCLT+3lPJ1uGT4VkozdHbAOrVafnk3tWn1AnWLvZH6wGNaatVLR2dFzcagl2gsN@vger.kernel.org
X-Gm-Message-State: AOJu0YzeX4ZnZSrgtPUK9cYVxsvfQD1ZtL2V3+RCFmjDAs/yhEqH9oD6
	/X0ny/aiGD9qoOGJfAFba6e9OMXD5FetbTCmwDCZPnWxQo1/iYJg
X-Gm-Gg: ASbGnctlUq3rIhZasGMpDumcnylLuhF4pi0lPNOT9+X75mZYkTQ9QGskjKpBquNxje3
	3sbcK34B1f9i5GteXWbzRdaVfxRlxXkcM5+mVtYGBoTiZjY6/5E6P8YoH8CPiS0lsf49O1qhNrQ
	N5ssrb/jxLaqoC6ibUzEZTlBbVvw1CmU7rEyu3RCoE2kiMrN6IcBdl/J6uUr8A6IoFA5y3tz7EK
	kalSvFrb6v6pOduwodY5CoIXRhd+WRGc4ayAuKq2G3q0HXSBW017NF6j914YKdPxRn5fXTc47cs
	zmaR0EYtDPx4JFrjxIiUeaugMMdm0H+FF1pJUbuXijKehBYRzD7a8wPem0LLo+Azp9L/er7q8tv
	8Vwt4t7FFyu9KfBeJ0iHXew==
X-Google-Smtp-Source: AGHT+IFV3+sNUrGZb1po81SQG/UoADNzVfrzlewpcX8YGkkmRN6h0BMt/8EGFpFBcmXaTpjXVA4GUA==
X-Received: by 2002:a05:6512:b18:b0:54b:117c:a070 with SMTP id 2adb3069b0e04-54d452e835bmr3367487e87.57.1744610589460;
        Sun, 13 Apr 2025 23:03:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d238d1dsm1013848e87.69.2025.04.13.23.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 23:03:07 -0700 (PDT)
Message-ID: <f705fa4e-331b-46a1-9640-d33e83f7a894@gmail.com>
Date: Mon, 14 Apr 2025 09:03:06 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 8/8] iio: ti-adc128s052: Drop variable vref
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1744022065.git.mazziesaccount@gmail.com>
 <db5cb2e1543e03d5a9953faa3934d66f4621cd12.1744022065.git.mazziesaccount@gmail.com>
 <78d17b05-3f0d-4903-afe3-8051d4bd051d@baylibre.com>
 <20250412124229.7917e2df@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250412124229.7917e2df@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2025 14:42, Jonathan Cameron wrote:
> On Fri, 11 Apr 2025 08:34:42 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 4/7/25 6:37 AM, Matti Vaittinen wrote:
>>> According to Jonathan, variable reference voltages are very rare. It is
>>> unlikely it is needed, and supporting it makes the code a bit more
>>> complex.
>>>
>>> Simplify the driver and drop the variable vref support.
>>>
>>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> ---
>>
>> ...
>>
>>>   static int adc128_probe(struct spi_device *spi)
>>>   {
>>>   	const struct adc128_configuration *config;
>>> @@ -183,17 +173,12 @@ static int adc128_probe(struct spi_device *spi)
>>>   	indio_dev->channels = config->channels;
>>>   	indio_dev->num_channels = config->num_channels;
>>>   
>>> -	adc->reg = devm_regulator_get(&spi->dev, config->refname);
>>> -	if (IS_ERR(adc->reg))
>>> -		return PTR_ERR(adc->reg);
>>> +	adc->vref_mv = devm_regulator_get_enable_read_voltage(&spi->dev,
>>> +							   config->refname);
>>> +	if (adc->vref_mv < 0)
>>> +		return adc->vref_mv;
>>>   
>>> -	ret = regulator_enable(adc->reg);
>>> -	if (ret < 0)
>>> -		return ret;
>>> -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
>>> -				       adc->reg);
>>> -	if (ret)
>>> -		return ret;
>>> +	adc->vref_mv /= 1000;
>>
>> In other drivers, we've been doing:
>>
>> ret = devm_regulator_get_enable_read_voltage(...);
>> if (ret < 0)
>> 	return dev_err_probe(dev, ret, "failed to read '%s' voltage, ...);
>>
>> adc->vref_mv = ret / 1000;
>>
>> It can be easy to make a typo or forget to specify the voltage when creating
>> a .dts, so I think the error message is helpful to catch that.
>>
>> And we use ret to avoid having adc->vref_mv temporarily holding a
>> value with the wrong units (and can make it have an unsigned type).
> 
> Good idea.
> Applied patches 1-7. I did tweak this one as well but then couldn't make
> up my mind on whether to change the type of vref_mv so I'll avoid making
> a decision and will leave patch 8 for a v4 from Matti :)

Thanks for handling the 1-7 :) I'll re-spin this, but it's likely to 
take some time. I'm having 2 weeks off from work, and my motorbike and 
boat is requiring some attention ;)

I hope I have regained a lot of energy after 2 weeks ;)

> 
> Jonathan
> 
> 
> 
>>
>>>   
>>>   	if (config->num_other_regulators) {
>>>   		ret = devm_regulator_bulk_get_enable(&spi->dev,
>>
> 


Yours,
	-- Matti

