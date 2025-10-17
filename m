Return-Path: <linux-iio+bounces-25178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C6BE758F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0EE428AAD
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D22A2D2486;
	Fri, 17 Oct 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I01NWFiH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6002C3274
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691709; cv=none; b=SzZ8CRSDjYMgwBY/rg23+Ld5zMMVW6ZNaSNL3PE64HNidLG7etDnVqpdJlPs44qhdgYr6YQIJNMi/3lBoBIBCdthHEahVpfOD5/8rerp0ZzJ4yDx4hHdCLcIQ2nUyNQwsML0A9MghQYZiKjhHQTTOvTgIfdHYqp2evbragDQRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691709; c=relaxed/simple;
	bh=djPFq2gC3Dt2nGEV5JtwRUan8R7/PSxIqukec0osdPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHU2UrZ3+fyesH9gh+hhTSQFvMbjG5z83g7CU5jhCZa9+4pqdKTLId2kmse82pOFBOxcl50XESyOL4v1ywqCUcHpQNjYXm//kG1h1BNWlVXy2JFfRU4RFcgmK4tWmhU4VXzA5ujFCtyY83WpBShyRfJWaMgR5gs12psso3F5AS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I01NWFiH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1556977f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691706; x=1761296506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKxKNbwNQkJ4t2h3+ChbVVYFS7tJ5MtBs9u+B3K37UU=;
        b=I01NWFiHjYHwR7mBS2Sb0F50alLe8BulqmC+qmZx7eqPO1MuNPNkC9xAiUbE1BR5mv
         V79iAw9NBfX+tadlmaLD7Nd3u3/v2K2MZ4UKxdaqWCRSySbvRT4MoVK6WmesLhsuDldy
         6LGQOGnWsURCqiZOR6m1rrU5m4otzqvQuNdp0MtAhSzwuNzrAo9NKYo/mZv2wqS+okDt
         Wnal8lnlvg8flXri2Pd7Ral0kzw+Y4rt3Gaq+uw+iwWGVae7LpqnqEPiVG5KYDd4OFvD
         7dFRVQGtezgUlMHyAW5FOdJfrfxcYvGAYdXbSUeQ6Bz6rW4OGHv5Vt7BjIdOk/vJTl6C
         zbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691706; x=1761296506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKxKNbwNQkJ4t2h3+ChbVVYFS7tJ5MtBs9u+B3K37UU=;
        b=gdHh0Qh5+VvhkqbgJuWuEZxH8yn30ciKPq90b+FGaEkMyvvDkOg4nPwNmqasQmmTBX
         RbTDQ+Nuqpn+zLzHL2EVztpFIUoqJHwrzBuzhH2zJG7fJcEwAuJz+QSIjwPH1RkcENjL
         Ntz/eiba4TAhlZ7xM46pP7PEb2OjFZGSu1C3cLJlXwPdYWVAFfBZuHKEAfomIbnTdlOy
         nGPoRQTEHyjtNboA2gMBWpUP3Q/RDZvXRvKucHqruJCUbmmtxkmJufp1ubpmmvtYSnRi
         ml0URV5H94irg8oDPg5KCFHccjA7vuqkKDgi+nXgzGCwW4G8cN+YfZIRrvV6NWfkRa0L
         UGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWHjPGJ0tSMCF4MztfdXa6fWeytnBWzGnD5Fm3SBzKYPx5hmwcjKDzaJVIKBHWINTOOFT3r1xb3lUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gvMNxS/FmuuYQv4+Maph77clKcw5WCA7x4FkT/2EyQOkinsy
	GoJHgMhGud0a9+awSefE10XYWFoOalduRnrDkbhSb6j2pLvkql8ozMXpypXaDysTie4=
X-Gm-Gg: ASbGnct4xe4+YW7+46rkcNUy3BeGEtpllt/2aD3stA5pDFTvC6Q9sW4l1O48vYgSxrH
	N0VY7hluyYW3e6LUS9Rpa9+Vrkx6MV4bG9cT+8ThEf122E8Byi1CRcAyExff01v79GoFH5MeWq2
	F6XjhdOSgVahHrxwD8Ma7bYHJ4Ur/gHHwphaWlv3fV+KkTfGoLic8JSPQvCgq/vawBjKxydDmoe
	6R9fzoRudeHUqhfuAYRFFkVq7ibwo1MmmxYrsQVSzujbByg7MYEjdVjtxETl1HoihEWxe6OOiiC
	lNd2JC6j/98tDrEN4ukpN0S+dS6gMy+f90DlR29ZF1fCvf+WYc6rGZz/oIvKQ3mwJPciVAFM4qI
	eqAGXHQULW7PkSWylTC8fjx062MKKxc7ifB7qupbnaMAS42ELduyQpX0FK1BUh3hZvnio1g28WW
	2uAvy0ThjHdug0EQo7GNTO3y6uyst6sKU+gm3Ritx0InTvzmycSVd8fbg=
X-Google-Smtp-Source: AGHT+IHfJonJhWahWTiwtz0KvkOGbv6zgJWv7y5VwWJlO4+UNFuOt7HIqplliOl6LmCWRzK2SmhOrA==
X-Received: by 2002:a05:6000:2087:b0:427:921:8972 with SMTP id ffacd0b85a97d-42709218a43mr446976f8f.40.1760691704830;
        Fri, 17 Oct 2025 02:01:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1b84:3139:75f4:2ca6? ([2a05:6e02:1041:c10:1b84:3139:75f4:2ca6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4270516f930sm4722303f8f.31.2025.10.17.02.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:01:44 -0700 (PDT)
Message-ID: <1bfa9a86-0a80-416a-b653-8d14f5ebd891@linaro.org>
Date: Fri, 17 Oct 2025 11:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
 <20250919135618.3065608-3-daniel.lezcano@linaro.org>
 <20250920102742.4cadb734@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250920102742.4cadb734@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/25 11:27, Jonathan Cameron wrote:

[ ... ]

>> +static void nxp_sar_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
>> +
>> +	nxp_sar_adc_stop_conversion(info);
> 
> I assume this is safe even if no start has happened and is here so
> that the driver remove can run whilst buffered capture is still going on?
> That should be done by the core as part of unwinding the register().
> So I'd not expect a need for it here. This may be a side effect of the
> ordering issue mixing devm and not causes.  The same is true of some
> of these other calls - I haven't checked them all.
> 
>> +	nxp_sar_adc_channels_disable(info, NXP_SAR_ADC_CH_MASK);
>> +	nxp_sar_adc_dma_channels_disable(info, NXP_SAR_ADC_CH_MASK);
>> +	nxp_sar_adc_dma_cfg(info, false);
>> +	nxp_sar_adc_disable(info);
>> +	dmaengine_terminate_sync(info->dma_chan);
> 
> Mixing devm and non devm is a never a good idea. Here one possible issue is that
> the userspace interfaces are only torn down when devm unwind gets to unwind
> devm_iio_device_register();  That happens well after this code has ripped down the
> dma engine that a channel read will try to use.  It might be safe to do that
> but it certainly makes the driver harder to reason about.
> 
> A simple 'rule' is once you first call a non devm function in probe that needs unwinding
> in remove, you cannot call any more devm functions.   Whilst there are lots of cases
> that are safe, this approach ensures none of the cases that aren't sneak in and makes
> review straight forward.
> 
> devm_add_action_or_reset() can often be used to keep the chain of devm calls running,
> sometimes covering everything such that we don't need a remove callback.
> 
>> +}

Actually I think these calls are not relevant. If we remove the 
nxp_sar_adc_remove() function, the iio core code will unregister the device.

All operations are doing on/off in the different callbacks (raw_read, 
postenable, predisable). When the device is unregistered it is not 
possible to have an ongoing conversion, a channel enabled or the adc 
enabled, as well as the DMA. IINW, we can just remove this block of code.

[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

