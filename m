Return-Path: <linux-iio+bounces-5472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C690B8D3FF1
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 23:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BF01C21712
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E21C8FC3;
	Wed, 29 May 2024 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ajLQpywN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F31C8FB1
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016398; cv=none; b=gxxQaxoZeiCbcc3gCIK9SmrrP8MBZUF4kN/p6bbXfzSqfv9vWIW43JI+v9KokrnlyYD5jFvTX1vOQbR5RASsB5BppNLRn7GjzPL+P4p0/9wGV2MGpxuFFl+kxQoIbo0l4kjW0By+QdmN9IkaBbFBwMTw+oKWxurspoDzdvpeBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016398; c=relaxed/simple;
	bh=0JIEoFJ3JrSuAxA+52iofxCdH9Ed8ss6mxR9tqmYJzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwkYQVUaHyrnWdZcEkpd2bwtfxvn8jk7U+wCf3Ug0hbSltcR5i2vuMZWhCnKrAvCy3kt6Uw81qb45FQm8cWyN9X+7cQez7hOy92i1+D8awkSqCLwLqX/EWIfB9FsbAbQZwELEdoD9K7xkGodDs3j1R/iIAChJtfVssfXm+cx+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ajLQpywN; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8f024a75cso138481a34.0
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717016396; x=1717621196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xcrwlkn4PrmA7KBIZPAmKm202+tU7DhEeT3No0NEPIQ=;
        b=ajLQpywNx4mBdSL/A2qg8MNLiT2shdinHllQOOjGtOJqmhnfgrfMO2ypF8Ux7HklyU
         9kVUyp5tSCYssmT2JWSl0GxXMfZT5T6c1jHFIM1ucyhydbbalnnA+/NWSOtN9bkK7pEu
         Qd7Z3dgVMbm2SURteI1Oxm7U03kGOB5hZxSqV1MAu0G+QFcvWyFVmCJ7ZzoRX9totJwu
         07AhoYSGV15yG7D+kHvdhOuF5vAXhvKjZtmw/lnv22qIUHWJSRbhpJ0LcP1GTnFzhVFs
         ZUaYb5FiNyErwL1buBbetavGZ1e0RywVxlJZJ8+6WHxFFOI1EUQL0Fs9tDq6ysg/kmDV
         8cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717016396; x=1717621196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xcrwlkn4PrmA7KBIZPAmKm202+tU7DhEeT3No0NEPIQ=;
        b=ufI6cGBfpF7g63kjqBy85MTp1dcMc9QrznRZn3f0jHGxa1AFnRmDRWAXEBrqyqymgE
         LqEsoU+3wCu7NjB/08V7Lr2k5IOraT0b0uSdYYwTnVidussR5ToiEkKOkxFlKkbTzdru
         YITbCFBzYDmaBrtHlP1O9adisKGu+V/DCF/eh/t4BFOCaUfZpZxRAYEx2mkvoAOPjIaT
         x+VqerOv9Z4vJIdbUYYbEsn6pZ2LVPLPtD6E4biwRUyTqSwNG5svVeaojKQ9rYRylEN0
         VwK9Sd5s8+Nm0HtbSUajmw6KXk9y1mKdukRTY/CSTk1+hrw1LQiszX8AlECHV3cAG1sY
         Cn9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbfG7r0et0C0NJ1/RLlbpoKD8rmj80scWMY+wwGvi229dyFcdqiBPEZPq18w/hGzLcMtP94BDTO4g9WgOTZf5mScvwnDsF06Dv
X-Gm-Message-State: AOJu0YxR67E/Zte1gYzwfxIEpUFcM68q8p4FHeUBhZgKUQ1lMl4f4Yo5
	mXFSubqccH63waxhXcin5B/iTzySReCEMGMbnPsuq4+GgbCsNOKpnLiVl1XFjOQ=
X-Google-Smtp-Source: AGHT+IFBe7dCkzsKuMo5AAfMZUrEPkQh+gWfbh9oGlUyCfIVM90LaPstgFxX6kYR1L/UseeB6AGkLg==
X-Received: by 2002:a05:6830:4490:b0:6f0:47a2:c1ab with SMTP id 46e09a7af769-6f90aeaf329mr354404a34.16.1717016395753;
        Wed, 29 May 2024 13:59:55 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d11ea076sm2413525a34.58.2024.05.29.13.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 13:59:55 -0700 (PDT)
Message-ID: <30192c2a-5275-41ac-bc20-aa5f436846a3@baylibre.com>
Date: Wed, 29 May 2024 15:59:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] iio: adc: ad7173: Add support for AD411x devices
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-5-7e9eddbbd3eb@analog.com>
 <6f18184de4a37993baedc15b44ecf0a6834a24d1.camel@gmail.com>
 <917bc1d9-fbdc-4ca2-a156-813b57c8201e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <917bc1d9-fbdc-4ca2-a156-813b57c8201e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/24 9:03 AM, Ceclan, Dumitru wrote:
> On 29/05/2024 15:46, Nuno Sá wrote:
>> On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> ...
> 
>>>  static const struct ad7173_device_info ad7173_device_info[] = {
>>> +	[ID_AD4111] = {
>>> +		.name = "ad4111",
>>> +		.id = AD7173_AD4111_AD4112_AD4114_ID,
>>> +		.num_voltage_inputs_with_divider = 8,
>>> +		.num_channels = 16,
>>> +		.num_configs = 8,
>>> +		.num_voltage_inputs = 8,
>>> +		.num_gpios = 2,
>>> +		.higher_gpio_bits = true,
>>> +		.has_temp = true,
>>> +		.has_vcom_input = true,
>>> +		.has_input_buf = true,
>>> +		.has_current_inputs = true,
>>> +		.has_int_ref = true,
>>> +		.clock = 2 * HZ_PER_MHZ,
>>> +		.sinc5_data_rates = ad7173_sinc5_data_rates,
>>> +		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>>> +	},
>>
>> At some point it would be nice to drop the ad7173_device_info array...
>>
> What are good alternatives to this?

Drivers like ad7091r8 have individual static struct ad7091r_init_info
instead of putting them all in an array. I like doing it that
way because it makes less code to read compared to having the
array.

It would let us get rid of enum ad7173_ids, have one level less
indent on each static const struct ad7173_device_info and 

{ .compatible = "adi,ad7172-2", .data = &ad7173_device_info },

would now fit on one line since we no longer need the array
index.


