Return-Path: <linux-iio+bounces-9383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9289718D5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2EAB2109F
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636EA1B6541;
	Mon,  9 Sep 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pgCg3Uqk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA513BAF1
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883179; cv=none; b=szfFzgPwfViKiIc3kpr0fVIrCoOxTIGXNVh2DhEp5fZxaJUSzcuWWdGO4u+I9RRZ9SW0lUJSsSl50lKl1w4aV9EgRLEicgPA6k2I30U3dSQ4ubSQNNKUdYYYFZdHjUBeaeLQ+rWVJys3GGOnrYq0xj07JA4FbUgI3wGrEL4IYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883179; c=relaxed/simple;
	bh=1vjnXPbLxhRpE+whIOcxqFDXdF4eCnvkiq4k65c/DfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVK0KMxmB1vgnPkw8QQhqFefTyKxBJYqGQcYvpxqsEPgpW10lN92Rx2R0a4Foq/mToygg97bUHp4AebXwogGtexDo14zrBo2flBv/8v2gdrPmYN8uru06t/TFpM3mPhy98jvRu/3lKjhdl3VD1kC3/iMGAl4cP/r2r9HUIKtmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pgCg3Uqk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso3276775e9.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2024 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725883175; x=1726487975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gY+wQ/hbSOiLIo35yrkuPQh1uhW74qHV1z8U7bAiFOs=;
        b=pgCg3Uqk73JJnlduGEXptoCTuLRMnCgfiVPXAlM5TG/TRwlHmED1ZyPlS2Z4vztfQn
         XVy1SmmjES9h9UvzcGzAJHYdEn1jY0YGuHA0e60RV0XvmE5fWwROeEKRJGrlZU9aAouC
         0u7pw6KUQMjmGwnXew9UhNd95C2Gojl9FhL3giChLIkzVWIBDV8s4EGbD2W9JfF17Bc0
         dy8Cg6k0KpguO6lGke1um2spQpTn6aBVraGZ9qusWY0UUO2MnmolFAVx+HV6BzO4RlSt
         Snn/uOH6lIuE8TP6ZfvjdVVMJtDFLcmMzG6A2ao7rEJiAjRCCA5z4EOLSqPPQ16TSidM
         gk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725883175; x=1726487975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY+wQ/hbSOiLIo35yrkuPQh1uhW74qHV1z8U7bAiFOs=;
        b=GDPNoRV6V419RQDNPTV7gpH1wVDYsGAa6kRcbgLCuqmFvENWDDawmTHON+woX6Q1Ya
         zZl0uQxwLcv6Cw3ZOhSLjqgeWhKvKSk6PfwLXJ9RI1jehhWXrg6xsaRbHD0BsHVJiGQr
         o3PGgafrbaVNF7N0/6t7ZLRH4HQr7+cwD2F6FK0fO2FbqgDh5D/MhX+iC/K3VgRhbSnY
         +IJLx9SGSSdfpjLDZFjGk5GWhEuMydifttkKfCcP/L34SYetD2CusBmlB2kMmR+H+I+r
         FJ57dlqAnfQTBulqLFHCvmfKG0AZONyNdyZrwqPm00Ei2vqTvc5TOJ6J2et893Vj6RvH
         YBuw==
X-Forwarded-Encrypted: i=1; AJvYcCUeF/Sf5nFfk10DDHqcdxWGAeyhO/S2a9EW+Nn31OWfHeZ4fYpLSYYlwgLLDmrTcH83m+BDfBO5xAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMd5XV/UTdCxCaSmLvlL++3AheY0PPdgFnlCSYzGZcDjZHZNM
	roa9agDdJ7QV0BMkzQ9ew5qoyTMY9w3rN9nvpE2w1597QycIeGNbQk0GPAbQlsw=
X-Google-Smtp-Source: AGHT+IF2HO2j27LPcok9hfnl2YRG0k6sXxiEdy/SmiEiehzZGfpm1xS7B5hiJtlNIbEpebdfH+HoGA==
X-Received: by 2002:a05:600c:54c6:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-42cb22effb5mr38710335e9.21.1725883174571;
        Mon, 09 Sep 2024 04:59:34 -0700 (PDT)
Received: from [192.168.0.2] (host-79-54-235-146.retail.telecomitalia.it. [79.54.235.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb818b6sm75399365e9.38.2024.09.09.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 04:59:33 -0700 (PDT)
Message-ID: <6cb0983b-8bef-4091-b5c4-5734ed97db52@baylibre.com>
Date: Mon, 9 Sep 2024 13:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] iio: backend: extend features
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-2-87d669674c00@baylibre.com>
 <20240908133852.2599297a@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240908133852.2599297a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/09/24 2:38 PM, Jonathan Cameron wrote:
> On Thu, 05 Sep 2024 17:17:32 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Extend backend features with new calls needed later on this
>> patchset from axi version of ad3552r.
>>
>> A bus type property has been added to the devicetree to
>> inform the backend about the type of bus (interface) in use
>> bu the IP.
>>
>> The follwoing calls are added:
>>
>> iio_backend_ext_sync_enable
>> 	enable synchronize channels on external trigger
>> iio_backend_ext_sync_disable
>> 	disable synchronize channels on external trigger
>> iio_backend_ddr_enable
>> 	enable ddr bus transfer
>> iio_backend_ddr_disable
>> 	disable ddr bus transfer
>> iio_backend_set_bus_mode
>> 	select the type of bus, so that specific read / write
>> 	operations are performed accordingly
>> iio_backend_buffer_enable
>> 	enable buffer
>> iio_backend_buffer_disable
>> 	disable buffer
>> iio_backend_data_transfer_addr
>> 	define the target register address where the DAC sample
>> 	will be written.
>> iio_backend_bus_reg_read
>> 	generic bus read, bus-type dependent
>> iio_backend_bus_read_write
>> 	generic bus write, bus-type dependent
> The RAMP_16 definition doesn't seem immediately connected to the rest.
> + I'm not sure what it is from the name.

It's a 16bit ramp that the backend is able to generate internally,
can be used for testing.

I changed the name to

IIO_BACKEND_INTERNAL_RAMP_16BIT


>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>>   drivers/iio/industrialio-backend.c | 157 +++++++++++++++++++++++++++++++++++++
>>   include/linux/iio/backend.h        |  33 ++++++++
>>   2 files changed, 190 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>> index 20b3b5212da7..231bef4b560e 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -718,6 +718,163 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>>   	return 0;
>>   }
>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
>> index 37d56914d485..eb8c5bb74bb5 100644
>> --- a/include/linux/iio/backend.h
>> +++ b/include/linux/iio/backend.h
>>   
>>   enum iio_backend_data_source {
>>   	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
>>   	IIO_BACKEND_EXTERNAL,
>> +	IIO_BACKEND_INTERNAL_RAMP_16,
> Not obvious what this is so maybe this enum needs docs in general.
>
>>   	IIO_BACKEND_DATA_SOURCE_MAX
>>   };

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


