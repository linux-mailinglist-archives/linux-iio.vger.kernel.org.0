Return-Path: <linux-iio+bounces-15990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E250A414D6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 06:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61163B28F3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC01B413D;
	Mon, 24 Feb 2025 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEN2nJLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE73C14;
	Mon, 24 Feb 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375610; cv=none; b=R6u8HuxVOw1aOVQrum6MzofIKVsOOeC4IbwWZQ/jwjO5Sdf6XRPBiVkswYSX1G7XsKK6jbXSDKBQDcqw0d430+VPlMZulVs5nAdBKZCTj9d7aiLosxyh1w5l0aQtoByBY3XUfaJZyuQEb5MYCjPMYMqiMQJdADTjrmF8WPUyrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375610; c=relaxed/simple;
	bh=ykTMvo5vM3ocHCW3+XjjML8AL9Bu7U93zqzCE7rZaq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufkSxPKRvIQ5K5lxyQ9vjsBlx+Td40mK03pP1KmWuEDJQDloke94eCpXvzfFqjCiCIf9y1oeogCtw/QxHXM4KggbFZOrhxEVLRIffdiZSZrKh2Po45r4b279Fmf0wELulvoHa8O/x+E7GcfofpbeTl7sbwdioemfXxlEGRVJr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEN2nJLJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30795988ebeso40671731fa.3;
        Sun, 23 Feb 2025 21:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740375607; x=1740980407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pki/JYWmmXNym2xztTz0HjhIt5MhQfFEcSVfA7kjWRY=;
        b=IEN2nJLJqbvyKHrUNiKaJuY7cgZ6tN8mepVWvgBc1gB8W85VCaC6ATafQLB4Dg7CU8
         YZu9AoAQ34u8zzMYlSf+wtmt9aDtmVh8V0NrgmEW7Fnqr69B3B5cVU0glicO6riupEnP
         TTQoGavTCmx++R/KEAC4wvwtwnj8OwdliP6nSreqHXtchk3vlhXExXBIe3mx3z3KAV+l
         /roRg33C2ZonAxI2PC29T7AnxsvPYvIsh/YGVzoXIojnBpIIQ5Z2WJ1k/pW1VzQK8saN
         FQLLfKVmfLgiiZF9G8IzznTPT0OLuDJPUAWgRMtHWSG9ENudp+KHz1ZjaHvI7r+KhATE
         owtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740375607; x=1740980407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pki/JYWmmXNym2xztTz0HjhIt5MhQfFEcSVfA7kjWRY=;
        b=W/6DVFviUQ2iF2OS0/FFp5tw+rQjzPfe4rFD2qoc+Wdqt5cRO7vdGwLNATItjp62S6
         EOg4TLcdsUEcQFlcvnsEGwRUeLTrCpMjwTgq6SI6Jh5e9nhGenCnZQ+0QfMMVKw1+Dt6
         I2OKdh2rEssSSB3eICm396nkmj0Ez/3geKPEdtsHb65+CDQRsAm+wVQcEpD4WSL7Dj6l
         zLqSlu1hkynub7H+ETpKeHFo7DsiLWgv01RPMbXYezksMF7BOBXBhFF7Jyw7kbD7rQrW
         rdCobowWilr8mHkyPqpckVCyUDfbN0ScZJqgxQ0GLuY0CEJoridTyrdRXBDZE1LW8SqE
         F8XA==
X-Forwarded-Encrypted: i=1; AJvYcCV5fjr4zmAc54paGy3r2uJYm/FVJem5kRlt8L4GYwSQn0s1VvGmVmKe9N7CbPhInzXw09Pbs/pROELa@vger.kernel.org, AJvYcCVVB24RMAJztiZjg63kwjiiSn2wo2q2dmd/g+IXv6bUnSmWY5ZWBJ2jBxcUmBpBGQu6HqUEpSNd4IDY@vger.kernel.org, AJvYcCVxgmMVWYQJQqGB0lh70ARK5OzOxVLjrGl/VPkXAUBh+oL5M2Wd9u62Ew+jQGVqRic6q9WqWDT0nUpzm7c001yfSdA=@vger.kernel.org, AJvYcCWXZh8E3vg+Eor+CdjrnpE0F1jkwO5sR74wioaja3x6WWq5APcEtak6FB7PEqapMnRG5+4472CXOMNa7Qik@vger.kernel.org
X-Gm-Message-State: AOJu0Yw159dO7vs26yyqRp41MrykqF8p/sgzP2cKgZ8ORp5fVtSiGUVD
	M5pUGAbmfjffKchkGD+RGq3LsGgcpRmxNYBXkoxBmphEGNnQsjBi
X-Gm-Gg: ASbGnctkk3m3MJJRlNs7P4jS+Z5G8OSCmWT3W8/jGAUNlAlrMMT9hG/1xeneuLROPd8
	dXfPcHh2XpBJTw0LCzc7XVmDkE2FCE69hqivY9woWRKOOAWdXKQJPmVM4pLkDuUAHftEtllwpa8
	zGus1EPXKF+dYYJL78cRZlwQBbEKUOeTeFjEh6EwxHTcW8qW8mYmqGY71feRDPffJDh5D4YGQ5m
	lALTAKP3za+H5PGCmUbv39yidt0pWg0fuH5Z9gkRyL7DPdfIV/ixluZyoy593ER54jaGaHua1Ha
	mcOT2zuBsqNj7NbsJI5CGr91ONc0ubfj1yq5nq6Cs8J4asuyvwn2S4FnegkPn2VhmnsONmUVJu+
	jlA+atQE=
X-Google-Smtp-Source: AGHT+IFYZsWHIGkUkgzUKAjiHsIv/QlXdd4k8rwaFgyu16UEoKiHj3ay571mZ+VYAfS3uE3xpBBTaw==
X-Received: by 2002:a2e:8ed6:0:b0:309:2012:cc59 with SMTP id 38308e7fff4ca-30a599a6943mr41956421fa.26.1740375606698;
        Sun, 23 Feb 2025 21:40:06 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30917da0e64sm34665291fa.88.2025.02.23.21.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 21:40:04 -0800 (PST)
Message-ID: <24609799-636d-4e8f-8406-f83b5db08f90@gmail.com>
Date: Mon, 24 Feb 2025 07:40:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] iio: adc: rzg2l_adc: Use adc-helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>
 <20250223163018.2c0290e8@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250223163018.2c0290e8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2025 18:30, Jonathan Cameron wrote:
> On Wed, 19 Feb 2025 14:31:38 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
>> drivers avoid open-coding the for_each_node -loop for getting the
>> channel IDs. The helper provides standard way to detect the ADC channel
>> nodes (by the node name), and a standard way to convert the "reg",
>> "diff-channels", "single-channel" and the "common-mode-channel" to
>> channel identification numbers used in the struct iio_chan_spec.
>> Furthermore, the helper checks the ID is in range of 0 ... num-channels.
>>
>> The original driver treated all found child nodes as channel nodes. The
>> new helper requires channel nodes to be named channel[@N]. This should
>> help avoid problems with devices which may contain also other but ADC
>> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
>> string didn't reveal any in-tree .dts with channel nodes named
>> othervice. Also, same grep shows all the .dts seem to have channel IDs
>> between 0..num of channels.
>>
>> Use the new helper.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> I should have read on.  Definitely more convincing with these usecases.
> however drag them to start of series.  Better to add infrastructure
> so some use and then on to your new driver.

Ok. I'll reorder the series.

I'll drop the differential channels support in v4 - and thus also the 
expected property types parameters - which will simplify this and other 
callers.

Thanks for taking a look at this!

Yours,
	-- Matti

