Return-Path: <linux-iio+bounces-19209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED32AACDC5
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA6852125D
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1101F8755;
	Tue,  6 May 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L9K2OaAI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70D1F7904
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558609; cv=none; b=BQ/rcLOisEW6L5LgJTNfS6z6dzvQXwtI9abSNmnY8qxrEHnhTJ14EHhkpRs1ELunSBrf95eBDyT2fhE0+/2chb2dfCInPviZ5bHOXj9lNVHKVlwvOUllSGgXnWxzHnDGriPqzgK2FBwh8BQum4Id6Pg+dM4ZSfAfhBWKO6gzN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558609; c=relaxed/simple;
	bh=W5LSkZiC6OONbIl3yFWmvcAKLA5RZHe07Z/De94PpK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdRhvL4KqlGJF/SPCKq6fazQO4m9PZPlPaMB9EKsMIh7BBlVUXmRtwAF3yW7uSQ1pxnxGV3rZRceI9HYDgC9UnC5xBCSNT4N3fKAQmeh5I3/s4RlolncVPn+F6Y/4jT0OG7qHqRQ2iePZejZ+ksFsP71J2fQoH1gqxryoU3dkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L9K2OaAI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fbc00143d6so4388349b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746558606; x=1747163406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7M9Vh4cA/vAEJWog9BRDwxxCIas5FuWV5Bkti2ZaSc=;
        b=L9K2OaAIKVJ8XEzNDHMNOWFDCeDWHbk7vxcjHe6TwHNTNXJiGkmBEAWJj7whlwiThs
         Knujaf2rbDwwFsqsWQYkSG4fW1+JqRjRfkC0A6jYs4roOfbr45W2viX9p54DPX80rdME
         qFQcZR97DU7ewyoIbxu64EPkkgOfzuJ2o1smoy63YmEY+0cnw5Jy5v7sDFpSZF5J/VqE
         aFuugtq/S1QQZ73qk5me4LOf/rapVVoj2CYj9782GWiqT4+6mcJ7ZhgilICEifl+K63m
         0UNrWMc/8aDGPAJ+QdxCG0AKtN5lu530l8pdjRfQuO9kc2PmxbRTXf3lJ0PNMjaQHmkr
         vsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746558606; x=1747163406;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7M9Vh4cA/vAEJWog9BRDwxxCIas5FuWV5Bkti2ZaSc=;
        b=K1jJzJYxRWF9hr9CXEF5XQbOCA4Zylgi/D7jN2MfDBX5ubr7w15ZeYyMy+3Vhbn+AT
         NmA6CoKT5xHS3TjYM+hxDjm2crgy67NeYt5fDKrO7nmlb9BthHFDInGh+b4W3h/ICSpY
         tx0UOKFV5O7Tra0ac9uM8v9hswAsy9ZCY3PVD9GA2VFWVIADjCUGN1SWFIfEdUlRyUvE
         mrw1ob8RcLKDFu1ztrTHK8M361acyofEPJk+71JnDtrckHH84BRAIHnfGM+R3EkHdDji
         EcU43/4OvjKGdy2aTUyqprKYJgn/nHa6wU5BDOL5QqR90ZejXq9LBCb7kp8FyAz7/i1K
         D0CA==
X-Forwarded-Encrypted: i=1; AJvYcCWwuaPE16yYpZ7m/pUVxYjcsbAJ0xWq/bH/eaUwvlF+dFIUCk5gT79HhHIDqrnU8GW/YgsMU8yFNok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrX1Qx4gCn//SGxBQcPojPAFSwvDn9XMtSESCFyIQsnAIr4S3
	tzm3CeAw9P608hTxo+fho/QiwLKYNpuLCEq8APpB7VjCP4sUjBI8p83u8MkNke4=
X-Gm-Gg: ASbGncua2t6vObrEi/4zqFUMMm5cv99iWpJa0QO87Im84l689nY4YwqX5fUwLYXDefX
	sC55zcMKMMq5/J+iI3CQybuzIlzO1iMNi+J681xvy3u7GC5xfhiojOqp6G31NFgIMXjRMojKbYg
	J/QMuR/KxyqPyR0BVVAs24sGXi3XBc6753luUzbBoUXYc19cf7gIOZTy+wjtAPPtu4asCQV25kx
	jhaDu6DsIgWr9IH4CrFHT81yuwcYziop6XAV9k7emNUSNPk5ZDpuyrWaX2CLhNTts1JADBQ6whn
	pi9ey1iJ1ziUwAi+qk5hnNXKEmZg+xGeeLSUSqNaalBgYQ7QLmE1Nx/ik6huWFA4WcD8+QeNk2l
	vOcXblmoTFk5RwLg1NQ==
X-Google-Smtp-Source: AGHT+IFJhJoNsdYwSL56KZvKfxZoVwS9PDEA9mN250fkyvogc1aJUfgOT11q5mMwvC2Qeq/RUXmjcg==
X-Received: by 2002:a05:6808:11cd:b0:3fe:b0ad:f927 with SMTP id 5614622812f47-4036f085567mr471124b6e.16.1746558605880;
        Tue, 06 May 2025 12:10:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5172:9f6c:997a:41ea? ([2600:8803:e7e4:1d00:5172:9f6c:997a:41ea])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4036f3b12c8sm42180b6e.49.2025.05.06.12.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 12:10:05 -0700 (PDT)
Message-ID: <64b41a31-6224-4ab7-b26d-ea3e60a60d3b@baylibre.com>
Date: Tue, 6 May 2025 14:10:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
To: 20250505170950.1d7941d0@jic23-huawei.smtp.subspace.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, Pop Paul <paul.pop@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <4493dc2e3e0fb61ba3e8a0e54571998aaaaf46c8.1745605382.git.Jonathan.Santos@analog.com>
 <20250505170950.1d7941d0@jic23-huawei>
 <aBpdDN12wdV/gOBB@JSANTO12-L01.ad.analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aBpdDN12wdV/gOBB@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 2:03 PM, Jonathan Santos wrote:
> On 05/05, Jonathan Cameron wrote:
>> On Sun, 27 Apr 2025 21:14:17 -0300
>> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
>>
> ...
>>  drivers/iio/adc/ad7768-1.c | 363 ++++++++++++++++++++++++++++++-------
>>>  1 file changed, 293 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
>>> index 10791a85d2c5..e2b8f12260a5 100644
>>> --- a/drivers/iio/adc/ad7768-1.c
>>> +++ b/drivers/iio/adc/ad7768-1.c
>>> @@ -20,6 +20,8 @@
>>>  #include <linux/regulator/driver.h>
>>>  #include <linux/sysfs.h>
>>>  #include <linux/spi/spi.h>
>>> +#include <linux/unaligned.h>
>>> +#include <linux/util_macros.h>
>>>  
>>>  #include <linux/iio/buffer.h>
>>>  #include <linux/iio/iio.h>
>>> @@ -77,7 +79,7 @@
>>>  #define AD7768_PWR_PWRMODE(x)		FIELD_PREP(AD7768_PWR_PWRMODE_MSK, x)
>>>  
>>>  /* AD7768_REG_DIGITAL_FILTER */
>>> -#define AD7768_DIG_FIL_FIL_MSK		GENMASK(6, 4)
>>> +#define AD7768_DIG_FIL_FIL_MSK		GENMASK(7, 4)
>>
>> Bug?  If so does this belong in a precursor patch?
>>
> 
> Actually not, this extra bit is to include the 60Hz rejection enable
> for sinc3 filter

Seems odd to me to group those together since they are two separate fields in
the register. It would make more sense to have a separate BIT(7) for the
EN_60HZ_REJ bit.

If we need to manipulate both at the same time in the driver, then we would
use AD7768_DIG_FIL_EN_60HZ_REJ | AD7768_DIG_FIL_FIL_MSK.

> 
>>>  #define AD7768_DIG_FIL_FIL(x)		FIELD_PREP(AD7768_DIG_FIL_FIL_MSK, x)
>>
> ...
>  


