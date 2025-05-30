Return-Path: <linux-iio+bounces-20037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63345AC9089
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573731BA1200
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0149E21770A;
	Fri, 30 May 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AdautNmN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FF17B505
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612953; cv=none; b=hFAYMx6733BNZFKAh6URnqOCcBuXcD9MhS0M/WuDz/4zA8rQtXnT+fBqEj1FtcDPRIibzoVeztfK3zGFV3R1d5CU3KzpoE+a5T6ChAqLPzcdwEOGI1C/ALpFJxry09wMhMxxuTtbcKi/IV3DNspFP+qpRfwgTgeEY5WV6W6zXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612953; c=relaxed/simple;
	bh=9Mq5hZOOvW2ZFf69WJb4Ff0N/Ky1FM83I7pmjlJ4tUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDBBuIT3nOmF6kBaJld4FY2yy/soP/w8q1Yo1zlOtTzW/3VmzJnfIlBMPEUi2YijiaudhFC/iBIveWkFY2FN7AGwGUlH6vQCQucQfhPhTv3GWKRVTsHYotSdMRH3CucThzRtk9i3EF1ETkpQf4S03VdgRSNF/utwfDS5gVLDMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AdautNmN; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-605ff8aa9d2so554316eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748612949; x=1749217749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tme1pCrZrM2VXTRq9FlVTDLE9dpQsp+tmaK/1R+aVG0=;
        b=AdautNmNSb+kNQOBVfHwtvT+YM6HxbDWWEXal+gk2zjuMnae8JNvEH+hpsoWSpL1Ye
         waoaFCpa0XX2gxVUViD1TmeP9v490GvbZgyVmtqPqyWVYwEyGK2OT8npB+VIH0njrp48
         iM6ZoGPAyibnBYA8ylk4BjVFs6x49vdui03xmO9MXFfPylO3Z5BSWSBm0yRAJrvXMNyS
         czsqhfYde+y7YTcR5F6efr8R9+kTrQXmbSgEBZaTs8WJxl++2OaSYmwNGBU8rf8g+ke0
         i6DYbH414fgYqklu8TOA/lEjlNqAYXJBCr9SvyfD9sVzIo7eyRFpPe5RrO/rSor9L/5o
         zxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748612949; x=1749217749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tme1pCrZrM2VXTRq9FlVTDLE9dpQsp+tmaK/1R+aVG0=;
        b=wgcYaJ8X3AkUSBlTzWWnXnqzjnAU2sJRU9I96CoROUdJAGEFIcPKhfzpbDuEPG9lRn
         CHKYSqoZnzSOCCDBOl7DtBK6MsgnB1IiJ/JLLvfNBDIlz4lpPZWfX0mfKiwu16M7Xt6n
         ZgNmIBn0hcqvwlvHoJlk86UrpaheQIcvISN5x+zFWLyVfPs541fYpZGDF1Op7oTo6cDq
         CApwhE7r6V8IfyXL4jusVYpPwdUA50nWtB8G4ZW/693tm0qrr5EsVlokE1v0FgEsDtLj
         e2+/OMQ5bMdqtld51+GmB9yvR7ZnLvsEPSSwotEuS6GZ+E4yoXRAgGsw3o+Nr0l0OCp2
         JtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa0dqg0zqfwkQEVFqwXQ5rv7NU7n1WoNj52nIAQitZyUjMRu9xz1NZz2JtFGZf9zRSkXXt0ypfQYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSLN3u1/Tp96sibQzxagi5eybzlLZqIlTn4dX5Xld+CLjN4s6
	CX46MbQVmT88CpEVr3UeSk7iXjS8ZNGB52hfWnJ2kqB+hEERhlkbh26Wyjm9jOD63qA=
X-Gm-Gg: ASbGnctfJeoLj06uw/HhLD/jGPxqueew8HkRLlyUEvwKSjgrIYfKfzCW5Mhf4qIii2U
	8j23ynDrlEj95MMuJ8mtJIdNvSDiN9yPpN8f8husugfMQKPNlJ/NWxVFwRCpxqdQxneaNqMLGQr
	I+baQeWaOsBxyQfoCwRz7520zVO9UDGjhiE0owlgegNWc1V1Mi0eDvWh8JXbUoymcUC8TAk85U0
	lxJGESElqpqsj0MzPPeIL3Ychsuxpm6/v3/KEQj1UsUuDGzAAYMO2jPXuYQlEX+SRR41AvA1zDV
	wYBhckJM5OLXSSAF35Vn/uUWHs/w1ZTHQuVSsbOujEI1jZcbr0x5MAjPtJUGoTydCbDEaiEuyl/
	oTMi/mzkLi1zbGSskGyj1Rwkul0Wu
X-Google-Smtp-Source: AGHT+IGSeNzdLtM8Wcq3bN9hHuw1X1n/uK7UqEskLwhdNIeOIspP/rFrJu1kmWlprYDK4upeBv0Wxg==
X-Received: by 2002:a05:6820:98b:b0:60b:edbb:1f50 with SMTP id 006d021491bc7-60d52d6db2fmr1085212eaf.4.1748612948983;
        Fri, 30 May 2025 06:49:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60c14c8ae0asm392439eaf.20.2025.05.30.06.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 06:49:08 -0700 (PDT)
Message-ID: <9ed23409-f402-4d08-ad59-af8ac48d88d2@baylibre.com>
Date: Fri, 30 May 2025 08:49:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad7606: add enabling of optional Vrefin
 voltage
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
 <20250529-wip-bl-ad7606-reference-voltages-v1-2-9b8f16ef0f20@baylibre.com>
 <521f5868-5836-47d9-9a68-88a9d4e843f6@baylibre.com>
 <dv72cvn7rihavqxg6wnybhedhunabo7bremwb5pkutqljwarcf@eo6zc7vi7fbu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <dv72cvn7rihavqxg6wnybhedhunabo7bremwb5pkutqljwarcf@eo6zc7vi7fbu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 2:39 AM, Angelo Dureghello wrote:
> On 29.05.2025 12:52, David Lechner wrote:
>> On 5/29/25 4:13 AM, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>> Add optional refin voltage enabling. The property "refin-supply" is
>>> already available and optional in the current fdt dt_schema.
>>>
>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>> ---
>>>  drivers/iio/adc/ad7606.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
>>> index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..21e63260965c32988d0ab3b8bb1201aa2396f1ba 100644
>>> --- a/drivers/iio/adc/ad7606.c
>>> +++ b/drivers/iio/adc/ad7606.c
>>> @@ -1335,6 +1335,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>>>  		return dev_err_probe(dev, ret,
>>>  				     "Failed to enable Vdrive supply\n");
>>>  
>>> +	ret = devm_regulator_get_enable_optional(dev, "refin");
>>> +	if (ret < 0 && ret != -ENODEV)
>>
>> < 0 is probably not needed.
>>
> The above code looks correct to me. What is the issue ?

Like Nuno said, it can't be > 0, so if (ret && ret != -ENODEV)

>  
>>> +		return dev_err_probe(dev, ret, "failed to get refin voltage\n");
>>
>> We aren't reading the voltage, so the message doesn't make sense.
>>
> Is it better a 
> "failed to get refin-supply\n" or
> "failed to enable refin voltage\n"

I would make the message the same as Vdrive.

 "Failed to enable REFIN supply\n");

> 
> ?
> 
>>> +
>>>  	st->chip_info = chip_info;
>>>  
>>>  	if (st->chip_info->oversampling_num) {
>>>
>>
> Regards,
> angelo


