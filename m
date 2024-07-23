Return-Path: <linux-iio+bounces-7824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67293A2C4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EAB283F71
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D6154BEC;
	Tue, 23 Jul 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="puhPB9tB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815014BF86
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745026; cv=none; b=Stk4oc+aqK9fOhNMurgxemOlAzKo2hw1AYoz0E5/3VApVWlYe65JGcd4wehXAPuKnOPHSdHmkgezsG6wFi++KwW/6j8O2N/bG4DCNboHuLC0NU2cM0m3bjIgwZGK0BPAa0xdv0Q7kImCXfCPfLAD6FaVQgXwEVvFPwfQwCYZFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745026; c=relaxed/simple;
	bh=svfSj6Nk6n0zhQYH7Wy4+W5jUzAOV7rXJ1iNGfkem4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVaZ3lgh9VlzC2D7nzLl2s1t0PB6il141xK/4kVPWu02bnluEYuyL6fuQagkDpiBuoXWZpsh1ckZSP9e0EOhXyiMRQMVIia4HJf77M9nZv1mk3gEfIRdlxPzWpt1ao3LvTkoap4o+ZLhqlJt8/l7ZDBKQTTLms8WngvwYQVE1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=puhPB9tB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-704494efa7cso2834658a34.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721745023; x=1722349823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZV45Yy1++QW4e1YcdMMQnnRx3UERVeaO/mbbi5Yem4=;
        b=puhPB9tB6NkkOSTTdrYtDrxxNRywYX/q4g25fxa4Gahbcsw9YGKK8rMTet9ISm3ii8
         EPiwngEr1nRDYydvP2XbuRZW48HsIIUXx2U1vlQxCUkT+XsOi+nHv+5vRp2NBerTJkxY
         Fv0saQAPgxT8AVuWx+senPz3XKBigHmjuQhBupS0E8L7CCHRl++i6f+GZ0RnJ6gAgZxA
         EwkqpKGBG90UHZOVhOA5/5puytYS2YSflXL5pmEzgVnsK5pHXxYB2ClEhoXtDA1dKVH5
         4MEey+RB74VjddTOMexU0LVRuBqH3T14Gv9f8Rgb7m7/EajJdnOfDrOUomJtMt+E0qVM
         g8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745023; x=1722349823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZV45Yy1++QW4e1YcdMMQnnRx3UERVeaO/mbbi5Yem4=;
        b=O/nB6OZML5lINJZRwUttG0crgJSVrkHwxRUhxME/yLoUmNue11NLARKiLaE/MeiQ3o
         AOgR+LLzcJon+W5ufuMMwPNY8C6sLGiixtMyksmMJD/Q5sibmo18OcLQYcPgmtSyTB2h
         O4B6aAjX5VfjRGFamcNIzkQUOJqngC1MjATpnQUI6+/ZK+78gWtFeJASknRw9kJA+Jzu
         gt0WIVHGHYeTfB9+4gSx36P/FpD6zpBJWXnaHl/vtH+E9vZ4FbHkg0AksyhgHtFmfkSE
         j1n4RyuuEcgjBTg6u25DQX/9ZvqOnI5nDWpIVKbzhUSrrJxktuPf2YHbXXFDwAnY3baQ
         X5/w==
X-Forwarded-Encrypted: i=1; AJvYcCVJyRDfGEQmqKu96krvsQvVOI+iFVNWwxzh0bsIUobYjsII+wKa7bJbWSXalREBLSJAbzyPSf5VB9+XgRrRdwKmQNolezBbuBp7
X-Gm-Message-State: AOJu0YxEf7WZWdDiSCgoXOW+h9R2nTT2yRQqy65yUsFmDLbHaCAZQtiR
	WtNDuWHZUXM787gyxjAqqkWwq25GMb6ng+gBjHhI332Y8gJH/mjuF5hmmzIkUfA=
X-Google-Smtp-Source: AGHT+IHXJQexka10Cik2TwqAKaBqbdxs50cysaj9WK3NDXWHJ5wxuH0Yzam3MlSFSCE9fFrCbzaBUg==
X-Received: by 2002:a05:6830:6182:b0:703:6ab8:1fd9 with SMTP id 46e09a7af769-7092342f5famr9474a34.1.1721745022753;
        Tue, 23 Jul 2024 07:30:22 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60d5bc6sm2028863a34.35.2024.07.23.07.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 07:30:22 -0700 (PDT)
Message-ID: <a0313f7a-39b0-4156-87f7-816e8666dea8@baylibre.com>
Date: Tue, 23 Jul 2024 09:30:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/9] spi: add support for hardware triggered
 offload
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-3-7420e45df69b@baylibre.com>
 <34ff08ef8b550ff2979dc50204fad500b9bb41e3.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <34ff08ef8b550ff2979dc50204fad500b9bb41e3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/24 2:53 AM, Nuno Sá wrote:
> On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
>> This extends the SPI framework to support hardware triggered offloading.
>> This allows an arbitrary hardware trigger to be used to start a SPI
>> transfer that was previously set up with spi_offload_prepare().
>>
>> Since the hardware trigger can happen at any time, this means the SPI
>> bus must be reserved for exclusive use as long as the hardware trigger
>> is enabled. Since a hardware trigger could be enabled indefinitely,
>> we can't use the existing spi_bus_lock() and spi_bus_unlock() functions,
>> otherwise this could cause deadlocks. So we introduce a new flag so that
>> any attempt to lock or use the bus will fail with -EBUSY as long as the
>> hardware trigger is enabled.
>>
>> Peripheral drivers may need to control the trigger source as well. For
>> this, we introduce a new spi_offload_hw_trigger_get_clk() function that
>> can be used to get a clock trigger source. This is intended for used
>> by ADC drivers that will use the clock to control the sample rate.
>> Additional functions to get other types of trigger sources could be
>> added in the future.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> TODO: Currently, spi_bus_lock() always returns 0, so none of the callers
>> check the return value. All callers will need to be updated first before
>> this can be merged.
>>
>> v3 changes:
>> * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
>> * added spi_offload_hw_trigger_get_clk() function
>> * fixed missing EXPORT_SYMBOL_GPL
>>
>> v2 changes:
>>
>> This is split out from "spi: add core support for controllers with
>> offload capabilities".
>>
>> Mark suggested that the standard SPI APIs should be aware that the
>> hardware trigger is enabled. So I've added some locking for this. Nuno
>> suggested that this might be overly strict though, and that we should
>> let each individual controller driver decide what to do. For our use
>> case though, I think we generally are going to have a single peripheral
>> on the SPI bus, so this seems like a reasonable starting place anyway.
>> ---
> 
> How explicitly do we want to be about returning errors? It seems that if the
> trigger is enabled we can't anything else on the controller/offload_engine so we
> could very well just hold the controller lock when enabling the trigger and 
> release it when disabling it. Pretty much the same behavior as spi_bus_lock()...

The problem I see with using spi_bus_lock() in it's current form is that
SPI offload triggers could be enabled indefinitely. So any other devices
on the bus that tried to use the bus and take the lock would essentially
deadlock waiting for the offload user to release the lock. This is why
I added the -BUSY return, to avoid this deadlock.

> 
> ...
> 
>>
>> +
>> +/**
>> + * spi_offload_hw_trigger_get_clk - Get the clock for the offload trigger
>> + * @spi: SPI device
>> + * @id: Function ID if SPI device uses more than one offload or NULL.
>> + *
>> + * The caller is responsible for calling clk_put() on the returned clock.
>> + *
>> + * Return: The clock for the offload trigger, or negative error code
>> + */
>> +static inline
>> +struct clk *spi_offload_hw_trigger_get_clk(struct spi_device *spi, const char
>> *id)
>> +{
>> +	struct spi_controller *ctlr = spi->controller;
>> +
>> +	if (!ctlr->offload_ops || !ctlr->offload_ops->hw_trigger_get_clk)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	return ctlr->offload_ops->hw_trigger_get_clk(spi, id);
>> +}
>>
> 
> It would be nice if we could have some kind of spi abstraction...

After reading your other replies, I think I understand what you mean here.

Are you thinking some kind of `struct spi_offload_trigger` that could be
any kind of trigger (clk, gpio, etc.)?


