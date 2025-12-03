Return-Path: <linux-iio+bounces-26695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A717C9FDB8
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28697300C058
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D8350A3B;
	Wed,  3 Dec 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I9xT3t/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54AD3502A9
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778485; cv=none; b=tHtHAG2qSzuDrK8A/wXQ3qk31MazoRYDaD+1LPS/fwnbt1AdCpxuh08/uRVs390aulX10v2T3xKsVY3c5RBK8EfbB9TA7F6QCkdbEMotmo4/3Uk+goZKRHlY1Gq7wPyxse25SIxDCi1uOw/5W0WBWqH3gMGK6iqQ8OIgiDfFoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778485; c=relaxed/simple;
	bh=hglrjI36wCyoBMRPgYGkQLchKBkAjdCGHhB0erqcKLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmR9vwAUGKrA2EAP5D6cV1qJ+rCy86SlV2IfXGsAM0qmuEqrSL8rXcNEoj5h3MxHOhX6mMzkoNXSeEOoiWJbejoBLAv0ycDYHqknSm9etwZAsNEVFabhoAa7jjNK3J1E14QKJ+FGJokbGNjZSUtuZhxVBHtnwxGtYtHlOjrVnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I9xT3t/T; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ec41466a30so961156fac.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 08:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764778483; x=1765383283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KncOUXM2MlKKtA4HBMgh8JoO8I3F9aXK1OcnweSUVg=;
        b=I9xT3t/TuDpvR0f8MnbZJMPgnxAcNe/68Z9aF0Mq0PtUrjOEMpYrr/oNn1CM77eOyj
         0dfyfcRWWkht/9Mju2dMSpOQs9wiswfeGCCjhEyJhFg1+bqdiW52NG5JWOaAQW7d9aoL
         UqhT9Yq2/9Bp9x4GtEOOhBBgmxoDfryNjg/UoKbfLCsK41ghO+Jodm2/opltRX8vHwMY
         IDcQe674qDQj3li1G6NOWxIRsYs0cv5qNgPMbMEfthfjl2H/KSm9x9E/8FQ71ZDd1Gll
         0M1uDIk2UhW5SNLmyqBHQvVrfpJoD36PEujiSkeyft5s0vfjac/uMmAGDy29oyYouy0A
         bX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764778483; x=1765383283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KncOUXM2MlKKtA4HBMgh8JoO8I3F9aXK1OcnweSUVg=;
        b=CWWlhWrJp06msJR+1iYvBREAuFEI/+71osAVRx6gNpKS3NYVhx1h2i0FboEPs83JVy
         W28bKev8wv6SogCNF3WhPo/2Jvdd7VDpt2gkPhZtNwdrEl1ZE7ta9klKNWV/6GZPTv4J
         XSLnm19/YwByH0O+SNOWtOiTGUjXNqy0Th0SeecaqNr2tgNl76cYVCsEPUh4dGae5cHk
         ClXqFI1Nu8EIT0pzZvs1QrXlv2e/c0s1eeOS/k1nqwAqZB+Z9bmgYe8RL8TBbFkCm03m
         Bi7XMS45jP0hdTcINZ4eTfL51tTmkMf8C8k1dKFaCqdbiVY8+NDD42It0/wlTsLzlKLh
         OXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiqifafZfoXFc0AzeLfxKqwJxSNM/NF1THy1Ai8F+TrfioHMJqyvqd1s+nvmldzuhM/fOuBSJZCKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySV2L1FyhR7X9JqXQjTEM2jM+lYncLeBXFdUd7r1Ic7wt7AXqu
	elMA2B2R34vbdPREfGCMxDGuw17dVz76J/AMfQG/D9OekdcgukJzu63lO/lX4yZW2/U=
X-Gm-Gg: ASbGncvymRco6sSGBXGrzXLQgPbjm2yPGNwbo43SF1Jw2doJ0foD3ucx1qd0uzdNRD/
	GnpDaLHRxwZwlEF32V1AEsat2WecihjV/rkLxoZ3FS3i06cpN8I0VFN3+I7WlCJx2QAnJwrHsbz
	Fk6pDQqsH0gzDWBxNju7bFilHSeZNzue4koZ9O4sqoreZ0wAY1NAQImiqhSbGqFQ2iMpEWpeW1e
	1hC4FM71UXSF35gWiRcl7McritCiX+wcWC4M6FADI+FgceckCzpIiRB8sHAcFz3jkmRXscLPa/c
	OoMqfr5M1C2g6zXDUVmRsmejo/38jsNxxppkfOHJ7CV1MQnPK2pGkn6fY1oeWCUDPeAy6exWV44
	+8g5VJUn4dB41mMMtba0j3N3A6rcGm0ssig5nrQwIB3WabDnm90aOfB7/9cd4QmDTjL753/ktys
	ehENYVegYtoPZSHD5VmpVJ7RlN3yN5W0GxevCdkwn6eO1HvZIqqsuHDRnC8Q==
X-Google-Smtp-Source: AGHT+IFEn8mwNzjMMpROH6sQdOVpwKxqYVn8+uM7cQOrm+gu7b+cn45UdldpCnee/HT6q8w9VkB3sg==
X-Received: by 2002:a05:6870:a11b:b0:3e8:9cf8:53a1 with SMTP id 586e51a60fabf-3f168293656mr1873009fac.15.1764778482704;
        Wed, 03 Dec 2025 08:14:42 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b05:aad2:5053:6d1? ([2600:8803:e7e4:500:6b05:aad2:5053:6d1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dc766dc3sm10432531fac.0.2025.12.03.08.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:14:42 -0800 (PST)
Message-ID: <44640683-de26-492f-a7ef-6af4a61518f3@baylibre.com>
Date: Wed, 3 Dec 2025 10:14:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: adi-axi-dac: Turn dev_info() into dev_dbg()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
 <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
 <a17f410b-17b3-4abd-98c0-be6952894eaf@baylibre.com>
 <13c8796d8c24f2d0eefd99e6529bc91d448243b8.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <13c8796d8c24f2d0eefd99e6529bc91d448243b8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/25 10:10 AM, Nuno Sá wrote:
> On Wed, 2025-12-03 at 10:05 -0600, David Lechner wrote:
>> On 12/3/25 9:53 AM, Nuno Sá via B4 Relay wrote:
>>> From: Nuno Sá <nuno.sa@analog.com>
>>>
>>> We should not abuse logging and logging a successful probe is clearly
>>> abuse. Turn it into dev_dbg().
>>>
>>> If it turns out the IP version is that relevant we can make it easy to
>>> get through a new debugfs interface later on.
>>>
>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>>> ---
>>>  drivers/iio/dac/adi-axi-dac.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
>>> index 0c7b62f5357d..f536158beb4c 100644
>>> --- a/drivers/iio/dac/adi-axi-dac.c
>>> +++ b/drivers/iio/dac/adi-axi-dac.c
>>> @@ -1000,10 +1000,10 @@ static int axi_dac_probe(struct platform_device *pdev)
>>>  						"cannot create device.");
>>>  	}
>>>  
>>> -	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
>>> -		 ADI_AXI_PCORE_VER_MAJOR(ver),
>>> -		 ADI_AXI_PCORE_VER_MINOR(ver),
>>> -		 ADI_AXI_PCORE_VER_PATCH(ver));
>>> +	dev_dbg(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
>>
>> Didn't ADI HDL versioning policy change to semver so that the last number
>> is no longer necessarily an ASCII character?
>>
>> We could probably change this to %d.%.d.%d while here.
> 
> Honestly, I'm not sure how that settled up. I'll check and if that's the case I can change it.
> But then it will be a bit messy with older IPs. Maybe moving this into debugfs and handle the format
> there would make sense.
> 
> - Nuno Sá
> 
>>

If it was still an ASCII value, it would just look like an unusually
high bug fix number, but I don't think that hurts much. I don't think
we need to go as far as changing it to debugfs. It should be pretty
obvious if that is the case and people can figure out how to convert
the number to a character.

The dev_err_probe() function in the previous patch in this series
also has the same issue.


