Return-Path: <linux-iio+bounces-18812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26396AA0148
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 06:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913FD188A6A6
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378F270566;
	Tue, 29 Apr 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcsFksX9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE421E32D3;
	Tue, 29 Apr 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899858; cv=none; b=KY3ULNNqGMNPDeM51An/TT6dqFUEA+RcL16DK8aSAL+GlU8n9KnXtSUtG4S4BAFaHhuYGHStx1jVQTT7s4P6m6U58qlCgxk7y7MISaPX2SsE0kWVcmEEGgW/8lhPMMQ0zRMOtDgPy8YQRKOUuEhflweMen40gyZImfLT+q2MfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899858; c=relaxed/simple;
	bh=Ju/08vqrnEpiUQAgsbv81EOPkj0sLd/dqkoY8i6sesk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BykKlsAE8jkhf9clEJ9M4foijW/eJ08vMtM2QtsttsxceBdFeY7hB79Q9d2XTfjAgY8HuyUNm0ruYgOeklaX1p9I85GWbaU23Je870VTU/KrpWAxYYW8UDhXYz3GVdto1sgR3UYBovKQDYIi+yeYpjB4z+OzxRyJ/9gP8qMG3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcsFksX9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b10956398so6288023e87.0;
        Mon, 28 Apr 2025 21:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745899855; x=1746504655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WB+cqeimwenCq7L7/QLBCXA8KCwu4mu1U+H42Trf610=;
        b=QcsFksX9rAxRGTkX0KrWBD4hNplcvXjmOrZ4VoNGC1az3tvVsuNBePyyXGjcpfYUMA
         SiSCp2hd42l1RBX+hO1zF0c7v2tphcZgj5BzaDP6YZpG5aZlYd0Bcw0BNbQG2WmmgFqK
         M8FjUqSp8Y5jmSwybe+xGK1/J0YoqDxkd67CYN+qzBGx7wLk/bpXMzcf5+qWH2rlVNs0
         hgGAYqJBYy+EUKArvn0AQ27lFFuRt72hgfPqugSM9RCSMqOC7cR0UHSghDzNaslFR6GP
         zCuxlHUL43486sSeqta+NN/vEUHJsBAW+9twM5axIexrkPczddvMtje3sEVOUpm/Q4VT
         Hytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745899855; x=1746504655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WB+cqeimwenCq7L7/QLBCXA8KCwu4mu1U+H42Trf610=;
        b=LI0p1/FeL/oxstYBYEQ7RCtO7Yja1cGdpPytl56pxoxfOikbBW0OxJ0Ky+H04Z/4Bo
         VlefIWkMnuAFAZNZSYrsfQYD5YbQheE0rWMCjL1lS/H4woO3P4Lsffd+Op4C25Khn1kr
         WQZiKOE42UBa13Tengz/r9PHjCSWLkCRtcSi7yL1pZhaJUW0yQc5o21PVqe4pZpwk5Tv
         1QxNgzal9s036ReUB50K/9jRBa0hr022M19dfmTd7UR1kOERs/dkWbeVEgZg0KXQ7lBK
         G/+EHE/63gg7CpffDRjP0FINuCBaf7f0k/kv/KmAKTY0mCClW6oB82ZaReb70hrn3pNz
         2xtA==
X-Forwarded-Encrypted: i=1; AJvYcCWqtJidmJUO9z07wTyvx52kmV6rH99SGyMZzv1VBxmdBokBxchvKlfCwWZrl8mueUG57/jxwAUWe68=@vger.kernel.org, AJvYcCXOYC7PbeAZA5rfqOqMQs4y8Xyi3QxMYc9N4HOVd2KqBEJFpVUkNczzbuPLJwCBjwLgG9xejLcHhgkgcAvk@vger.kernel.org
X-Gm-Message-State: AOJu0YyAC7C4ow8jliUrLDyiPMtc7F128U2QsBKvlpGMYtxgiULZ5lrb
	dp+mGIYduqdx+pDegFKViOZ2tpo5zu8tH7OCl6g1ToRj9Xfram01
X-Gm-Gg: ASbGncvjeTOE33vwvLC7J2KWQfPM9hf75zgraygAWAds1dMSWohYPeSIAXAUNfjLfUj
	7ym/camMvu+ZSY2KWsC1AXf5A/FPmsbpoT40aV/paJcomLJXbI4+n9aImvw88okZ7yYkjxr+ks1
	xwYqccE/Vf9pMnYHi0vGEmrqNd39VSO1YuxbpkhhazANBmgLlFKgtehFyZSvuvZ3CQbfbxUDzQi
	tvCAx7GtsHn5IUyh5E0SogMMObJFfHKItk6D3OJ3STATyfu/mz+esFlQ5ctud2/PN3CoA/Eq8/M
	BB5npuLwrsGm49Fx6GAgHZ1bpHqJtr9VIBtNYq8ZzPBRSEx+Pf6cDitY+lgzoUdI9iz38k5Hdr5
	NkMEgPKQizD0EThr2k2q2DQ==
X-Google-Smtp-Source: AGHT+IEPFRl30BuyC77X8oD2m4RqzMlO7bZdHdra+WGqHTZCNfn9O0MiguPoJvpXWPticCD77ibFSA==
X-Received: by 2002:a05:6512:3dab:b0:54b:117f:686f with SMTP id 2adb3069b0e04-54e9e1955f9mr403491e87.28.1745899854637;
        Mon, 28 Apr 2025 21:10:54 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb3983fsm1789040e87.60.2025.04.28.21.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 21:10:54 -0700 (PDT)
Message-ID: <24baabd6-384d-472a-8e8e-96b59ad8840a@gmail.com>
Date: Tue, 29 Apr 2025 07:10:52 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
 <b7adef4b-68ae-4a49-937b-307e116976f4@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b7adef4b-68ae-4a49-937b-307e116976f4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/04/2025 18:16, David Lechner wrote:
> On 4/28/25 2:02 AM, Matti Vaittinen wrote:
>> According to Jonathan, variable reference voltages are very rare. It is
>> unlikely it is needed, and supporting it makes the code a bit more
>> complex.
>>
>> Simplify the driver and drop the variable vref support.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
>> @@ -183,17 +173,14 @@ static int adc128_probe(struct spi_device *spi)
>>   	indio_dev->channels = config->channels;
>>   	indio_dev->num_channels = config->num_channels;
>>   
>> -	adc->reg = devm_regulator_get(&spi->dev, config->refname);
>> -	if (IS_ERR(adc->reg))
>> -		return PTR_ERR(adc->reg);
>> -
>> -	ret = regulator_enable(adc->reg);
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev,
>> +							   config->refname);
> 
> Is this properly aligned to the opening "("?

Thanks David. No, it's off by one tab. Nicely spotted :)

Yours,
	-- Matti


