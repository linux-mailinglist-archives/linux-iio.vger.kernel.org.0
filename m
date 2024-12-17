Return-Path: <linux-iio+bounces-13588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0FD9F4F94
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD9D17A3801
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3C1F75A2;
	Tue, 17 Dec 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPU2Y2U/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03BD1F7082
	for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449765; cv=none; b=tnvGTiRQlYD70qgDU/gQFyOocnbY1K+Sj/jmPYgHlIdHnbgcrqUXAJLDkoyz4rlLQc+4ASDi/lcX8G0ocfV2CXfP4QBB4sDNXul5KJGJxiaBXws8e2V1oY1zT3Jqu6ZQgo14154fmOrPsn+qUjTxSt0OPjE8iihqXIzNDf9j6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449765; c=relaxed/simple;
	bh=Cfm9tPZMQuiDcp8WcnIHSSo2kAMsYiiKt/FMI+6TXQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+o+u8F/V2wmeRfmr6QMbhFCF4e1J4dMHgVKHWtizn9S379sVm0McMsgthrLFXfRYv0VOWuEYSaBGaK0nz0JAUUiuGSGLP1IZP45rMk58r4n2XR2RZdXOv8wW/Js3ccOrSZSxnOsMof6ycgRcdrMoUHPiqeWkb6wrq3M6MP3aV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PPU2Y2U/; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e36b27b53so2647315a34.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734449762; x=1735054562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hSccYkNiVo5Ab7I2cIln/5c0RMqcFycYPtpUe98zEE=;
        b=PPU2Y2U/EkWg1+Xnuj8cdx/1XPrW0dZj2TY/BZkpz6jLspAj0RZNLro9vBsQoRNruC
         TZwS7vEkbkBwuKE70CwgJjgxkbioEvygkQFIqWNqfZD+i85ZBxNsIXLL7KNYEn/GAD+U
         48dMvgvloDXw9/6/vu5ut6qZL+Mc+wXoZ3k4L2EDtHMO7q0nGjEOs+9hpuVrdW2XLKwo
         zAbnh6DzZBzdSBIcFbpvuG78w46eAEsnUtTZirEk/rfMC+/pVtLOj60bDvVBqHo94uH5
         Gh0r28fEqCDHRNeOoBJFMf3Y5obqFllTUAOGAh8WFblEamhDf4OE4ryr5004gT3mgePZ
         j+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449762; x=1735054562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hSccYkNiVo5Ab7I2cIln/5c0RMqcFycYPtpUe98zEE=;
        b=VE2OXY7vxLzqMdW6fJhfPBDlsjblrMln9uGhPy3XrREF7ZpvjPCsn1gusGK8Dbv9+0
         NIE7BMdz0axksYpNbstIvARr/ulnVYL8+g9BJZEAVNmkq0K9HK5k53pNowWogTjx6i6v
         Vg13Xuja1cw9kvy/4GWjXOfwHNYT0bFEqgeVitfrU9rOGjr2MK6A/haoS8Gw+oT/776c
         282r19gz/XNdmWuQZIYS6lngc5ZPzx68NM18MAifY9QCUiEjdxIny0Ko6RbuXD+3d755
         u7lCFGkItNuvBThEwE1Zn1ZMWDQGKdLx594DcGIGrsAT3BQURAAbxEVT7aACHLRqVn07
         DPlw==
X-Forwarded-Encrypted: i=1; AJvYcCVrwwVtLYm9dOqPutaztDKvp/osEbeRB68K4PH0B+xA0UnyQoxEljhM1aS+GCZJ/NEvES1hGr7g78I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywus6w4wbzpRUl37PffgRQn9ZjPEtIP7P79ZgtZwrjyYN6aPuVH
	QNNDlEmbAEXtwa88JliYgwXCj9VD0HX14/q0DrU7k8gYW9ZpRG8jrommgszCYHc=
X-Gm-Gg: ASbGncuiXX6xdkk2rscEWCxfuXyNb1kQj3+85Muu/wurWl2DuPRDL0ekMDa7uHVSWUk
	E2edVO5h7g/73GWBKBXFMMUZSi7W5MNnTV4bbaVrRxBw/DMVa24cKm93bppS90nb/LpX3IOMO1q
	fO0LD6ah2D5sj3G27NFvLm+3SDFO3eLkDUu3133j0ieUbGotqmSTZ0tYEjltXTXlOqM+NPp7LnK
	ZNNtZW/yFUhGUHTLfWs4TLKNon+OS8bp+hYHqq1UVEJEGcBlgnInVHAatnIz5g9pGkOIWU8Sc7H
	WyIWgnnKKcS9psXxMg==
X-Google-Smtp-Source: AGHT+IH/2b6LqFTsioT5QNM6/l8WG+PKjU9zlTFidwxxoump2J5Z1nfbAzJbXJkDBI/fgk1AuuDE9Q==
X-Received: by 2002:a05:6830:3890:b0:71d:50f0:afc5 with SMTP id 46e09a7af769-71e3ba3afbfmr11522547a34.21.1734449761967;
        Tue, 17 Dec 2024 07:36:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48307815sm2069053a34.9.2024.12.17.07.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:36:01 -0800 (PST)
Message-ID: <8dc22c7a-f1d2-483e-8b69-cb5dc494feae@baylibre.com>
Date: Tue, 17 Dec 2024 09:35:59 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/17] spi: offload: add support for hardware triggers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
 <20241211-dlech-mainline-spi-engine-offload-2-v6-2-88ee574d5d03@baylibre.com>
 <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/24 5:30 AM, Nuno Sá wrote:
> On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
>> Extend SPI offloading to support hardware triggers.
>>

...

>> +static struct spi_offload_trigger
>> +*spi_offload_trigger_get(enum spi_offload_trigger_type type,
>> +			 struct fwnode_reference_args *args)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	bool match = false;
>> +	int ret;
>> +
>> +	guard(mutex)(&spi_offload_triggers_lock);
>> +
>> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
>> +		if (trigger->fwnode != args->fwnode)
>> +			continue;
>> +
>> +		match = trigger->ops->match(trigger, type, args->args, args-
>>> nargs);
>> +		if (match)
>> +			break;
>> +	}
>> +
>> +	if (!match)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	guard(mutex)(&trigger->lock);
>> +
>> +	if (!trigger->ops)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (trigger->ops->request) {
>> +		ret = trigger->ops->request(trigger, type, args->args, args-
>>> nargs);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +	}
>> +
>> +	kref_get(&trigger->ref);
> 
> maybe try_module_get() would also make sense...

Even if a module had more than one trigger? Or do you mean
in addition to the kref_get()?

> 
>> +
>> +	return trigger;
>> +}
>> +
>> +/**
>> + * devm_spi_offload_trigger_get() - Get an offload trigger instance
>> + * @dev: Device for devm purposes.
>> + * @offload: Offload instance connected to a trigger.
>> + * @type: Trigger type to get.
>> + *
>> + * Return: Offload trigger instance or error on failure.
>> + */
>> +struct spi_offload_trigger
>> +*devm_spi_offload_trigger_get(struct device *dev,
>> +			      struct spi_offload *offload,
>> +			      enum spi_offload_trigger_type type)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	struct fwnode_reference_args args;
>> +	int ret;
>> +
>> +	ret = fwnode_property_get_reference_args(dev_fwnode(offload-
>>> provider_dev),
>> +						 "trigger-sources",
>> +						 "#trigger-source-cells", 0,
>> 0,
>> +						 &args);
> 
> I guess at some point we can add these to fwlinks?
> 

Yes. Although we'll need to investigate how it would affect
leds since they use the same binding. So perhaps we can save
that for later since the rest of this series seems ready now.


