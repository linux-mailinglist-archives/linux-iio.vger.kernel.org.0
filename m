Return-Path: <linux-iio+bounces-19511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A2FAB6753
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EEA3A4873
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3522CBE2;
	Wed, 14 May 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx/kBExt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756702253E9;
	Wed, 14 May 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214496; cv=none; b=I8gawmNjPOBs12U6z/BTpARaaUlJDxZZT03ERxnD8QyRtwDuiyz2+Q+FPYuiZuUb9Wmv4Mb90P0ZdPaQ/ss1Rnvg8TZzO2BplhO9hHx7+8/EtrMzPMjucO2OLus+uBUahvarmfe6jmEuh5hlzyo1DMSbhsbtEiiUJS3a2ikxK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214496; c=relaxed/simple;
	bh=tR883kMOoHbOluv8q6ujapdKy6utTqe0KM+gfzLlNfA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n6FnBRTvKGi/gU4grq23MPrVFLYOf8Ac4KdUYa7UBRiegYZkfggHR/Qk/RVgbCm5TFuGl8XVcKrUYeszMrJB0QbjKphcAQx/IelbX/nEbKoFq37TfbVKZzkudHiE9W/OEGse7miV9Q2EOeRXemOOPhaZ5xCvUSToKbxS5rGrFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx/kBExt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db1bc464dso62424181fa.0;
        Wed, 14 May 2025 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747214492; x=1747819292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KjbYfCEVCFS3UZNIAD2NZgl3DfkMX5aeNDJvSamuYVg=;
        b=Nx/kBExtN5zbXnDhfbdDgVedgQZrRqnSnBeGklmHvXNv9Ct8HvinWEeZ/YGKYLMfXP
         Lg0/AlQdl6sJQ+jaOflcZx4zi/eIlLuHx+vea7Xwq1q0J02wn6DHWpiihnyzKHLD7e56
         CxfVKjgEv9ewdMK0ehCKtp8/xMbCmz99liaxsT/9MTryeWsEPXFBlXAkfkrmcGKZinnm
         CEvzhsTMS0IASspiMxJNommNp/oj2vgG+fSyT9IkTTR8ZWG/ZAgFwerCe/bRVFvZmxp/
         iY+kRCX5Lz/ooiV4qdeT406Sf2tmUly3JstkSHOYFRdRZVqM9fW3G6MyNJTPlRC3yOZB
         xRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747214492; x=1747819292;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjbYfCEVCFS3UZNIAD2NZgl3DfkMX5aeNDJvSamuYVg=;
        b=Uih5i0ie0k2x9TIHEVvMes193czf+hAkyDMnj8WSZRHiFCLbDPDtAwBAWe6NZoeo3r
         KFyZlKJR0vlzO7tzAlkOPDLent0SWiiZ7SXJnSD79gHhUlInAzEGr15FEHFTCzDMXZrd
         Rs6XPTz2pydeEo4jJkYcsEHxGXMOjp7Y1/S8fXP/S8j2HlwZ6abLxe0GktOgFYc4bLAW
         PlRDkciIcV2j7fVjupreSf8x7nJ1FmNYHV2z7R6OClsphZpuTQlfZrhNqZ7zI4+17JYq
         KxpVcw5DXfjVqPgNSFr5CHXBZ7Fkw/uU5cjv8FMoeiJ2K6jMAYfCk4bdLub2AoGur909
         DYXA==
X-Forwarded-Encrypted: i=1; AJvYcCVGQjUJ8n2YsiwglLlGRREeUtrztoJZm4+qK9KBlBHlaE5iHfZrDVxW+URptV1wIVEljpyBmK4q1xgLQ9wS@vger.kernel.org, AJvYcCVkTeTags4ZdD0nTKZTaFizGj7BxNqsaxsIAC6UEpBvBxEpOR4TaHTt4eFM1MEZx2n6OtEcF3nmY2Od@vger.kernel.org, AJvYcCXe5WMiOTV4oO+z/TbWWidEFDkBja/ayQb26viZ4QS6VkYL4BBc+DsBuB7KEDVpPlMlAHsYG1dSPyec@vger.kernel.org
X-Gm-Message-State: AOJu0YxTL96DajmJHql3+5UBinU35jGSmTm/d4pAgHcPGZtcN8MZnUpk
	/AZMvHCsRHMdLWvotVzPfKqptbmX8PEaZxiD3mB7Tt7/fQcsSgrm
X-Gm-Gg: ASbGncuAyGTxlZEOYwAWDexrHfUDU+Mfm/ZAdHAxv9vCvWpsDJPdbxqFHFBzXenzzma
	E17NhaySrBa7vw4r+X/D9zFbqxMbtN0uNGJWGMVdAG28/xDHRopcBW+VW8sMC+YfjBr6wnmoo43
	bwUUvC0ASXoIqfh01MkRRki8XFuREkRTwW7NIGBvJvMj0SsXgaGssiTy+0v+v6cE3SP7UaAkfpC
	APv1pemQ3FFvyVVxhqoMvcPypzHn8MSeZhvx8Y0Y6clTr3hyPEpwxxzJIC6nsRsgbqDSPR3oadz
	19/N/qffIz5BrYGRaCFaQLcVeo2W+WI4+DxeRcSwJogewZTEFLNBDHARakBe+8bcYF7lPfcDSNj
	0e43HZgrrL1CMbUkaJhkcaZNieNB2FfZe
X-Google-Smtp-Source: AGHT+IHx7mOpFNkteQCtu3aVqL5FI0DY2rbNPAk8loPHngRnMdRfE5DwUyn9l898kMIqpqZqYdKDmQ==
X-Received: by 2002:a05:651c:b10:b0:30b:efa3:b105 with SMTP id 38308e7fff4ca-327ed102ad5mr10993521fa.19.1747214492166;
        Wed, 14 May 2025 02:21:32 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c339a41bsm19271401fa.19.2025.05.14.02.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:21:31 -0700 (PDT)
Message-ID: <5ed56b89-8a9b-464f-9b87-f6553395a941@gmail.com>
Date: Wed, 14 May 2025 12:21:30 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad7476: Support ROHM BU79100G
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1747123883.git.mazziesaccount@gmail.com>
 <a6d84a4c9cdd961fbda38182501983f26cceadc9.1747123883.git.mazziesaccount@gmail.com>
 <5f36c304-ed09-4a13-b22d-ceb5924c3739@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <5f36c304-ed09-4a13-b22d-ceb5924c3739@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/05/2025 10:38, Matti Vaittinen wrote:
> On 13/05/2025 11:26, Matti Vaittinen wrote:
>> ROHM BU79100G is a 12-bit, single channel ADC. Support reading ADC
>> measurements using the ad7476.c
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/iio/adc/ad7476.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> For anyone who might hit this mail thread later:
> 
> Conor made me realize that, for now, the BU79100G looks identical to the 
> ads7866. Thus, these code-changes aren't needed at the moment, and this 
> patch can be dropped. For those who wish to use BU79100G, please 
> introduce it as
> 
> compatible = "rohm,bu79100g", "ti,ads7866";
> 

I was too hasty.

It seems to me that the fallback won't work with the current driver 
because the driver is not populating the of_match_table, but is relying 
solely on the spi_device_id table.

Judging a quick code reading, the spi_driver_id table entries are 
matched to the modalias:
https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/spi/spi.c#L393

Which is (as far as I understand), generated from the first compatible:
https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/of/base.c#L1170

and not from the fallback one.

I suppose this means that we would need to add the of_match_table entry 
for the ti,ads7866 to make the fallback entry to match the driver.

But...

The __spi_register_driver() has following comment:
	/*
	 * For Really Good Reasons we use spi: modaliases not of:
	 * modaliases for DT so module autoloading won't work if we
	 * don't have a spi_device_id as well as a compatible string.
	 */
https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/spi/spi.c#L487

So, having the of_match_table for would not be sufficient for the 
autoloading, which would still require the bu79100g to be in the 
spi_device_id table.

Am I missing something? I don't see how the Linux SPI drivers benefit 
from the fallback entries in the dt? (Not saying fallbacks wouldn't be 
The Right Thing To Do. Ideally DTs aren't for Linux only, maybe some 
other systems can utilize them). To me it seems I still need to add the 
spi_device_id entry for the BU79100G, and of_match_table has no 
additional benefit? If this is right, then this patch is still relevant, 
even though the binding should be done as in v2.

Yours,
	-- Matti




