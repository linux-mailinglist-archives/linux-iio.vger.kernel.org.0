Return-Path: <linux-iio+bounces-5671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C988D7FCC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220EB1C2298D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575F80039;
	Mon,  3 Jun 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZeaB8o4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2837FBA3;
	Mon,  3 Jun 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409499; cv=none; b=DKyTQCfX3vefzPTmOLZSKNA9kLFC80VhEHutFg5RIF0KWEX6nAyXQHozoRQz/DF7oUQEu+rl6JtN9QHDiia8Uez4RtF0RDUS4/cSDsVCx2cJ2WKdy4bXzcbWl/n0xLsMPyP2XkAcA0Udv8dMyfWQGDw2hZQDMcM7kOUzUOWYQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409499; c=relaxed/simple;
	bh=N2+1b4UvL2h8BghC0xvtCBiF9o0kiifts/5HQ9Tplak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULFA4yROkkgohKp3Bi7CYS/QqZcGwB5DKeQzLtDK1qNf1ABMCOx0q5o3cb5++/k+86R/6Iu5CCs8bYcr408+47eKsDL1seMPy29oGPAP3DCJmRxqgu7YkfMHh54OukpFrM5BeDHEnQ+jBisOgbEWbBc64grAtAoUv8E7XdPVm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZeaB8o4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b7c82e39eso4067869e87.1;
        Mon, 03 Jun 2024 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717409496; x=1718014296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NGoqdJtENVZUa+qRol7I9OdMjwyIhmPcJwjIRPRNrg=;
        b=XZeaB8o4EHXFcVFqoWwd4v9wFAZ+pnYoVf4lodcMzCoEhkpFTSS2lO0zkeFPCgBCXo
         LjVPW5t8o2NMnmR5YIubJw0bIzsxbGB6GJ7zMAG1hBIxnK44gzm4b92XFhWI56mLoAly
         8rF/YPJL/cgUgTikV5hZZ7BrJfoVfqJjlbm2g23sMQjHjfEtMmguvUN5NM8bKa96BJEM
         C+8u7Uu+rrxbzw0pPHCdB4ZxM7PYpoiNV+6i32W7km/IR4IznTU1Xa0CeVNa81MDalMM
         HTvTPazPJnCRF3uww74aN6JNGLMCoeHHcU4nzm7sDt7xPv2Rr3sxksfZQSB4WHviIrjo
         ftKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717409496; x=1718014296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NGoqdJtENVZUa+qRol7I9OdMjwyIhmPcJwjIRPRNrg=;
        b=WZVqNqfaH/LZNtu/Pe+DvXdvm659mx3ea2MDEdjTSsWnDPiyNZvYjjWKdtf9NuAwkF
         KIIKp1tilbjnu3+fBcgvGDDu+ND9++4EYLmtTlClP3J1SLk48L1mldvlQgcmgUY7Znue
         nDCgrOFsS7QTXFhmxdQt/y9lT8G9/3T7QAkqiAeWpscXJxGm1AyzeZiW6lUdH+FDXUxi
         aaK2freCyPf06s1JFoPq6AVlV5+NAfJToUiQznB+MF67dtJWxYbCqp2qMW84Ln6htTHD
         fheE/Y/z9XM7mxtlyU8bV86Bswxpe2WLBTEjt31o77VmH/3piy5FMy+DRZeNQxjL68uS
         d+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkvZlU3s/A1SFQGDhNBy2sNx0Fhb5jo6LnH3GGIYUW95teErPtdsqx8ouXULNpYrhucxvjy6ax95Jkh/y+/J+XvZinsLRQbVxiS+AoN72L3gVFQbTA2Nkx4gWEyVfN53qyBqmuRD9vS7Kx2LP2iuYEgsHBuW3Uf9w+tQTxwET0IUiKXg==
X-Gm-Message-State: AOJu0YwGHZt32o09C8fSkFcRiaGUFmw6naZjA5LzdRWtCZ5YEOt0X3wt
	juOQSkqiOXdbOdeorh1q5L7D53MPgY0UdcFZ48SCJC6qPdgI2etQ
X-Google-Smtp-Source: AGHT+IEcX9mOOMxH+a53YuuVbcvysJP9F7UT5wYgpTKNO0VJka12hKDGJZvicsmRPhRtvDwuSYpSyg==
X-Received: by 2002:a19:9111:0:b0:52a:5fa8:d565 with SMTP id 2adb3069b0e04-52b896dad9cmr6184155e87.68.1717409495155;
        Mon, 03 Jun 2024 03:11:35 -0700 (PDT)
Received: from [10.76.84.176] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f1797afbsm222711966b.40.2024.06.03.03.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 03:11:34 -0700 (PDT)
Message-ID: <93ebe75b-5a7d-4d69-9515-7cbeb66c8e7e@gmail.com>
Date: Mon, 3 Jun 2024 13:11:33 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] iio: adc: ad7173: Add support for AD411x devices
To: Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
 <20240531-ad4111-v4-6-64607301c057@analog.com>
 <20240601201912.32fe3524@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240601201912.32fe3524@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/06/2024 22:19, Jonathan Cameron wrote:
> On Fri, 31 May 2024 22:42:32 +0300
> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> 
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>>
>> The AD411X family encompasses a series of low power, low noise, 24-bit,
>> sigma-delta analog-to-digital converters that offer a versatile range of
>> specifications.
>>
>> This family of ADCs integrates an analog front end suitable for processing
>> both fully differential and single-ended, bipolar voltage inputs
>> addressing a wide array of industrial and instrumentation requirements.
>>
>> - All ADCs have inputs with a precision voltage divider with a division
>>   ratio of 10.
>> - AD4116 has 5 low level inputs without a voltage divider.
>> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>>   shunt resistor.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> Hi Dumitru,
> 
> A follow on comment on the validation code.
> Also there is some good docs for the sampling frequency but are they
> actually related to the rest of this change?  They also raise
> questions about ABI compliance that we may want to deal with as
> a follow up patch.
> 
> A few other trivial things inline.
> 
> This is looking pretty good, so hopefully we'll get the last few corners
> sorted in v5.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> ---
>>  drivers/iio/adc/ad7173.c | 336 +++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 307 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index ed8ff8c5f343..91ff984eedf4 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -1,8 +1,9 @@
> 
>>  #define AD7173_INTERFACE_DATA_STAT	BIT(6)
>> @@ -125,26 +132,46 @@
>>  #define AD7173_VOLTAGE_INT_REF_uV	2500000
>>  #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
>>  #define AD7177_ODR_START_VALUE		0x07
>> +#define AD4111_SHUNT_RESISTOR_OHM	50
>> +#define AD4111_DIVIDER_RATIO		10
>> +#define AD411X_VCOM_INPUT		0X10
> 
> AD4111_VCOM_INPUT . Looks like one wildcard escaped an earlier edit?
> 
>> +#define AD4111_CURRENT_CHAN_CUTOFF	16
>>  
>> @@ -736,6 +918,21 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
>>  		return ret;
>>  
>>  	switch (info) {
>> +	/*
>> +	 * This attribute sets the sampling frequency to each channel individually.
> 
> frequency for each channel?
> 
>> +	 * There are no issues for raw or buffered reads of an individual channel.
>> +	 *
>> +	 * When multiple channels are enabled in buffered mode, the effective
>> +	 * sampling rate of a channel is lowered in correlation to the number
>> +	 * of channels enabled and the sampling rate of the other channels.
>> +	 *
>> +	 * Example: 3 channels enabled with rates CH1:6211sps CH2,CH3:10sps
>> +	 * While the reading of CH1 takes only 0.16ms, the reading of CH2 and CH3
>> +	 * will take 100ms each.
>> +	 *
>> +	 * This will cause the reading of CH1 to be actually done once every
>> +	 * 200.16ms, an effective rate of 4.99sps.
> 
> Hmm. This is a bit unfortunate as if I understand correctly that's not really what
> people will expect when they configure the sampling frequency.  However I can't immediately
> think of a better solution.  You could let userspace write a value that is cached
> then attempt to get as near as possible as channels are enabled.
> 
> Still this looks like a documentation enhancement of existing behavior
> in which case any functional change can be in a future patch.
> However I don't think the docs update belongs in this patch unless
> I'm missing some reason for it?
>

Well, it would seem like this exact behaviour is already documented:

 "
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
 KernelVersion:	5.20
 Contact:	linux-iio@vger.kernel.org
 Description:
		Some devices have separate controls of sampling frequency for
		individual channels. If multiple channels are enabled in a scan,
		then the sampling_frequency of the scan may be computed from the
		per channel sampling frequencies.
 "
Does it still make sense to keep this comment here? But if kept, yeah, a different patch

...

