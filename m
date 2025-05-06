Return-Path: <linux-iio+bounces-19181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C353AABB24
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C38B467C90
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17166222574;
	Tue,  6 May 2025 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYU9RDvR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762521ABD0;
	Tue,  6 May 2025 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746511427; cv=none; b=uGHtXWo8cb9lif7JAMAE+tBTOY7RmWU9DgGi/3oG8BADcaAv15PzCXUh7/+ZaP+94nfN4PyGnj1KADn4Lml24bG9HMmPdqkU2PL6MUCr/xYiFG7OQzga3TGj2T7XhMMq9y2s8wV9Dc5Q+VurNd1UzisJWqBORVOIg7BWAFxmi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746511427; c=relaxed/simple;
	bh=DR9N6LLtHjxW30A8YA8c5PfM+NMNVdzBghpvwUKjXek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebUBiy3iSKQ3KgwAknM/8+cWcW0G9VxvOW72wJBE//7wNWWYTQceVrA3xjpAqWguuIF9HgQhBbRnKmv4WzUFusN54WYUq8juIJUXmCbi3Er9dSPDjLRko9ROFaAsRDSJfY5Fbm3c2RbeSMB8ZlSDbfNU+tyXgTosN9TJl4GTJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYU9RDvR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499c5d9691so6227034e87.2;
        Mon, 05 May 2025 23:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746511424; x=1747116224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YZb/SsvKmpgl4ztaGs6og26V8j459fPhlvo52pdzBw=;
        b=QYU9RDvR7iYaq8tHtj6iX/MXjr5uU8ZEu1hB6xoz2vSa2Z19xAyhlgB+ZVyeK79RGX
         SoNzUcpdIAW2xU95t1to6XYMn/V1ndWZFFLgkeSjjpkdGaq0/hy0hGrHaaBByfgKCUvf
         ve9UUMUTZN2TW6dyRPoITS8E3V3RWi76IsoGHceZnDkW4o2KT//F3PjUz1yF1thVE/jn
         zONlzUTj/hMLFtBTRJZxYB6Xr44Eg15GLBUFFcZ2pI9ask2BJlfwP2+svESA44uENrB1
         PeqvJ33RQiJynIlppdtqoW1myZ90IwFV7sj3zFtwAdVZHrVIQSnpG9aKCpD/tYQEJ2g+
         rBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746511424; x=1747116224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YZb/SsvKmpgl4ztaGs6og26V8j459fPhlvo52pdzBw=;
        b=NfSO70V6FhpOILOYSQfhr+andw3dFTAXg5M2UPqSG0LuWaXJwZI7BHELnoDC7nH6wz
         scC8Q0gm9BQcZgQ5fUGbcTTz0P9Wour90hSjsjnhK2qomRc/pa1bA49fkfEQqNMEI/+n
         cxd/eDtd5FCa0u+wHiGBkPrJalJKJfj3G0vstItLcfutTTymIadJlX+Y3UHdGFKU3kN3
         I7NHm/xP+V5Gk5nIAzXR41AylqZGEqbffOhbuwtu6lLaz+VSpvaNDZTfP/iELQP55weD
         yHWIxM5VABncqB8uGwkJPLKm+NXfRmNMpbrmZFej5TQvuqAYCcCqm6ls2tZiA3Et+9jJ
         Iddg==
X-Forwarded-Encrypted: i=1; AJvYcCVKEgcB2XH7yOderQYZqPzphQdJyJr3FqQg4I0MUPWVU43GzVDLYx1w4/+B8yJSg/ai6CDS9IyMOPp4@vger.kernel.org, AJvYcCWfhTXiM9FRYs4km6mRea3At5AenRKUcr4qNpDRWcDzeXSt4jZy6XIt90j4hnphHKy98NP9MdDznN5/@vger.kernel.org, AJvYcCXdYwULl8MBtLJJwvGixcWxaFdgdZ2MhBU/i4Nhwwmyk1rtJ8v9mfAOQgWj31a88scNtJYgtfDfnxpOBDrv@vger.kernel.org
X-Gm-Message-State: AOJu0YwDM/enlwWXZ5V70SPp4Z9pwiZnZTTM8Kb08Xh36yY5SSrlv2r7
	1jFAzDnF7bmzVNKNaTPqSZx/3MkLC216ZNuJreUPGIM3xT0S1con
X-Gm-Gg: ASbGncsgAQLjvfbyMmrMf3nQ2LkvwNeDlGxPnh8B8rKZNozzn4T5zNqdXD8V7CbN0Qr
	F2aeI9ZimuMoirkv4U5a9XZy2nWA/I2StIfgQ9L6PEOQ4PrTuJY/fDPe89Tq2bFinK0W9lp2Q/W
	eKWbSmq0x+Yt47xTUAXexcbF8oGdPtNJMaxbLUj6soa9h3bqxrJ/6X4tslH2WDVUMVJTUYOhzEq
	5OCOqmH9NXnvFRZ6oUbvdsO+VVv5aRRGsyNm44sPZIq393Ohp97I1l2ZdXfU/VlGvlPmUlAY8hy
	7EFoyBLnKny/7hgnw7wu+bs8NDCaN5LGAm0fCqL7ItzTokZmHzMGtF1TV93UltHCgreTnpBs+ai
	sPYa0GTVUmgfHx/QM1wC8VA==
X-Google-Smtp-Source: AGHT+IFIkaTi5MhEhlnZ8Wd8d8HTx2c4HbOvpVY/oYxFl+Zijyf1n4FMaB5juvPsDNMCFPw4ntdCiA==
X-Received: by 2002:a05:6512:3993:b0:54e:819a:8323 with SMTP id 2adb3069b0e04-54fa4f905demr2680384e87.42.1746511423620;
        Mon, 05 May 2025 23:03:43 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f6cf1sm1918921e87.250.2025.05.05.23.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 23:03:42 -0700 (PDT)
Message-ID: <181472f0-5c00-4e1d-8f00-1d84b5c54685@gmail.com>
Date: Tue, 6 May 2025 09:03:41 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 subhajit.ghosh@tweaklogic.com, muditsharma.info@gmail.com,
 arthur.becker@sentec.com, ivan.orlov0322@gmail.com
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei> <Z_I-qwzUrTNz1DZp@mail.your-server.de>
 <20250406120825.41b2575c@jic23-huawei>
 <ecb2844c-feb5-47d4-b4db-12171380a9cb@gmail.com>
 <aBkNHSxU4T8j4oMT@mail.your-server.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aBkNHSxU4T8j4oMT@mail.your-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2025 22:10, Andreas Klinger wrote:
>>
>> I was CC'd due to the GTS (gain-time-scale)-helpers. The above is the beef
>> of those helpers - which, attempt to aid drivers to convert the impact of
>> the hardware gain + integration time into a single scale value. This
>> approach has some caveats, but the goal is to fulfill the expectations of
>> those user-space apps which expect only scale to change the gain, while also
>> need to have the integration time controllable (for example to reduce the
>> measurement time for one reason or another).
>>
>> Problem is that, especially when there are multiple channels with separate
>> gain control but common integration time, there will be some situations
>> where the integration time change _will_ cause changes to "total gain (E.g.
>> scale)" too. There may also be cases where some scale values can be met only
>> with certain integration times, or where a scale for a channel can't be met
>> maintaining the scale for other channels etc.
>>
>> All in all, I am not sure if the 'unchangeable hardware gain' approach makes
>> things as simple as possible - but as long as we want to have it, the GTS
>> helpers may be of use :) There are couple of drivers using them - feel free
>> to take a look. "git grep gts_ drivers/iio/light/" should point you the
>> current users.
>>
> 
> Thanks a lot for illustrating and explaining the GTS. I implemented the driver
> with GTS and by this learned a lot about it. But at the end i found it in my
> case to be simpler to implement it without GTS for some reasons:

Firstly, it's perfectly Ok to choose to not to use the GTS helpers. Yet, 
I would like to understand couple of things.

> - User wants to be able to set up the integration time as well as scale and the
>    driver should not optimize it somehow.

How does using GTS to do the conversion from
HWGAIN + time => scale
cause optimization? Or, do you just mean that part of the functionality 
provided by these helpers wouldn't be applicable, while the conversion 
could still be done?

> - There is not only a relation from the scale to the gain of the sensor but also
>    to the photodiode size. Because of this i need another helper table asize of
>    GTS for translating the scale into sensor gain and photodiode size.

I suppose that using the GTS with gains and times without PD, and then 
computing the impact of the PD size after the GTS conversions would have 
caused the available scales to be wrong, right?

Couldn't you still have used two different set of gain tables (one for 
each PD size) if you chose to use the GTS?

> I'll come up with a version 3 shortly.

I took a very quick look at the v3 - not one worth a reviewed-by :) And, 
as I wrote, I have nothing against skipping the GTS. I'm not sure the 
values in the multi-dimensional array were clear to me at a glance - but 
I assume it's lean and efficient when one wraps his head around it. So, 
I'm not trying to argue you should've used GTS - I just want to 
understand what was the exact issue with it :)


Yours,
	-- Matti

