Return-Path: <linux-iio+bounces-23687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10362B4241B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A069A482CC6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55930E829;
	Wed,  3 Sep 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElGRsFvJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C730ACFD
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911242; cv=none; b=ouV5y17slz73mqLGltv27d38p86sOujxgb8xnu1wWC2EpGZv41hAA1pakrqFNEpAxKuXZmeuBc/8gR7NBzYPQx85g8gHUA73k+o9Wue6JpdJqPMuDN9whcN2o1kTw62Gx1xfyN0P+5mbHqzs//enGJQsuukwGcnJBR3FH9bw+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911242; c=relaxed/simple;
	bh=unDqZyH1QB0AZnE+jIy/cbveVXnikGD65lmG99tqIe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QG7En+ipq3CPpGBRM4vC36QEZXvFHEAiozrThWZOShFgTfDhhriybzfJVTzXQGtlKnPhEzg6pqmIQf2kj2aPvDf+RLCECCilgFJQllnajs6QDIghVFyB3QoF3lcecDyerMy9MK18NjgwfboPL2r4CjRxCmIRYc4GGP1Lpcy93Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ElGRsFvJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dae49b1293so15098f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Sep 2025 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756911238; x=1757516038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoaNAmWhIibGu6l1WRy5RqFKcSEP315ehpRCdLHsl14=;
        b=ElGRsFvJjKb6W+daOxlv/O2CFyeAtJ9hdLOWpcnFaGSxSPsuYAkaxMmOAg1MW9sP/G
         vLzzNlbMhIlhOer4oDjNeEqtqVnfOO200OW9o9b9qbjgtypayBW2sIMiifggZFNwx14y
         /ZMgdlaE7XoJVhotKXe9+KajSTPcCUWhvfiZJPnwDFRDLRjL4Wq8CS1ZIR6da0mjq7P9
         apEVHzZtQVfRodptHAtsVTcT3/XqT0WDMG5oEnpkm0LRK3fmsw5n7npiV9aP3cKAPzQS
         37F+atFcfecj2TJlaucd08UiTxlytYxBsairpQY68RtR5uBWiIztgvvEJ0a+61TDflWE
         cQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911238; x=1757516038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoaNAmWhIibGu6l1WRy5RqFKcSEP315ehpRCdLHsl14=;
        b=K67DNEsd/vsDr2Arh67M34dX0Rv/NKBiWTGnBQT2K3B75vkyat4P6/X6eAbfiy+KNS
         2jeE5wS234kQ10vxaF4I+MPv9SQyz0u3/K9ss7/y+wF1kg4s9Aeqd8jzTNJpUbXrtSse
         BP8r/jimCVMa0Ny1ykStJzTSr8RdWqurTl9nON0x9EEwtc/K2kQx3ZVv5pLdgNVD5g+A
         rArUW52nuA+gA/5DBH29D9z92JPFc4v60qL85QQ3WlWYxdRjSr4wtgJLZ2asrrobqM5c
         AoA6B0rcIJuKGYHsU8U+TetvjLJPZXclYcqrwC2qRqlSucu8XyWhyriY2xevrZINetnR
         QUjg==
X-Gm-Message-State: AOJu0Yw24zcjNgNebV/JBy8mY3GgEKAcjSvdNWC94Z8AEbBKGgPqR4p9
	2V3FtBXh4d1YrIIpCQwtYq31BwLtXsnYP3HpYt1PCmjZb50gWvlewalM64JN2UGIILs=
X-Gm-Gg: ASbGncvabc8bUrnQSxNGqQag/XOurG9C2negADc3ruX8Oe6KyXHFUD+QEqvOwC2pjCe
	8092L5+lOfrpiXuktjZKqr8nKDyGEB9wHAKTLdAkPcZsMaUiCD3q8OvU7SNITXYUw8nP/h+41mx
	iZ2B/qBaGCpIIkyYDRC4hf5Mi2o4JAPLhV8qIxn6aS0mPU/vlz3rCuQVRUwlrO9huayLFOUjDhp
	fjpPVYTsRorHhYjcd7pbZZQzyo1THrflgXS/7Mcv+LDN4AV7UFT/Bh1Yuw4Zjef7Jpifao79Vkh
	iQg9szMC8oA4PPrmH1d4RxDppYJRJLE+XsubDJgVzQN6lWHnI+0QyWzA0xtQHwFICtakCpye7cC
	HBvXDRWBlzOwQgzsRm1eKOefkXS+z2WWjy/7KwLhs3qE0c9JayK8TY6vt3LioCPMU1R4qnZfUY1
	Gn/De89wybZv2lSh50qGBKDXk=
X-Google-Smtp-Source: AGHT+IHKfKTbLX6DEzjRIqHHgWQYsVAqnbGKlA7TGvZ37mdtddbwJKcqflssNkEpjctd+pomGp9Tmg==
X-Received: by 2002:a05:6000:2908:b0:3d1:8d1e:906 with SMTP id ffacd0b85a97d-3d1e08a06aemr12584267f8f.59.1756911237655;
        Wed, 03 Sep 2025 07:53:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2a30:223c:d73b:565a? ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm89079915e9.2.2025.09.03.07.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:53:57 -0700 (PDT)
Message-ID: <3659b492-c135-4fe1-9ffe-70877e4da0f5@linaro.org>
Date: Wed, 3 Sep 2025 16:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nuno,

On 03/09/2025 13:20, Nuno Sá wrote:
> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>
>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>> register (SAR) ADC. Two instances are available, each providing 8
>> multiplexed input channels with 12-bit resolution. The conversion rate
>> is up to 1 Msps depending on the configuration and sampling window.
>>
>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>> in both single-shot and continuous conversion modes, with optional
>> hardware triggering through the cross-trigger unit (CTU) or external
>> events. An internal prescaler allows adjusting the sampling clock,
>> while per-channel programmable sampling times provide fine-grained
>> trade-offs between accuracy and latency. Automatic calibration is
>> performed at probe time to minimize offset and gain errors.
>>
>> The driver is derived from the BSP implementation and has been partly
>> rewritten to comply with upstream requirements. For this reason, all
>> contributors are listed as co-developers, while the author refers to
>> the initial BSP driver file creator.
>>
>> All modes have been validated on the S32G274-RDB2 platform using an
>> externally generated square wave captured by the ADC. Tests covered
>> buffered streaming via IIO, trigger synchronization, and accuracy
>> verification against a precision laboratory signal source.
>>
>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> 
> Hi David,

s/David/Daniel/ :)

> Just some minor review for now...

Whow, thanks for fast review !

[ ... ]

>> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc
>> *info)
>> +{
>> +	struct device *dev_dma;
>> +	int ret;
>> +	u8 *rx_buf;
>> +
>> +	info->dma_chan = devm_dma_request_chan(dev, "rx");
>> +	if (IS_ERR(info->dma_chan))
>> +		return PTR_ERR(info->dma_chan);
>> +
>> +	dev_dma = info->dma_chan->device->dev;
>> +	rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
>> +				    &info->rx_dma_buf, GFP_KERNEL);
>> +	if (!rx_buf)
>> +		return -ENOMEM;
>> +
> 
> The above needs some discussion at the very least. Have you considered the IIO
> DMA buffer interface? It should be extendable to accommodate any particularity
> of your usecase (or we should at least discuss it).
> 
> With it, you also gain a userspace interface where you can actually share DMA
> buffers in a zero copy fashion. You can also share these buffers with USB
> gadgets. For instance, with libiio, you would be able to fetch samples from your
> host machine (through USB) in a very fast way (zero copy between IIO and USB).
> 
> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
> to retrieve the data seems counter-productive.

I'm not very used to dma. If there is a better implementation to put in 
place I'll be glad to take any suggestion to understand the approach.

Is there any driver using the IIO DMA buffer interface I can refer to ?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

