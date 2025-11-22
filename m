Return-Path: <linux-iio+bounces-26377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5FC7BF98
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 01:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF2DB3602D7
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336A4C79;
	Sat, 22 Nov 2025 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SOuvgd0d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162718E20
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769747; cv=none; b=MWfs+yZz7RRYjclIEwzWSNWiR4T9JU9MkO+FlZQ3UER8hlTQfuIZDhYEBJUHDV0ShYNbTdG3pnhGrdD9apaTT+0Gyo1e/1gmIXTkmwVEHGd8u8sHF3fCOVH5kYU8s6dql4pQ+Vt47/Q1q0TL/La3/ojPzUGx0Vx2S876IjOJrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769747; c=relaxed/simple;
	bh=5vU7V0qkV7PYCF8w381451NvEsq2oDT+U7h9SYJ20ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI9KEFv9sCWV05c9okdt+M0jWYXSVje776il/yx8F1vVM5w9wx0VR4OC+Eu+cSRq0+cN6O4fUTq5OwQt25LcCZGFVL/BOT2WaOrnwHB41rUR1nA748qPXt7WbmgrUm+wRLdvs3SB/B1xrkkdOQPjoDu3u1Ph8POTRfwSyt6YXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SOuvgd0d; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c765f41346so996214a34.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 16:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763769744; x=1764374544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSMsM4wD+eNEn0K9vsPH/4otzNTJFdNd3NAiviSltNg=;
        b=SOuvgd0dvXqw/cOlwn56g0plfbXTJ9V0yfXitwPAcmM7aZ+FKE4Qpqc1A84oxAuiq4
         UkJeXXpxoS85CbP6FQ0x3FBEj9imu8MdqayuTEVpDZ9k1iXMqZbUP2ImtrGVY0mkzE5z
         fQn3aUglG9FZoKBd+PEaehgbA/GSxkDi/ops18poREc3d9gT0JwMchMlNeikSe04Uvc4
         kthcH/ETCv+nkfPPkjjEnDWeyvUAoR21M1ytGYHzMiHYH9dCfPt3tPU1QLG5cer/5xx/
         L1fwwiz8VpieulgNVrfU+Upm5yotoqMfeZaTy1Cz+ZYu+O75+PAEPe/jrNnelCHfbkUW
         S6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763769744; x=1764374544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSMsM4wD+eNEn0K9vsPH/4otzNTJFdNd3NAiviSltNg=;
        b=rRojPWNNKC2bTeTCH6/BdLcMYeeMOYnbhp+OA/goVhZFAcRW/jmSSEwUL35b/QRu29
         d+eOPLoDro/26CglBK0YmWK+6faw027Cx4+zMPvl7VBMtgYyZ4jlq9bzwiIk+FY2YjjW
         K6xG0vrNWedR4mMpSmf0LwyYKUJEEtipyLJpN+OEH2W7CtLH04HWe+RaF7Hra8fED5Gd
         NU6pPplU+ARbFyd8UHoU71l48lmQ+/uV/V3/pOKGjC/koxof5h74iBiktAhdVOZTrrp4
         sSQWI9jkgsN+6tkosrO0NPcvrYxttYBWyoqi9GbEyf8fehjhzuU1oP3IvyOF3Xu7TdGB
         NZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvyLzUI1IZjzcFJyB41v6fG9YGnU9ccR5TdPro1FVC6xOMGr4joULvbM7u0u5L19fEW6GkkjpPTLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrAqA/LnXT3XUCZmOgZsReO8SBuG0C588kWvbij5GhDA10gOZ
	3jvKusNOZjSVgB1ul8rvoANpviMz8+XIQGUHTQ0PziaHoVEKBGq+s4F39Qo8renV7M4=
X-Gm-Gg: ASbGnctf/DSkRXpTyjuysil6ObE26S7HzLV+zGnRBsZDFXwTCQVzyjE9W9ADF/+ps9Q
	qGt7P0Lg3Dh33rlI0GfPBU4vvjMDuf8HnMZmx2yp5Vw0aULI+5DxlrH4+kqlGjQBwMn92kX/nqM
	IsEWmf83LcEAC+nUCMmTdhPhdO/Z4dhasnI8mOxb1n1JnvMeKDga7LMNEu0w70IE2cflCQiJbRF
	VKrWxaQDvwZXLNHlBDZ8UJjGQFcjwxMadxrxYtJAdw+pR5vD5M/wijeBFcAPyFO7yUEsJgFggCW
	/E3RqKbrQJ+8eOcDLG9HXyspm4ExIF+U8VIeekGmPiBeF4ccg7qDVdP5f3Bnh4D+56jdGgYSNbR
	iDaZo8QyTQY3+5+RjrdiE5M5Bzvq4UpBLv4kCb25BvNV0jCq/uzg63xm49zIacpHx5To83R56An
	agPBsqJA7CAiQH2L4cotYvykT7ag3/168wth0ke1SGBfZ6sIOdfmybtVkFvOpKlYNUt8QTP/U=
X-Google-Smtp-Source: AGHT+IETDNA4U9kpXHXNcD4yt6ZyVzUxTAn4REi1Ka9mpoOr0PorXQOzuvjp9nALLHrKdDLmJjWXEQ==
X-Received: by 2002:a05:6830:2707:b0:7c7:63b6:89d3 with SMTP id 46e09a7af769-7c798c4e5cdmr2058906a34.19.1763769744080;
        Fri, 21 Nov 2025 16:02:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d3e2e59sm2854198a34.17.2025.11.21.16.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 16:02:23 -0800 (PST)
Message-ID: <986c47b4-6093-4e6d-aa4b-8d789e497dbc@baylibre.com>
Date: Fri, 21 Nov 2025 18:02:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: Add support for TI ADS1X18 ADCs
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <05fae891-a4e6-439d-97da-6259370f68b5@baylibre.com>
 <DEERGRDZ0TM4.NZ6R9JWCSQPL@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DEERGRDZ0TM4.NZ6R9JWCSQPL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 5:28 PM, Kurt Borja wrote:
> Hi David,
> 
> On Fri Nov 21, 2025 at 5:32 PM -05, David Lechner wrote:
>> On 11/21/25 11:16 AM, Kurt Borja wrote:
>>> Hi,
>>>
>>> This series adds a new driver for TI ADS1X18 SPI devices.
>>>
>>> This is my first time contributing to the IIO subsystem and making
>>> dt-bindings documentation, so (don't) go easy on me :p.
>>
>> I actually had these parts on my radar, so happy to help you out.
>> Unfortunately, I don't have the hardware for testing though.
>>
>> The first thing I was going to do was check the existing drivers
>> to make sure that there isn't one already that has a compatible
>> register layout. I have a feeling we won't find one, but would be
>> good to mention that in the cover to justify adding a new driver.
> 
> The closest driver I could find was the ti-ads1015 I2C driver. It has
> the same register map and similar specs. Although I think we can adapt
> it to be "compatible", I chose to do a different driver for a few
> reasons:
> 
>   - ads1015 and compatible devices have a separate DRDY interrupt line.
> 
>   - The ti-ads1015 driver doesn't support the DRDY interrupt (sleeps
>     until data is ready and it doesn't have an iio_trigger).

I don't think this one is a big deal. Ideally, eventually both drivers
would support operating both with and without interrupts.

> 
>   - To correctly handle the DOUT/DRDY line we need to manually control
>     the spi_bus_lock. And we do it differently based on which IIO device
>     mode we are operating on, so it would be difficult to stuff this
>     logic into regmap_bus callbacks alone.
> 
>   - IMO the end result of merging these drivers would be too messy.

This one I agree with 100%, but for different reasons. ads1015 is I2C
and ads1018 is SPI _and_ regmap is not a good fit for either of these.
Mostly because when reading sample data, we need a custom SPI message
to read the data and write the setup for the next conversion at the
same time. And ads1018 only has 1 register anyway that isn't 100%
identical to the same register in ads1015.

> 
> This is just my opinion though, so let me know what you think. If do
> agree I will add some of this points in the patch changelog!
> 
In the end, we both have the same conclusion.

