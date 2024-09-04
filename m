Return-Path: <linux-iio+bounces-9138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6699296BB72
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA501F24D88
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C11D588F;
	Wed,  4 Sep 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aPBVrLlY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE713D504
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451382; cv=none; b=aL7VbaBrmdty6ERYPxqbsXVwDWAi3X9efIiLGTFfjyA3jrOzI7LNuTxSh3bLEiLaWoIAfcKikvtZfz43OpIY1sI90JnDJE4Mwp97ZimoATHcjwv+009V33T/MFqfyELuU34k+VSFMeJIicamOmjRcuk+IjV+ZkUAQkf51ZukvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451382; c=relaxed/simple;
	bh=DuwkdyX79hVNS4+oaIn+EcYGas76m4q5fKNzc1LrUl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVUtkIOgCM+Qkv7b3KOul/GeOOfNbWWdGf0JqAaBu8I5MTjZcXZu9fsZyYy9gUUoXlnFxMmvPrO4wloT/VxED2eTnqi7L2mWNj4INZMVnCgo2x+ROsYV6K9ScTOq7dhv08Nx/1c9gVbkOPUfDrRJVFj71eq6WRc9ET5lYYBRezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aPBVrLlY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so45397925e9.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725451378; x=1726056178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvS627k5mguTl6HQhQd8bFFYU60r4VpnIC1+jtP2Fdw=;
        b=aPBVrLlYN4C9FPAGy0rrkZ5y7IRxnfZvnCfWuU2ZFdaP9q0aIJ2G1Yiq2fLakhTYO5
         /TMLpGpmOFp2LHHoNPYezjalG56ul5htl0SUHtyvNieZ16YNJXBk7bJDglOJtna7sGHO
         krPbc9U/MmvEgpMvoyuZfhana31jbSAJURDwu3cQfdZwfB/7dv8IzSw0WXk9Z+bOlBWV
         +imBw7B4+PlBCxgz/VGYhWGfEkd0H1dfIFdk8D4kAY236BAt+xTlH+fgjb+z3Qr9mNzV
         zCmhlccnOCjNlszkkqD+fEvI57MC4P9EQmsvGgmzHHFoOMdoTKZc9sGAbPoGtYAgmEm2
         /ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725451378; x=1726056178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvS627k5mguTl6HQhQd8bFFYU60r4VpnIC1+jtP2Fdw=;
        b=VxDOCLhdc5MdT/6FzRxDDAuu7SFywwgm+RkUk2yNRzvpjalL17k2PvyoyiIco/WfTE
         CcTpWuXC+Zb6UBaLG8z8uPXN3INDA/dQVTgmi3MgodyT43ekfVNcJDsasYRkV1OZqpXM
         fBNRBUXneAx0fqm+Ky/912+Mna3a1dE6UbGnYxjiPIDQqbiyULP0KNhdTxLChjGL1QJl
         V43LOw3hnETdhKzh+ZJ0MG8vLZODAmq90ZJbWFP8/HJZWp90cRNba/VaypYZc0CIiOtm
         ofUzSzjLaO2chIiuxFAF3UkJ8CcehbIbq4QQICC9acWGx/iKk4wP4nUSFvqFq2Lprk12
         OzUg==
X-Forwarded-Encrypted: i=1; AJvYcCUaTze/87VN0nVVaCuVaYZGW1m8sNUVhnT5pwbVnvx8EByjpmZaOrZTZY4lOaAvTMwNETUoBulg6vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnPkaOsMSy6vI2PIjjpTNd+xmHSwcMrToxP2sykduehA0w6zu
	XuiT9webRlRR2TagyyjpTcIul0Aynv37vlsurETvkNYtRN7mVruJG1OJx1hiZGg=
X-Google-Smtp-Source: AGHT+IGk8WHoR74IDQuzsi8pl8eeSyosTrzQ54iEQJwg3b8v7wrrUdSm5Dt6azgUY8kcqM6OtW+/Hw==
X-Received: by 2002:a05:600c:3b8e:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42bb01b556bmr160676335e9.15.1725451377986;
        Wed, 04 Sep 2024 05:02:57 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm16758198f8f.50.2024.09.04.05.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 05:02:56 -0700 (PDT)
Message-ID: <4826097d-b575-4895-9335-f587bbf3bc89@baylibre.com>
Date: Wed, 4 Sep 2024 14:01:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] iio: backend: extend features
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
 <20240831122313.4d993260@jic23-huawei>
 <0fbe1321-cc67-4ade-8cbb-cbbaa40d2ca1@baylibre.com>
 <20240903201157.5352ec04@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240903201157.5352ec04@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

On 03/09/24 9:11 PM, Jonathan Cameron wrote:
> On Mon, 2 Sep 2024 16:03:22 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> Hi Jonathan,
>>
>> thanks for the feedbacks,
>>
>> On 31/08/24 1:23 PM, Jonathan Cameron wrote:
>>> On Thu, 29 Aug 2024 14:32:00 +0200
>>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>>   
>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>> Extend backend features with new calls needed later on this
>>>> patchset from axi version of ad3552r.
>>>>
>>>> A bus type property has been added to the devicetree to
>>>> inform the backend about the type of bus (interface) in use
>>>> bu the IP.
>>>>
>>>> The follwoing calls are added:
>>>>
>>>> iio_backend_ext_sync_enable
>>>> 	enable synchronize channels on external trigger
>>>> iio_backend_ext_sync_disable
>>>> 	disable synchronize channels on external trigger
>>>> iio_backend_ddr_enable
>>>> 	enable ddr bus transfer
>>>> iio_backend_ddr_disable
>>>> 	disable ddr bus transfer
>>>> iio_backend_set_bus_mode
>>>> 	select the type of bus, so that specific read / write
>>>> 	operations are performed accordingly
>>>> iio_backend_buffer_enable
>>>> 	enable buffer
>>>> iio_backend_buffer_disable
>>>> 	disable buffer
>>>> iio_backend_data_transfer_addr
>>>> 	define the target register address where the DAC sample
>>>> 	will be written.
>>>> iio_backend_bus_reg_read
>>>> 	generic bus read, bus-type dependent
>>>> iio_backend_bus_read_write
>>>> 	generic bus write, bus-type dependent
>>>>
>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>> ---
>>>>    drivers/iio/industrialio-backend.c | 151 +++++++++++++++++++++++++++++++++++++
>>>>    include/linux/iio/backend.h        |  24 ++++++
>>>>    2 files changed, 175 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>>>> index a52a6b61c8b5..1f60c8626be7 100644
>>>> --- a/drivers/iio/industrialio-backend.c
>>>> +++ b/drivers/iio/industrialio-backend.c
>>>> @@ -718,6 +718,157 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>>>>    	return 0;
>>>>    }
>>>   
>>>> +
>>>> +/**
>>>> + * iio_backend_buffer_enable - Enable data buffering
>>> Data buffering is a very vague term.  Perhaps some more detail on what
>>> this means?
>> for this DAC IP, it is the dma buffer where i write the samples,
>> for other non-dac frontends may be something different, so i kept it
>> generic. Not sure what a proper name may be, maybe
>>
>> "Enable optional data buffer" ?
> How do you 'enable' a buffer?  Enable writing into it maybe?

for the current case, this is done using the custom register
of the AXI IP, enabling a "stream".

return regmap_set_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
                    AXI_DAC_STREAM_ENABLE);

Functionally, looks like dma data is processed (sent over qspi)
when the stream is enabled.

Maybe a name as "stream_enable" would me more appropriate ?
"Stream" seems less generic btw.

>>
>>>> + * @back: Backend device
>>>> + *
>>>> + * RETURNS:
>>>> + * 0 on success, negative error number on failure.
>>>> + */
>>>> +int iio_backend_buffer_enable(struct iio_backend *back)
>>>> +{
>>>> +	return iio_backend_op_call(back, buffer_enable);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
>>>> +
>>>> +/**
>>>> +/**
>>>> + * iio_backend_bus_reg_read - Read from the interface bus
>>>> + * @back: Backend device
>>>> + * @reg: Register valule
>>>> + * @val: Pointer to register value
>>>> + * @size: Size, in bytes
>>>> + *
>>>> + * A backend may operate on a specific interface with a related bus.
>>>> + * Read from the interface bus.
>>> So this is effectively routing control plane data through the offloaded
>>> bus?  That sounds a lot more like a conventional bus than IIO backend.
>>> Perhaps it should be presented as that with the IIO device attached
>>> to that bus? I don't fully understand what is wired up here.
>>>   
>> Mainly, an IP may include a bus as 16bit parallel, or LVDS, or similar
>> to QSPI as in my case (ad3552r).
> ok.
>
> If this is a bus used for both control and dataplane, then we should really
> be presenting it as a bus (+ offload) similar to do for spi + offload.
>
>> In particular, the bus is physically as a QSPI bus, but the data format
>> over it is a bit different.
>>
>> So ad3552r needs this 5 lanes bus + double data rate to reach 33MUPS.
>>
>> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>>
> Jonathan
>
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


