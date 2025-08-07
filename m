Return-Path: <linux-iio+bounces-22374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF2B1D34C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361B66240F7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B9723A58B;
	Thu,  7 Aug 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpICj5u6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4523184F;
	Thu,  7 Aug 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551671; cv=none; b=rtPjD8gVG+1KYx2o3EMhkuUoMBZz923r4EJdsUFOOStViIkkh1o6A67J7AlZ9wfu1o+SDMoJE/x28inuZrFbnUh0lQZY1gvzPS8LZCJeOccIW7IKK//PRjx6aNJjDcO6dQvkhdA9MUvniFTyinlevHnLa/KnQvntr1xOC/+5Kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551671; c=relaxed/simple;
	bh=SkTxJog/uq/QRE+prVJuk5pif6ZAmTcZRuXi/8ThBmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8rZsLfXojxHy08NhGV+yhu0tt3/rXhKPk9Qx3kk9Oe8wbdRBSqSDRVEN+xOWpCDqyDmWJ6/wYTkqGI/izGZYFe8UwiuL+xNJZA46bOy81Vu2WdNQJzQGTJnPibOIbvnwS+G/gcroMCv0tYkv/+B3zYcSL8XflVOe0z1rK01zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpICj5u6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55b79ea50f8so724571e87.0;
        Thu, 07 Aug 2025 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754551667; x=1755156467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPSZZvxQDM62BTi58d+C2YdbP59VdukNodMsPczgmyk=;
        b=YpICj5u6bCC/R96cU8bE+2QEv9p5/2wNJ15RhzK7IOBd0kIzRJMaaJfGRkABbwykwn
         qw11aQxe/gj28p9T6ztzQvrl36zaZE05KAmx4mqglZk4KvSQyCdynPJkS6I+43LX1nWE
         me/+97PLmm3wN2StsBBGdBMa8NgrtukC6aAkFwVx4kuo62o8vKXp9uo/4hyI+ebdeb7M
         4EAD8u1xnxKNMg7qoiMg06SwcHyzenLZUxTWVMCXh3JAZ0de+EiPULnTmJl7VrRAtb4J
         UiqtAYQrHbRVjCak+dt5uKkaa5VMbAMnMHQK5vRExvl4cnGD+sDTOl5glBaopAv4Ezr6
         4eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754551667; x=1755156467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPSZZvxQDM62BTi58d+C2YdbP59VdukNodMsPczgmyk=;
        b=U5mFjKCjiiM27oEPnliKJbep1yHk6REFobWnBQKzAceVhF1r+zqQfzlA3mXUMOTJtv
         3OKW031nxcOvNNA7V8cuoTM1nU7QG4d10mfdmkCCbpQRhFus4Fy8K3OYYetwoTtwkEuA
         Rqv2o2sfRp0umO0k9RD4qZZNFmiMxuXGJUmx54yAc0kS59WNiV8gJVN4JXFeHk2rHxVN
         31q4KHkzFFg0Ccx/84JUZT2llAm2YgnEtpfr45Ptzdoyz2vSQgylj/qianW36QAgGw9K
         BcL+6tGqAcHppJln2dLbKv2N4+ypNM4tzNoXKODVmvFnDxJVtHHLp9+NbDF4+ZOMjy9J
         mxwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0zhCJnGbB9iEE/NB4RZsZVMJjb4Yqa5ZhrvJCh8GRWc9Vr/dG95SJmfaQjxQh0DW4vWkyF0nVQvv3wTXb@vger.kernel.org, AJvYcCUkd4x73Kj43RDJGQ9WNflYi2LvY6ZE6j20HdTIZFlosbriUQm8etLG0ah2/UfiTJRnTld/bzpjYjzT@vger.kernel.org, AJvYcCX83uPIbxAoTcNpaTwboA+Np3evThOQjlr2eoI3ikYhALY22sw6o04OPvFY7lnT63VZGVx7ry4REAOL@vger.kernel.org
X-Gm-Message-State: AOJu0YwbbmLt8gYeEKBFTYS/s8ikDwVpJDF7RtLwWrQnNGAFVdsuxehG
	lge9N5UKOY5CAqPn92YWbhyWmyxeZ2b5gOH/5lS0veNcdegGhpH6l6dL
X-Gm-Gg: ASbGncuoKMLO/QWYAHye0N21uuMFN05gaNDM1WHJYXbEvjURVp1Pf/X0KIQV+jENpJ4
	umIEPpH6MJe9rtLu5+PembnV5NDxHJ+10zmWuf6RHl2af7VHeXQLh5mJRUOxJqNRPN/wJFEAATc
	CCpQf3AlRqvNM0JxqFL/H3xNnjmWnh3QwDg79ueEbU1bCjwfMa4grr37LUeGmjsMymEHmI008m6
	sWwzTqRtOn/d9IzW4jwnV3kJzryeXFAWj/KDfFZPrUS9dKiAtoyTSh1cv0vJZvY2oMPawoPjd7r
	4eFR/ymgDwGxuVRVbHDoQ3omKJMKNeIMoJNv/I6JBh25VIwUiSIZIivC7V6k4v4wHBibEP84VJZ
	HBeXvHWU8TuHUc1A1PbC8TEqymdXrecjScBWgQbpxdSKk2twwlQUV5AFbVbOY49yJY7L+fv79Xd
	bh1qM=
X-Google-Smtp-Source: AGHT+IFtNR3rD4cKL88Zn6DvBYwzPeOYKFCM/K9IqHwK1lJTV9U815Mj9adWiw1lo33yAzgi1rOd4A==
X-Received: by 2002:a05:6512:1584:b0:55b:885b:1ef2 with SMTP id 2adb3069b0e04-55caf385f5dmr1859047e87.54.1754551667009;
        Thu, 07 Aug 2025 00:27:47 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c8dsm2525236e87.90.2025.08.07.00.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 00:27:46 -0700 (PDT)
Message-ID: <f33a391b-e7b1-422d-b265-4f00db3b9634@gmail.com>
Date: Thu, 7 Aug 2025 10:27:45 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: adc: ad7476: Support ROHM BD79105
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
 <629801b8-a647-442b-83ba-6328ecf7a977@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <629801b8-a647-442b-83ba-6328ecf7a977@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks again David.

On 06/08/2025 18:23, David Lechner wrote:
> On 8/6/25 2:04 AM, Matti Vaittinen wrote:
>> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
>>
>> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
>> conversion. Unlike with the ad7091 and ad7091r which also have a
>> CONVSTART pin, the BD79105 requires that the pin must remain high also
>> for the duration of the SPI access.
>>
>> (*) Couple of words about the SPI. The BD79105 has pins named as
>> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
>> ISO.
>>
>> DIN is a signal which can be used as a chip-select. When DIN is pulled
>> low, the ADC will output the completed measurement via DOUT as SCLK is
>> clocked. According to the data-sheet, the DIN can also be used for
>> daisy-chaining multiple ADCs. Also, DOUT can be used also for a
> 
> Leave out one of the "also"s.
> 
>> 'data-ready' -IRQ. These modes aren't supported by this driver.
>>
>> Support reading ADC scale and data from the BD79105 using SPI, when DIN
>> is used as a chip-select.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/iio/adc/ad7476.c | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>> index 1f736be09663..fc98aadc4077 100644
>> --- a/drivers/iio/adc/ad7476.c
>> +++ b/drivers/iio/adc/ad7476.c

...

>> +
>> +static void bd79105_convst_enable(struct ad7476_state *st)
>> +{
>> +	if (!st->convst_gpio)
>> +		return;
>> +
>> +	gpiod_set_value(st->convst_gpio, 1);
>> +	udelay(1); /* 10ns required for conversion */
> 
> So ndelay(10)?

Thanks for pointing this out. This delay was something I thought I must 
clarify! This 10nS comment got just copied from the existing convstart, 
it probably is wrong for the bd79105.

...
  >>   	st->xfer.rx_buf = &st->data;
>>   	st->xfer.len = indio_dev->channels[0].scan_type.storagebits / 8;
>>   
>> @@ -393,6 +426,7 @@ static const struct spi_device_id ad7476_id[] = {
>>   	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
>>   	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
>>   	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
>> +	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
>>   	/*
>>   	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
>>   	 * point of view. The binding document mandates the ADS7866 to be
> 
> Unrelated to this patch, but interesting that we don't also have
> an of_ lookup table.

I am not sure what is the value of having the of_match table with the 
SPI devices. The SPI-ID will in any case be required for the module 
loading, and it can be built based on the DT compatible.

I admit I don't really know all the dirty details but, from what I can 
say, the only potential use would be if this driver supported two 
variants (which needed to be distinguished) with identical 
chip-compatible but different vendor part. I accept all education (also) 
on this matter though :)

Yours,
	-- Matti

